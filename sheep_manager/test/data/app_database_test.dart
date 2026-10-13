import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheep_manager/data/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  Future<String> addMother() async {
    await database.addAnimal(
      id: 'dam-1',
      name: 'Mioara',
      sex: 'Femelă',
      breed: 'Țurcană',
      earTag: 'RO-001',
      mark: 'Urechea stângă crestată',
      birthDate: DateTime(2021, 3, 12),
    );
    return 'dam-1';
  }

  test('fătarea creează toți mieii și păstrează relațiile în aceeași gospodărie', () async {
    final damId = await addMother();

    await database.recordLambing(
      lambingId: 'lambing-1',
      damId: damId,
      occurredAt: DateTime(2026, 10, 12),
      birthType: 'twins',
      notes: 'Fătare ușoară',
      lambs: const [
        LambBirth(name: 'Albinuța', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-101', birthWeightKg: 3.4),
        LambBirth(name: '', sex: 'Mascul', breed: '', earTag: 'RO-102', birthWeightKg: 3.7),
      ],
    );

    final lambRows = await database.select(database.lambingLambs).get();
    final animalRows = await database.select(database.animals).get();
    final eventRows = await database.select(database.lambings).get();
    final outboxRows = await database.select(database.syncQueue).get();
    final farmId = await database.ensureLocalFarm();

    expect(eventRows, hasLength(1));
    expect(lambRows, hasLength(2));
    expect(animalRows, hasLength(3));
    expect(animalRows.where((animal) => animal.damId == damId), hasLength(2));
    expect(animalRows.every((animal) => animal.farmId == farmId), isTrue);
    expect(animalRows.any((animal) => animal.name == 'Miel RO-102'), isTrue);
    expect(outboxRows.where((entry) => entry.entityType == 'lambing'), hasLength(1));
    expect(outboxRows.where((entry) => entry.entityType == 'animal'), hasLength(3));
  });

  test('eșecul unui miel cu crotaliu duplicat anulează întreaga fătare', () async {
    final damId = await addMother();
    await database.addAnimal(
      id: 'existing-lamb',
      name: 'Miel existent',
      sex: 'Mascul',
      breed: 'Țurcană',
      earTag: 'RO-202',
      mark: '',
    );
    final animalCountBeforeLambing = await database.select(database.animals).get();
    final lambingCountBefore = await database.select(database.lambings).get();
    final linkCountBefore = await database.select(database.lambingLambs).get();
    final outboxCountBefore = await database.select(database.syncQueue).get();

    await expectLater(
      database.recordLambing(
        lambingId: 'lambing-duplicate',
        damId: damId,
        occurredAt: DateTime(2026, 10, 12),
        birthType: 'twins',
        notes: '',
        lambs: const [
          LambBirth(name: 'Primul miel', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-201'),
          LambBirth(name: 'Crotaliu duplicat', sex: 'Mascul', breed: 'Țurcană', earTag: 'RO-202'),
        ],
      ),
      throwsA(anything),
    );

    expect(await database.select(database.animals).get(), hasLength(animalCountBeforeLambing.length));
    expect(await database.select(database.lambings).get(), hasLength(lambingCountBefore.length));
    expect(await database.select(database.lambingLambs).get(), hasLength(linkCountBefore.length));
    expect(await database.select(database.syncQueue).get(), hasLength(outboxCountBefore.length));
  });

  test('tratamentul și controlul următor sunt salvate împreună cu evenimentul outbox', () async {
    await addMother();
    final administeredAt = DateTime(2026, 10, 13);
    final followUpAt = DateTime(2026, 11, 13);

    await database.recordTreatment(
      id: 'treatment-1',
      animalId: 'dam-1',
      productName: 'Deparazitare',
      activeIngredient: 'Substanță test',
      doseValue: 2.5,
      doseUnit: 'ml',
      administeredAt: administeredAt,
      withdrawalMeatDays: 7,
      followUpAt: followUpAt,
    );

    final treatment = await database.select(database.treatments).getSingle();
    final outbox = await (database.select(database.syncQueue)..where((row) => row.entityType.equals('treatment'))).getSingle();

    expect(treatment.productName, 'Deparazitare');
    expect(treatment.doseValue, 2.5);
    expect(treatment.withdrawalMeatDays, 7);
    expect(treatment.followUpAt, followUpAt);
    expect(outbox.entityId, treatment.id);
    expect(outbox.operation, 'upsert');
  });

  test('fișa animalului combină istoricul și include filiația mielului', () async {
    final damId = await addMother();
    await database.recordTreatment(
      id: 'history-treatment',
      animalId: damId,
      productName: 'Tratament preventiv',
      administeredAt: DateTime(2026, 10, 10),
    );
    await database.recordLambing(
      lambingId: 'history-lambing',
      damId: damId,
      occurredAt: DateTime(2026, 10, 12),
      birthType: 'single',
      notes: '',
      lambs: const [LambBirth(name: 'Mieluța', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-303')],
    );

    final motherHistory = await database.loadAnimalHistory(damId);
    final lamb = (await database.select(database.animals).get()).singleWhere((animal) => animal.earTag == 'RO-303');
    final lambHistory = await database.loadAnimalHistory(lamb.id);

    expect(motherHistory.entries.map((entry) => entry.category), ['lambing', 'treatment']);
    expect(lambHistory.entries, hasLength(1));
    expect(lambHistory.entries.single.category, 'birth');
    expect(lambHistory.entries.single.detail, contains('Mioara'));
  });

  test('editarea unui miel păstrează UUID-ul și legătura cu mama', () async {
    final damId = await addMother();
    await database.recordLambing(
      lambingId: 'edit-lambing',
      damId: damId,
      occurredAt: DateTime(2026, 10, 12),
      birthType: 'single',
      notes: '',
      lambs: const [LambBirth(name: 'Miel inițial', sex: 'Mascul', breed: 'Țurcană', earTag: 'RO-404')],
    );
    final lambBeforeEdit = (await database.select(database.animals).get()).singleWhere((animal) => animal.earTag == 'RO-404');

    await database.updateAnimal(
      id: lambBeforeEdit.id,
      name: 'Miel corectat',
      sex: 'Mascul',
      breed: 'Merinos',
      earTag: 'RO-405',
      mark: 'Ureche dreaptă crestată',
      birthDate: DateTime(2026, 10, 11),
    );

    final lambAfterEdit = await (database.select(database.animals)..where((animal) => animal.id.equals(lambBeforeEdit.id))).getSingle();
    final relation = await (database.select(database.lambingLambs)..where((link) => link.animalId.equals(lambBeforeEdit.id))).getSingle();
    final updatedLambing = await (database.select(database.lambings)..where((lambing) => lambing.id.equals('edit-lambing'))).getSingle();
    final updates = await (database.select(database.syncQueue)
          ..where((entry) => entry.entityId.equals(lambBeforeEdit.id))
          ..where((entry) => entry.entityType.equals('animal')))
        .get();

    expect(lambAfterEdit.id, lambBeforeEdit.id);
    expect(lambAfterEdit.name, 'Miel corectat');
    expect(lambAfterEdit.earTag, 'RO-405');
    expect(lambAfterEdit.damId, damId);
    expect(relation.lambingId, 'edit-lambing');
    expect(updatedLambing.occurredAt, DateTime(2026, 10, 11));
    expect(updates, hasLength(2));
  });

  test('același tratament se înregistrează atomic pentru mai multe animale', () async {
    await addMother();
    await database.addAnimal(
      id: 'dam-2',
      name: 'Alba',
      sex: 'Femelă',
      breed: 'Merinos',
      earTag: 'RO-002',
      mark: '',
    );

    await database.recordTreatments(
      treatmentIds: const {'dam-1': 'treatment-dam-1', 'dam-2': 'treatment-dam-2'},
      animalIds: const ['dam-1', 'dam-2'],
      productName: 'Deparazitare',
      administeredAt: DateTime(2026, 10, 13),
      doseValue: 2,
      doseUnit: 'ml',
    );

    final treatmentRows = await database.select(database.treatments).get();
    final treatmentOutbox = await (database.select(database.syncQueue)..where((entry) => entry.entityType.equals('treatment'))).get();
    expect(treatmentRows, hasLength(2));
    expect(treatmentRows.map((row) => row.animalId).toSet(), {'dam-1', 'dam-2'});
    expect(treatmentOutbox, hasLength(2));
  });
}
