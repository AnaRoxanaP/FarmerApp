import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheep_manager/data/app_database.dart';
import 'package:sheep_manager/ear_marks.dart';
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
    await tester.scrollUntilVisible(find.text('Adaugă în turmă'), 200, scrollable: find.descendant(of: find.byType(AddAnimalSheet), matching: find.byType(Scrollable)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adaugă în turmă'));
    await tester.pumpAndSettle();

    expect(find.text('Mioara test'), findsOneWidget);
    expect(find.textContaining('RO-900'), findsOneWidget);
    expect(find.byType(EarMarksView), findsOneWidget);
    final savedAnimal = await (database.select(database.animals)..where((animal) => animal.earTag.equals('RO-900'))).getSingleOrNull();
    expect(savedAnimal, isNotNull);

    await tester.pumpWidget(const SizedBox.shrink());
    // Drift închide stream-urile printr-un Timer(Duration.zero); pump() fără durată nu îl rulează.
    await tester.pump(Duration.zero);
  });

  testWidgets('registrul de fătări arată mama împreună cu mielul ei', (tester) async {
    await database.addAnimal(id: 'dam-1', name: 'Mioara', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-901', mark: '');
    await database.recordLambing(
      lambingId: 'lambing-1',
      damId: 'dam-1',
      occurredAt: DateTime(2026, 10, 15),
      birthType: 'single',
      notes: '',
      lambs: const [LambBirth(name: 'Mieluța', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-902')],
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: LambingsScreen(database: database))));
    await tester.pumpAndSettle();

    expect(find.text('Mioara'), findsOneWidget);
    expect(find.text('Crotaliu RO-901'), findsOneWidget);
    expect(find.text('Mieluța · RO-902'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(Duration.zero);
  });

  test('fătările de la sfârșitul anului intră în seria anului următor', () {
    expect(lambingSeriesYear(DateTime(2025, 11, 30)), 2026);
    expect(lambingSeriesYear(DateTime(2026, 2, 1)), 2026);
    expect(lambingSeriesYear(DateTime(2025, 10, 1)), 2026);
    expect(lambingSeriesYear(DateTime(2025, 9, 30)), 2025);
  });

  testWidgets('registrul permite schimbarea seriei de fătări', (tester) async {
    await database.addAnimal(id: 'dam-1', name: 'Mioara', sex: 'Femelă', breed: 'Țurcană', earTag: 'RO-911', mark: '');
    for (final record in [
      ('late-2025', DateTime(2025, 11, 20), 'Miel noiembrie', 'RO-912'),
      ('early-2026', DateTime(2026, 2, 10), 'Miel februarie', 'RO-913'),
      ('october-2025', DateTime(2025, 9, 20), 'Miel septembrie', 'RO-914'),
    ]) {
      await database.recordLambing(
        lambingId: record.$1,
        damId: 'dam-1',
        occurredAt: record.$2,
        birthType: 'single',
        notes: '',
        lambs: [LambBirth(name: record.$3, sex: 'Femelă', breed: 'Țurcană', earTag: record.$4)],
      );
    }

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: LambingsScreen(database: database))));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fătări 2026').last);
    await tester.pumpAndSettle();

    expect(find.text('Miel noiembrie · RO-912'), findsOneWidget);
    expect(find.text('Miel februarie · RO-913'), findsOneWidget);
    expect(find.text('Miel septembrie · RO-914'), findsNothing);

    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fătări 2025').last);
    await tester.pumpAndSettle();

    expect(find.text('Miel septembrie · RO-914'), findsOneWidget);
    expect(find.text('Miel noiembrie · RO-912'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(Duration.zero);
  });

  testWidgets('fătarea nu selectează automat mama și cere alegerea explicită', (tester) async {
    await database.addAnimal(
      id: 'mother-1',
      name: 'Mioara',
      sex: 'Femelă',
      breed: 'Țurcană',
      earTag: 'RO-901',
      mark: '',
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AddLambingSheet(database: database))));
    await tester.pumpAndSettle();

    expect(find.text('Selectează mama pentru această fătare.'), findsOneWidget);
    final saveButton = find.widgetWithText(FilledButton, 'Salvează fătarea');
    final scrollable = find.descendant(of: find.byType(AddLambingSheet), matching: find.byType(Scrollable)).first;
    await tester.scrollUntilVisible(saveButton, 200, scrollable: scrollable);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNull);

    await tester.scrollUntilVisible(find.text('Mioara'), -200, scrollable: scrollable);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mioara'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Mama selectată: Mioara'), findsOneWidget);
    await tester.scrollUntilVisible(saveButton, 200, scrollable: scrollable);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNotNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(Duration.zero);
  });
}
