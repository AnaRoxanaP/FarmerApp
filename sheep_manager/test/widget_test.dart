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
    await tester.scrollUntilVisible(find.text('Adaugă în turmă'), 200, scrollable: find.descendant(of: find.byType(AddAnimalSheet), matching: find.byType(Scrollable)).first);
    await tester.pumpAndSettle();
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
