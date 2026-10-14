import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../data/app_database.dart';

typedef _Json = Map<String, dynamic>;

class _Entity {
  const _Entity({required this.collection, required this.exportAll, required this.exportOne, required this.apply});

  final String collection;
  final Future<List<_Json>> Function(AppDatabase db) exportAll;
  final Future<_Json?> Function(AppDatabase db, String id) exportOne;
  final Future<void> Function(AppDatabase db, _Json json) apply;
}

_Entity _entity<T extends Table, D extends DataClass>({
  required String collection,
  required TableInfo<T, D> Function(AppDatabase db) table,
  required D Function(_Json json) fromJson,
  required DateTime Function(D row) updatedAt,
  required Future<void> Function(AppDatabase db, D row) upsert,
}) {
  Future<D?> findLocal(AppDatabase db, String id) {
    final info = table(db);
    final idColumn = info.columnsByName['id']! as GeneratedColumn<String>;
    return (db.select(info)..where((_) => idColumn.equals(id))).getSingleOrNull();
  }

  return _Entity(
    collection: collection,
    exportAll: (db) async => (await db.select(table(db)).get()).map((row) => row.toJson()).toList(),
    exportOne: (db, id) async => (await findLocal(db, id))?.toJson(),
    apply: (db, json) async {
      final remote = fromJson(json);
      final local = await findLocal(db, json['id'] as String);
      if (local != null && !updatedAt(remote).isAfter(updatedAt(local))) return;
      await upsert(db, remote);
    },
  );
}

/// Sincronizează baza locală (SQLite) cu Firestore: trimite coada de modificări și aplică modificările venite de la celelalte device-uri.
class SyncService {
  SyncService({required this.database, required this.farmId, FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final AppDatabase database;
  final String farmId;
  final FirebaseFirestore _firestore;

  final _subscriptions = <StreamSubscription<Object?>>[];
  Timer? _retryTimer;
  Future<void> _applyChain = Future<void>.value();
  bool _pushing = false;
  bool _pushAgain = false;
  bool _stopped = false;

  static final _animals = _entity<$AnimalsTable, Animal>(
    collection: 'animals',
    table: (db) => db.animals,
    fromJson: Animal.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.animals).insertOnConflictUpdate(row),
  );
  static final _lambings = _entity<$LambingsTable, Lambing>(
    collection: 'lambings',
    table: (db) => db.lambings,
    fromJson: Lambing.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.lambings).insertOnConflictUpdate(row),
  );
  static final _lambingLambs = _entity<$LambingLambsTable, LambingLamb>(
    collection: 'lambingLambs',
    table: (db) => db.lambingLambs,
    fromJson: LambingLamb.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.lambingLambs).insertOnConflictUpdate(row),
  );
  static final _treatments = _entity<$TreatmentsTable, Treatment>(
    collection: 'treatments',
    table: (db) => db.treatments,
    fromJson: Treatment.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.treatments).insertOnConflictUpdate(row),
  );
  static final _weighings = _entity<$WeighingsTable, Weighing>(
    collection: 'weighings',
    table: (db) => db.weighings,
    fromJson: Weighing.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.weighings).insertOnConflictUpdate(row),
  );
  static final _breedingEvents = _entity<$BreedingEventsTable, BreedingEvent>(
    collection: 'breedingEvents',
    table: (db) => db.breedingEvents,
    fromJson: BreedingEvent.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.breedingEvents).insertOnConflictUpdate(row),
  );
  static final _animalEvents = _entity<$AnimalEventsTable, AnimalEvent>(
    collection: 'animalEvents',
    table: (db) => db.animalEvents,
    fromJson: AnimalEvent.fromJson,
    updatedAt: (row) => row.updatedAt,
    upsert: (db, row) => db.into(db.animalEvents).insertOnConflictUpdate(row),
  );

  static final _all = [_animals, _lambings, _lambingLambs, _treatments, _weighings, _breedingEvents, _animalEvents];
  static final _byQueueType = {
    'animal': _animals,
    'lambing': _lambings,
    'treatment': _treatments,
    'weighing': _weighings,
    'breeding_event': _breedingEvents,
    'animal_event': _animalEvents,
  };

  CollectionReference<_Json> _collection(_Entity entity) => _firestore.collection('farms').doc(farmId).collection(entity.collection);

  void start() {
    for (final entity in _all) {
      _subscriptions.add(_collection(entity).snapshots().listen(
        (snapshot) {
          for (final change in snapshot.docChanges) {
            final data = change.doc.data();
            if (change.type == DocumentChangeType.removed || data == null || change.doc.metadata.hasPendingWrites) continue;
            _enqueueApply(entity, data);
          }
        },
        onError: (Object error) => debugPrint('Sincronizare: $error'),
      ));
    }
    _subscriptions.add(database.select(database.syncQueue).watch().listen((rows) {
      if (rows.isNotEmpty) unawaited(push());
    }));
  }

  Future<void> stop() async {
    _stopped = true;
    _retryTimer?.cancel();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
  }

  // Aplicările rulează pe rând; legăturile dintre tabele pot sosi în orice ordine, deci cheile străine se opresc temporar.
  void _enqueueApply(_Entity entity, _Json data) {
    _applyChain = _applyChain.then((_) async {
      if (_stopped) return;
      try {
        await database.customStatement('PRAGMA foreign_keys = OFF');
        await entity.apply(database, data);
      } catch (error) {
        debugPrint('Sincronizare: nu am putut aplica ${entity.collection}: $error');
      } finally {
        await database.customStatement('PRAGMA foreign_keys = ON');
      }
    });
  }

  Future<void> push() async {
    if (_pushing) {
      _pushAgain = true;
      return;
    }
    _pushing = true;
    try {
      do {
        _pushAgain = false;
        final items = await (database.select(database.syncQueue)
              ..where((row) => row.farmId.equals(farmId))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
        for (final item in items) {
          if (_stopped) return;
          final entity = _byQueueType[item.entityType];
          if (entity != null) await _upload(entity, item.entityId);
          await (database.delete(database.syncQueue)..where((row) => row.id.equals(item.id))).go();
        }
      } while (_pushAgain);
    } catch (error) {
      debugPrint('Sincronizare: trimiterea a eșuat, reîncerc: $error');
      _retryTimer?.cancel();
      if (!_stopped) _retryTimer = Timer(const Duration(seconds: 30), () => unawaited(push()));
    } finally {
      _pushing = false;
    }
  }

  Future<void> _upload(_Entity entity, String id) async {
    final json = await entity.exportOne(database, id);
    if (json == null) return;
    await _collection(entity).doc(id).set(json);
    if (identical(entity, _lambings)) {
      final links = await (database.select(database.lambingLambs)..where((row) => row.lambingId.equals(id))).get();
      for (final link in links) {
        await _collection(_lambingLambs).doc(link.id).set(link.toJson());
      }
    }
  }

  /// Trimite tot ce există local; se folosește când gospodăria este legată prima dată de cont.
  Future<void> uploadEverything() async {
    for (final entity in _all) {
      final rows = await entity.exportAll(database);
      for (var start = 0; start < rows.length; start += 400) {
        final batch = _firestore.batch();
        for (final row in rows.skip(start).take(400)) {
          batch.set(_collection(entity).doc(row['id'] as String), row);
        }
        await batch.commit();
      }
    }
  }
}
