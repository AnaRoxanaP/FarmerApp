import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class Farms extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get timezone => text().withDefault(const Constant('Europe/Bucharest'))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class FarmMembers extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get userId => text()();
  TextColumn get role => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {farmId, userId},
      ];
}

class Animals extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get internalNumber => text().nullable()();
  TextColumn get sex => text()();
  TextColumn get breed => text().withLength(min: 1, max: 80)();
  TextColumn get earTag => text()();
  TextColumn get mark => text().withDefault(const Constant(''))();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get damId => text().nullable().references(Animals, #id)();
  TextColumn get sireId => text().nullable().references(Animals, #id)();
  TextColumn get origin => text().withDefault(const Constant('born'))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {farmId, internalNumber},
        {farmId, earTag},
      ];
}

class Lambings extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get damId => text().references(Animals, #id)();
  TextColumn get sireId => text().nullable().references(Animals, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get birthType => text().withDefault(const Constant('unknown'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LambingLambs extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get lambingId => text().references(Lambings, #id)();
  TextColumn get animalId => text().references(Animals, #id)();
  RealColumn get birthWeightKg => real().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {lambingId, animalId},
      ];
}

class Treatments extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get animalId => text().references(Animals, #id)();
  TextColumn get productName => text().withLength(min: 1, max: 160)();
  TextColumn get activeIngredient => text().nullable()();
  RealColumn get doseValue => real().nullable()();
  TextColumn get doseUnit => text().nullable()();
  TextColumn get administrationRoute => text().nullable()();
  DateTimeColumn get administeredAt => dateTime()();
  TextColumn get reason => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get administeredBy => text().nullable()();
  IntColumn get withdrawalMeatDays => integer().nullable()();
  IntColumn get withdrawalMilkDays => integer().nullable()();
  DateTimeColumn get followUpAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BreedingEvents extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get damId => text().references(Animals, #id)();
  TextColumn get sireId => text().references(Animals, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get eventType => text().withDefault(const Constant('mating'))();
  TextColumn get outcome => text().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Weighings extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get measuredAt => dateTime()();
  RealColumn get weightKg => real()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AnimalEvents extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get animalId => text().references(Animals, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get eventType => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncState => text().withDefault(const Constant('pending'))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get farmId => text().references(Farms, #id)();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get settingValue => text().named('value')();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(tables: [
  Farms,
  FarmMembers,
  Animals,
  Lambings,
  LambingLambs,
  Treatments,
  BreedingEvents,
  Weighings,
  AnimalEvents,
  SyncQueue,
  AppSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(driftDatabase(
          name: 'stana_noastra',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ));
  AppDatabase.forTesting(super.executor);

  static const _defaultFarmName = 'Gospodăria noastră';
  static const _localFarmSettingKey = 'local_farm_id';

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(farms);
            await m.createTable(appSettings);
            final migratedFarmId = const Uuid().v4();
            await customStatement(
              'INSERT INTO farms (id, name, timezone, created_at, updated_at, sync_state) VALUES (?, ?, ?, ?, ?, ?)',
              [migratedFarmId, _defaultFarmName, 'Europe/Bucharest', DateTime.now().millisecondsSinceEpoch ~/ 1000, DateTime.now().millisecondsSinceEpoch ~/ 1000, 'pending'],
            );
            await customStatement('INSERT INTO app_settings (key, value) VALUES (?, ?)', [_localFarmSettingKey, migratedFarmId]);
            await customStatement('ALTER TABLE animals RENAME TO animals_v1');
            await m.createTable(animals);
            await customStatement('''
              INSERT INTO animals (
                id, farm_id, name, internal_number, sex, breed, ear_tag, mark,
                birth_date, dam_id, sire_id, origin, created_at, updated_at,
                status, deleted_at, sync_state, created_by, updated_by
              )
              SELECT
                id, ?, name, NULL, sex, breed, ear_tag, mark, birth_date,
                NULL, NULL, 'legacy', created_at, updated_at, status, NULL,
                sync_state, NULL, NULL
              FROM animals_v1
            ''', [migratedFarmId]);
            await customStatement('DROP TABLE animals_v1');

            await m.createTable(farmMembers);
            await m.createTable(lambings);
            await m.createTable(lambingLambs);
            await m.createTable(treatments);
            await m.createTable(breedingEvents);
            await m.createTable(weighings);
            await m.createTable(animalEvents);
            await m.createTable(syncQueue);
          }
        },
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<String> ensureLocalFarm() async {
    final setting = await (select(appSettings)..where((row) => row.key.equals(_localFarmSettingKey))).getSingleOrNull();
    if (setting != null) return setting.settingValue;

    final id = const Uuid().v4();
    final now = DateTime.now();
    await transaction(() async {
      await into(farms).insert(FarmsCompanion.insert(
        id: id,
        name: _defaultFarmName,
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await into(appSettings).insert(AppSettingsCompanion.insert(key: _localFarmSettingKey, settingValue: id));
    });
    return id;
  }

  Future<String?> readSetting(String key) async {
    final row = await (select(appSettings)..where((setting) => setting.key.equals(key))).getSingleOrNull();
    return row?.settingValue;
  }

  Future<void> writeSetting(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(AppSettingsCompanion.insert(key: key, settingValue: value));
  }

  /// Mută datele locale sub gospodăria din cloud (id-ul ei devine id-ul local).
  Future<void> adoptFarm({required String farmId, required String name}) async {
    final oldId = await ensureLocalFarm();
    if (oldId == farmId) return;
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      await transaction(() async {
        await into(farms).insertOnConflictUpdate(FarmsCompanion.insert(id: farmId, name: name));
        for (final table in const ['animals', 'farm_members', 'lambings', 'lambing_lambs', 'treatments', 'breeding_events', 'weighings', 'animal_events', 'sync_queue']) {
          await customStatement('UPDATE $table SET farm_id = ? WHERE farm_id = ?', [farmId, oldId]);
        }
        await customStatement('DELETE FROM farms WHERE id = ?', [oldId]);
        await writeSetting(_localFarmSettingKey, farmId);
      });
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

  Stream<List<Animal>> watchAnimals({String? farmId, bool includeInactive = false}) {
    final resolvedFarmId = farmId == null ? ensureLocalFarm() : Future<String>.value(farmId);
    return Stream<String>.fromFuture(resolvedFarmId).asyncExpand((id) {
      final query = select(animals)
        ..where((row) => row.farmId.equals(id) & row.deletedAt.isNull() & (includeInactive ? const Constant(true) : row.status.equals('active')))
        ..orderBy([(row) => OrderingTerm.asc(row.name)]);
      return query.watch();
    });
  }

  Stream<List<Treatment>> watchTreatmentsForAnimal(String animalId) {
    return (select(treatments)
          ..where((row) => row.animalId.equals(animalId) & row.deletedAt.isNull())
          ..orderBy([(row) => OrderingTerm.desc(row.administeredAt)]))
        .watch();
  }

  Stream<List<Weighing>> watchWeighingsForAnimal(String animalId) {
    return (select(weighings)
          ..where((row) => row.animalId.equals(animalId) & row.deletedAt.isNull())
          ..orderBy([(row) => OrderingTerm.desc(row.measuredAt)]))
        .watch();
  }

  Future<AnimalHistory> loadAnimalHistory(String animalId) async {
    final animal = await (select(animals)..where((row) => row.id.equals(animalId))).getSingleOrNull();
    if (animal == null) throw ArgumentError('Animalul nu a fost găsit.');

    final entries = <AnimalHistoryEntry>[];
    if (animal.birthDate != null && (animal.damId != null || animal.sireId != null)) {
      final parentIds = [animal.damId, animal.sireId].whereType<String>().toList();
      final parents = await (select(animals)..where((row) => row.id.isIn(parentIds))).get();
      final parentNames = {for (final parent in parents) parent.id: parent.name};
      final parentDescription = [
        if (animal.damId != null) 'Mama: ${parentNames[animal.damId] ?? 'necunoscută'}',
        if (animal.sireId != null) 'Tatăl: ${parentNames[animal.sireId] ?? 'necunoscut'}',
      ].join(' · ');
      entries.add(AnimalHistoryEntry(
        occurredAt: animal.birthDate!,
        category: 'birth',
        title: 'Născut(ă)',
        detail: parentDescription,
      ));
    }

    final animalLambings = await (select(lambings)
          ..where((row) => row.damId.equals(animalId) & row.deletedAt.isNull())
          ..orderBy([(row) => OrderingTerm.desc(row.occurredAt)]))
        .get();
    for (final lambing in animalLambings) {
      final lambLinks = await (select(lambingLambs)
            ..where((row) => row.lambingId.equals(lambing.id) & row.deletedAt.isNull()))
          .get();
      final lambIds = lambLinks.map((link) => link.animalId).toList();
      final lambAnimals = lambIds.isEmpty ? <Animal>[] : await (select(animals)..where((row) => row.id.isIn(lambIds))).get();
      final lambNames = {for (final lamb in lambAnimals) lamb.id: lamb.name};
      final names = lambLinks.map((link) => lambNames[link.animalId] ?? 'Miel').join(', ');
      entries.add(AnimalHistoryEntry(
        occurredAt: lambing.occurredAt,
        category: 'lambing',
        title: '${lambLinks.length} ${lambLinks.length == 1 ? 'miel' : 'miei'} născuți',
        detail: [names, lambing.birthType, lambing.notes].where((value) => value.isNotEmpty).join(' · '),
      ));
    }

    final animalTreatments = await (select(treatments)
          ..where((row) => row.animalId.equals(animalId) & row.deletedAt.isNull()))
        .get();
    entries.addAll(animalTreatments.map((treatment) => AnimalHistoryEntry(
          occurredAt: treatment.administeredAt,
          category: 'treatment',
          title: treatment.productName,
          detail: [
            if (treatment.doseValue != null) '${treatment.doseValue} ${treatment.doseUnit ?? ''}'.trim(),
            treatment.reason,
            treatment.notes,
            if (treatment.followUpAt != null) 'Control: ${_historyDate(treatment.followUpAt!)}',
          ].where((value) => value.isNotEmpty).join(' · '),
        )));

    final animalWeighings = await (select(weighings)
          ..where((row) => row.animalId.equals(animalId) & row.deletedAt.isNull()))
        .get();
    entries.addAll(animalWeighings.map((weighing) => AnimalHistoryEntry(
          occurredAt: weighing.measuredAt,
          category: 'weighing',
          title: 'Cântărire · ${weighing.weightKg} kg',
          detail: weighing.notes,
        )));

    final animalBreedingEvents = await (select(breedingEvents)
          ..where((row) => (row.damId.equals(animalId) | row.sireId.equals(animalId)) & row.deletedAt.isNull()))
        .get();
    entries.addAll(animalBreedingEvents.map((event) => AnimalHistoryEntry(
          occurredAt: event.occurredAt,
          category: 'breeding',
          title: event.eventType == 'mating' ? 'Montă' : event.eventType,
          detail: [event.outcome ?? '', event.notes].where((value) => value.isNotEmpty).join(' · '),
        )));

    final animalEventsList = await (select(animalEvents)
          ..where((row) => row.animalId.equals(animalId) & row.deletedAt.isNull()))
        .get();
    entries.addAll(animalEventsList.map((event) => AnimalHistoryEntry(
          occurredAt: event.occurredAt,
          category: 'event',
          title: _eventTitle(event.eventType),
          detail: event.notes,
        )));

    entries.sort((first, second) => second.occurredAt.compareTo(first.occurredAt));
    return AnimalHistory(animal: animal, entries: entries);
  }

  String _eventTitle(String eventType) => switch (eventType) {
        'sold' => 'Vândut(ă)',
        'deceased' => 'Decedat(ă)',
        'transferred' => 'Transferat(ă)',
        'weaned' => 'Înțărcat(ă)',
        'purchased' => 'Cumpărat(ă)',
        _ => eventType,
      };

  String _historyDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

  Stream<List<Lambing>> watchLambings({String? farmId}) {
    final resolvedFarmId = farmId == null ? ensureLocalFarm() : Future<String>.value(farmId);
    return Stream<String>.fromFuture(resolvedFarmId).asyncExpand((id) {
      return (select(lambings)
            ..where((row) => row.farmId.equals(id) & row.deletedAt.isNull())
            ..orderBy([(row) => OrderingTerm.desc(row.occurredAt)]))
          .watch();
    });
  }

  Stream<List<Treatment>> watchTreatments({String? farmId}) {
    final resolvedFarmId = farmId == null ? ensureLocalFarm() : Future<String>.value(farmId);
    return Stream<String>.fromFuture(resolvedFarmId).asyncExpand((id) {
      return (select(treatments)
            ..where((row) => row.farmId.equals(id) & row.deletedAt.isNull())
            ..orderBy([(row) => OrderingTerm.desc(row.administeredAt)]))
          .watch();
    });
  }

  Future<void> recordTreatment({
    required String id,
    required String animalId,
    required String productName,
    required DateTime administeredAt,
    String? activeIngredient,
    double? doseValue,
    String? doseUnit,
    String? administrationRoute,
    String reason = '',
    String notes = '',
    String? administeredBy,
    int? withdrawalMeatDays,
    int? withdrawalMilkDays,
    DateTime? followUpAt,
  }) async {
    await recordTreatments(
      treatmentIds: {animalId: id},
      animalIds: [animalId],
      productName: productName,
      administeredAt: administeredAt,
      activeIngredient: activeIngredient,
      doseValue: doseValue,
      doseUnit: doseUnit,
      administrationRoute: administrationRoute,
      reason: reason,
      notes: notes,
      administeredBy: administeredBy,
      withdrawalMeatDays: withdrawalMeatDays,
      withdrawalMilkDays: withdrawalMilkDays,
      followUpAt: followUpAt,
    );
  }

  Future<void> recordTreatments({
    required Map<String, String> treatmentIds,
    required List<String> animalIds,
    required String productName,
    required DateTime administeredAt,
    String? activeIngredient,
    double? doseValue,
    String? doseUnit,
    String? administrationRoute,
    String reason = '',
    String notes = '',
    String? administeredBy,
    int? withdrawalMeatDays,
    int? withdrawalMilkDays,
    DateTime? followUpAt,
  }) async {
    final uniqueAnimalIds = animalIds.toSet().toList();
    if (uniqueAnimalIds.isEmpty) throw ArgumentError('Selectează cel puțin un animal.');
    if (uniqueAnimalIds.length != animalIds.length || treatmentIds.keys.toSet().length != uniqueAnimalIds.length || !treatmentIds.keys.toSet().containsAll(uniqueAnimalIds)) {
      throw ArgumentError('Lista animalelor sau identificatorii tratamentelor nu sunt valizi.');
    }
    if (productName.trim().isEmpty) throw ArgumentError('Numele tratamentului este obligatoriu.');
    if (doseValue != null && doseValue <= 0) throw ArgumentError('Doza trebuie să fie mai mare decât zero.');
    if ((withdrawalMeatDays ?? 0) < 0 || (withdrawalMilkDays ?? 0) < 0) {
      throw ArgumentError('Timpul de așteptare nu poate fi negativ.');
    }

    final selectedAnimals = await (select(animals)..where((row) => row.id.isIn(uniqueAnimalIds) & row.deletedAt.isNull())).get();
    if (selectedAnimals.length != uniqueAnimalIds.length || selectedAnimals.any((animal) => animal.status != 'active')) {
      throw ArgumentError('Unul sau mai multe animale nu există sau nu sunt active.');
    }
    final farmId = selectedAnimals.first.farmId;
    if (selectedAnimals.any((animal) => animal.farmId != farmId)) {
      throw ArgumentError('Toate animalele trebuie să aparțină aceleiași gospodării.');
    }

    final now = DateTime.now();
    await transaction(() async {
      for (final animal in selectedAnimals) {
        final treatmentId = treatmentIds[animal.id]!;
        await into(treatments).insert(TreatmentsCompanion.insert(
          id: treatmentId,
          farmId: farmId,
          animalId: animal.id,
          productName: productName.trim(),
          activeIngredient: Value(activeIngredient?.trim()),
          doseValue: Value(doseValue),
          doseUnit: Value(doseUnit?.trim()),
          administrationRoute: Value(administrationRoute?.trim()),
          administeredAt: administeredAt,
          reason: Value(reason.trim()),
          notes: Value(notes.trim()),
          administeredBy: Value(administeredBy),
          withdrawalMeatDays: Value(withdrawalMeatDays),
          withdrawalMilkDays: Value(withdrawalMilkDays),
          followUpAt: Value(followUpAt),
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
        await _queueSync(
          farmId: farmId,
          entityType: 'treatment',
          entityId: treatmentId,
          operation: 'upsert',
          payload: {
            'id': treatmentId,
            'farmId': farmId,
            'animalId': animal.id,
            'productName': productName.trim(),
            'activeIngredient': activeIngredient?.trim(),
            'doseValue': doseValue,
            'doseUnit': doseUnit?.trim(),
            'administrationRoute': administrationRoute?.trim(),
            'administeredAt': administeredAt.toUtc().toIso8601String(),
            'reason': reason.trim(),
            'notes': notes.trim(),
            'administeredBy': administeredBy,
            'withdrawalMeatDays': withdrawalMeatDays,
            'withdrawalMilkDays': withdrawalMilkDays,
            'followUpAt': followUpAt?.toUtc().toIso8601String(),
          },
          createdAt: now,
        );
      }
    });
  }

  Future<void> recordWeighing({
    required String id,
    required String animalId,
    required DateTime measuredAt,
    required double weightKg,
    String notes = '',
  }) async {
    if (weightKg <= 0) throw ArgumentError('Greutatea trebuie să fie mai mare decât zero.');
    final animal = await _requireAnimal(animalId);
    final now = DateTime.now();
    await transaction(() async {
      await into(weighings).insert(WeighingsCompanion.insert(
        id: id,
        farmId: animal.farmId,
        animalId: animalId,
        measuredAt: measuredAt,
        weightKg: weightKg,
        notes: Value(notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await _queueSync(
        farmId: animal.farmId,
        entityType: 'weighing',
        entityId: id,
        operation: 'upsert',
        payload: {'id': id, 'farmId': animal.farmId, 'animalId': animalId, 'measuredAt': measuredAt.toUtc().toIso8601String(), 'weightKg': weightKg, 'notes': notes.trim()},
        createdAt: now,
      );
    });
  }

  Future<void> recordBreedingEvent({
    required String id,
    required String damId,
    required String sireId,
    required DateTime occurredAt,
    String eventType = 'mating',
    String? outcome,
    String notes = '',
  }) async {
    if (damId == sireId) throw ArgumentError('Animalul nu poate fi împerecheat cu el însuși.');
    final dam = await _requireAnimal(damId);
    final sire = await _requireAnimal(sireId);
    if (dam.sex != 'Femelă' || sire.sex != 'Mascul' || dam.status != 'active' || sire.status != 'active' || dam.farmId != sire.farmId) {
      throw ArgumentError('Alege o femelă și un mascul activi din aceeași gospodărie.');
    }

    final now = DateTime.now();
    await transaction(() async {
      await into(breedingEvents).insert(BreedingEventsCompanion.insert(
        id: id,
        farmId: dam.farmId,
        damId: damId,
        sireId: sireId,
        occurredAt: occurredAt,
        eventType: Value(eventType),
        outcome: Value(outcome),
        notes: Value(notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await _queueSync(
        farmId: dam.farmId,
        entityType: 'breeding_event',
        entityId: id,
        operation: 'upsert',
        payload: {'id': id, 'farmId': dam.farmId, 'damId': damId, 'sireId': sireId, 'occurredAt': occurredAt.toUtc().toIso8601String(), 'eventType': eventType, 'outcome': outcome, 'notes': notes.trim()},
        createdAt: now,
      );
    });
  }

  Future<void> recordAnimalEvent({
    required String id,
    required String animalId,
    required DateTime occurredAt,
    required String eventType,
    String notes = '',
  }) async {
    if (eventType.trim().isEmpty) throw ArgumentError('Tipul evenimentului este obligatoriu.');
    final animal = await _requireAnimal(animalId);
    final now = DateTime.now();
    await transaction(() async {
      await into(animalEvents).insert(AnimalEventsCompanion.insert(
        id: id,
        farmId: animal.farmId,
        animalId: animalId,
        occurredAt: occurredAt,
        eventType: eventType.trim(),
        notes: Value(notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await _queueSync(
        farmId: animal.farmId,
        entityType: 'animal_event',
        entityId: id,
        operation: 'upsert',
        payload: {'id': id, 'farmId': animal.farmId, 'animalId': animalId, 'occurredAt': occurredAt.toUtc().toIso8601String(), 'eventType': eventType.trim(), 'notes': notes.trim()},
        createdAt: now,
      );
    });
  }

  Future<void> archiveAnimal({required String animalId, required String status, String notes = ''}) async {
    const allowedStatuses = {'sold', 'deceased', 'transferred'};
    if (!allowedStatuses.contains(status)) throw ArgumentError('Starea de ieșire nu este recunoscută.');
    final animal = await _requireAnimal(animalId);
    final now = DateTime.now();
    final eventId = const Uuid().v4();
    await transaction(() async {
      await (update(animals)..where((row) => row.id.equals(animalId))).write(AnimalsCompanion(
        status: Value(status),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ));
      await into(animalEvents).insert(AnimalEventsCompanion.insert(
        id: eventId,
        farmId: animal.farmId,
        animalId: animalId,
        occurredAt: now,
        eventType: status,
        notes: Value(notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await _queueSync(
        farmId: animal.farmId,
        entityType: 'animal_event',
        entityId: eventId,
        operation: 'upsert',
        payload: {'id': eventId, 'farmId': animal.farmId, 'animalId': animalId, 'occurredAt': now.toUtc().toIso8601String(), 'eventType': status, 'notes': notes.trim()},
        createdAt: now,
      );
      await _queueSync(
        farmId: animal.farmId,
        entityType: 'animal',
        entityId: animalId,
        operation: 'upsert',
        payload: {'id': animalId, 'farmId': animal.farmId, 'status': status, 'updatedAt': now.toUtc().toIso8601String()},
        createdAt: now,
      );
    });
  }

  Future<Animal> _requireAnimal(String animalId) async {
    final animal = await (select(animals)..where((row) => row.id.equals(animalId) & row.deletedAt.isNull())).getSingleOrNull();
    if (animal == null) throw ArgumentError('Animalul nu există în această bază de date.');
    return animal;
  }

  Future<void> addAnimal({
    required String id,
    required String name,
    required String sex,
    required String breed,
    required String earTag,
    required String mark,
    DateTime? birthDate,
  }) async {
    final now = DateTime.now();
    final farmId = await ensureLocalFarm();
    await transaction(() async {
      await into(animals).insert(AnimalsCompanion.insert(
        id: id,
        farmId: farmId,
        name: name.trim(),
        sex: sex,
        breed: breed.trim(),
        earTag: earTag.trim(),
        mark: Value(mark.trim()),
        birthDate: Value(birthDate),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
      await _queueSync(
        farmId: farmId,
        entityType: 'animal',
        entityId: id,
        operation: 'upsert',
        payload: {
          'id': id,
          'farmId': farmId,
          'name': name.trim(),
          'sex': sex,
          'breed': breed.trim(),
          'earTag': earTag.trim(),
          'mark': mark.trim(),
          'birthDate': birthDate?.toUtc().toIso8601String(),
          'createdAt': now.toUtc().toIso8601String(),
          'updatedAt': now.toUtc().toIso8601String(),
        },
        createdAt: now,
      );
    });
  }

  Future<void> updateAnimal({
    required String id,
    required String name,
    required String sex,
    required String breed,
    required String earTag,
    required String mark,
    DateTime? birthDate,
  }) async {
    final animal = await _requireAnimal(id);
    final now = DateTime.now();
    if (birthDate != null && birthDate.isAfter(now)) {
      throw ArgumentError('Data nașterii nu poate fi în viitor.');
    }
    await transaction(() async {
      await (update(animals)..where((row) => row.id.equals(id))).write(AnimalsCompanion(
        name: Value(name.trim()),
        sex: Value(sex),
        breed: Value(breed.trim()),
        earTag: Value(earTag.trim()),
        mark: Value(mark.trim()),
        birthDate: Value(birthDate),
        updatedAt: Value(now),
        syncState: const Value('pending'),
      ));
      await _queueSync(
        farmId: animal.farmId,
        entityType: 'animal',
        entityId: id,
        operation: 'upsert',
        payload: {
          'id': id,
          'farmId': animal.farmId,
          'name': name.trim(),
          'sex': sex,
          'breed': breed.trim(),
          'earTag': earTag.trim(),
          'mark': mark.trim(),
          'birthDate': birthDate?.toUtc().toIso8601String(),
          'updatedAt': now.toUtc().toIso8601String(),
        },
        createdAt: now,
      );

      if (animal.damId != null && birthDate != null && animal.birthDate != birthDate) {
        final lambLinks = await (select(lambingLambs)..where((link) => link.animalId.equals(id) & link.deletedAt.isNull())).get();
        for (final link in lambLinks) {
          final lambing = await (select(lambings)..where((row) => row.id.equals(link.lambingId) & row.deletedAt.isNull())).getSingleOrNull();
          if (lambing == null) continue;
          await (update(lambings)..where((row) => row.id.equals(lambing.id))).write(LambingsCompanion(
            occurredAt: Value(birthDate),
            updatedAt: Value(now),
            syncState: const Value('pending'),
          ));
          await _queueSync(
            farmId: animal.farmId,
            entityType: 'lambing',
            entityId: lambing.id,
            operation: 'upsert',
            payload: {'id': lambing.id, 'farmId': animal.farmId, 'occurredAt': birthDate.toUtc().toIso8601String(), 'updatedAt': now.toUtc().toIso8601String()},
            createdAt: now,
          );
        }
      }
    });
  }

  Future<void> recordLambing({
    required String lambingId,
    required String damId,
    String? sireId,
    required DateTime occurredAt,
    required String birthType,
    required String notes,
    required List<LambBirth> lambs,
  }) async {
    if (lambs.isEmpty) {
      throw ArgumentError('O fătare trebuie să includă cel puțin un miel.');
    }
    if (sireId == damId) {
      throw ArgumentError('Mama nu poate fi și tatăl mieilor.');
    }

    final dam = await (select(animals)..where((animal) => animal.id.equals(damId))).getSingleOrNull();
    if (dam == null || dam.sex != 'Femelă' || dam.status != 'active') {
      throw ArgumentError('Mama selectată nu există, nu este activă sau nu este femelă.');
    }
    final sire = sireId == null
        ? null
        : await (select(animals)..where((animal) => animal.id.equals(sireId))).getSingleOrNull();
    if (sireId != null && (sire == null || sire.sex != 'Mascul' || sire.status != 'active' || sire.farmId != dam.farmId)) {
      throw ArgumentError('Tatăl selectat nu există, nu este activ, nu este mascul sau aparține altei gospodării.');
    }
    if (lambs.any((birth) => birth.earTag.trim().isEmpty)) {
      throw ArgumentError('Fiecare miel trebuie să aibă un număr de crotaliu.');
    }

    final farmId = dam.farmId;
    final now = DateTime.now();
    await transaction(() async {
      await into(lambings).insert(LambingsCompanion.insert(
        id: lambingId,
        farmId: farmId,
        damId: damId,
        sireId: Value(sireId),
        occurredAt: occurredAt,
        birthType: Value(birthType),
        notes: Value(notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));

      final lambLinks = <Map<String, Object?>>[];
      for (final birth in lambs) {
        final animalId = const Uuid().v4();
        final lambingLambId = const Uuid().v4();
        final lambName = birth.name.trim().isEmpty ? 'Miel ${birth.earTag.trim()}' : birth.name.trim();
        await into(animals).insert(AnimalsCompanion.insert(
          id: animalId,
          farmId: farmId,
          name: lambName,
          sex: birth.sex,
          breed: birth.breed.trim().isEmpty ? dam.breed : birth.breed.trim(),
          earTag: birth.earTag.trim(),
          mark: Value(birth.mark.trim()),
          birthDate: Value(occurredAt),
          damId: Value(damId),
          sireId: Value(sireId),
          origin: const Value('born'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
        await into(lambingLambs).insert(LambingLambsCompanion.insert(
          id: lambingLambId,
          farmId: farmId,
          lambingId: lambingId,
          animalId: animalId,
          birthWeightKg: Value(birth.birthWeightKg),
          notes: Value(birth.notes.trim()),
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
        lambLinks.add({
          'id': lambingLambId,
          'animalId': animalId,
          'birthWeightKg': birth.birthWeightKg,
          'notes': birth.notes.trim(),
        });
        await _queueSync(
          farmId: farmId,
          entityType: 'animal',
          entityId: animalId,
          operation: 'upsert',
          payload: {'id': animalId, 'farmId': farmId, 'name': lambName, 'damId': damId, 'sireId': sireId, 'earTag': birth.earTag.trim()},
          createdAt: now,
        );
      }

      await _queueSync(
        farmId: farmId,
        entityType: 'lambing',
        entityId: lambingId,
        operation: 'upsert',
        payload: {
          'id': lambingId,
          'farmId': farmId,
          'damId': damId,
          'sireId': sireId,
          'occurredAt': occurredAt.toUtc().toIso8601String(),
          'birthType': birthType,
          'lambs': lambLinks,
        },
        createdAt: now,
      );
    });
  }

  Future<void> _queueSync({
    required String farmId,
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, Object?> payload,
    required DateTime createdAt,
  }) async {
    await into(syncQueue).insert(SyncQueueCompanion.insert(
      id: const Uuid().v4(),
      farmId: farmId,
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payloadJson: jsonEncode(payload),
      createdAt: Value(createdAt),
    ));
  }
}

class LambBirth {
  const LambBirth({
    required this.name,
    required this.sex,
    required this.breed,
    required this.earTag,
    this.mark = '',
    this.birthWeightKg,
    this.notes = '',
  });

  final String name;
  final String sex;
  final String breed;
  final String earTag;
  final String mark;
  final double? birthWeightKg;
  final String notes;
}

class AnimalHistory {
  const AnimalHistory({required this.animal, required this.entries});

  final Animal animal;
  final List<AnimalHistoryEntry> entries;
}

class AnimalHistoryEntry {
  const AnimalHistoryEntry({required this.occurredAt, required this.category, required this.title, required this.detail});

  final DateTime occurredAt;
  final String category;
  final String title;
  final String detail;
}
