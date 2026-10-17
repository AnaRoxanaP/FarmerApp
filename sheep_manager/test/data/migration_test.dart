import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheep_manager/data/app_database.dart';

void main() {
  test(
      'upgradează schema 3 păstrând relațiile și permite refolosirea crotaliului șters',
      () async {
    final directory =
        await Directory.systemTemp.createTemp('sheep-manager-migration-');
    final file =
        File('${directory.path}${Platform.pathSeparator}database.sqlite');
    var database = AppDatabase.forTesting(NativeDatabase(file));
    try {
      await database.addAnimal(
          id: 'dam',
          name: 'Mioara',
          sex: 'Femelă',
          breed: 'Țurcană',
          earTag: 'RO-1',
          mark: '');
      await database.recordLambing(
        lambingId: 'lambing',
        damId: 'dam',
        occurredAt: DateTime(2026, 1, 1),
        birthType: 'single',
        notes: '',
        lambs: const [
          LambBirth(
              name: 'Miel', sex: 'Mascul', breed: 'Țurcană', earTag: 'RO-2')
        ],
      );
      await (database.update(database.animals)
            ..where((row) => row.id.equals('dam')))
          .write(
        const AnimalsCompanion(
            earMarks: Value('{"l":["v:top"],"r":[],"h":"none"}')),
      );

      await database.customStatement('PRAGMA foreign_keys = OFF');
      await database.customStatement('''
        CREATE TABLE animals_v3 (
          id TEXT NOT NULL PRIMARY KEY,
          farm_id TEXT NOT NULL REFERENCES farms(id),
          name TEXT NOT NULL,
          internal_number TEXT,
          sex TEXT NOT NULL,
          breed TEXT NOT NULL,
          ear_tag TEXT NOT NULL,
          mark TEXT NOT NULL DEFAULT '',
          birth_date INTEGER,
          dam_id TEXT REFERENCES animals_v3(id),
          sire_id TEXT REFERENCES animals_v3(id),
          origin TEXT NOT NULL DEFAULT 'born',
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          status TEXT NOT NULL DEFAULT 'active',
          deleted_at INTEGER,
          sync_state TEXT NOT NULL DEFAULT 'pending',
          created_by TEXT,
          updated_by TEXT,
          ear_marks TEXT,
          UNIQUE(farm_id, internal_number),
          UNIQUE(farm_id, ear_tag)
        )
      ''');
      await database.customStatement('''
        INSERT INTO animals_v3 (
          id, farm_id, name, internal_number, sex, breed, ear_tag, mark,
          birth_date, dam_id, sire_id, origin, created_at, updated_at, status,
          deleted_at, sync_state, created_by, updated_by, ear_marks
        )
        SELECT
          id, farm_id, name, internal_number, sex, breed, ear_tag, mark,
          birth_date, dam_id, sire_id, origin, created_at, updated_at, status,
          deleted_at, sync_state, created_by, updated_by, ear_marks
        FROM animals
      ''');
      await database.customStatement('DROP TABLE animals');
      await database
          .customStatement('ALTER TABLE animals_v3 RENAME TO animals');
      await database
          .customStatement('CREATE TABLE animals_v4 (id TEXT PRIMARY KEY)');
      await database.customStatement(
          "INSERT INTO animals_v4 (id) VALUES ('stale-partial-copy')");
      await database.customStatement('PRAGMA foreign_keys = ON');
      await database.customStatement('PRAGMA user_version = 3');
      await database.close();

      database = AppDatabase.forTesting(NativeDatabase(file));
      expect(await database.watchAnimals(includeInactive: true).first,
          hasLength(2));
      expect(await database.watchLambings().first, hasLength(1));
      final mother = (await database.select(database.animals).get())
          .singleWhere((animal) => animal.id == 'dam');
      expect(mother.earMarks, '{"l":["v:top"],"r":[],"h":"none"}');

      final lambId = (await database.select(database.animals).get())
          .singleWhere((animal) => animal.earTag == 'RO-2')
          .id;
      await database.deleteAnimal(lambId);
      await database.addAnimal(
          id: 'replacement',
          name: 'Miel nou',
          sex: 'Mascul',
          breed: 'Țurcană',
          earTag: 'RO-2',
          mark: '');
      expect(await database.watchAnimals().first, hasLength(2));
    } finally {
      await database.close();
      await directory.delete(recursive: true);
    }
  });
}
