import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheep_manager/data/app_database.dart';
import 'package:sheep_manager/main.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('afișează turma goală și permite adăugarea unei oi', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AnimalListScreen(database: database)));
    await tester.pumpAndSettle();

    expect(find.text('Turma începe aici'), findsOneWidget);
    await tester.tap(find.text('Animal nou'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Mioara test');
    await tester.enterText(fields.at(1), 'Țurcană');
    await tester.enterText(fields.at(2), 'RO-900');
    await tester.tap(find.text('Adaugă în turmă'));
    await tester.pumpAndSettle();

    expect(find.text('Mioara test'), findsOneWidget);
    expect(find.textContaining('RO-900'), findsOneWidget);
    final savedAnimal = await (database.select(database.animals)..where((animal) => animal.earTag.equals('RO-900'))).getSingleOrNull();
    expect(savedAnimal, isNotNull);

    await tester.pumpWidget(const SizedBox.shrink());
    // Drift închide stream-urile printr-un Timer(Duration.zero); pump() fără durată nu îl rulează.
    await tester.pump(Duration.zero);
  });
}
