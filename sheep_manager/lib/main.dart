import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'auth/auth_gate.dart';
import 'data/app_database.dart';
import 'ear_marks.dart';
import 'firebase_options.dart';
import 'services/treatment_notifications.dart';

const _forest = Color(0xFF24513F);
const _leaf = Color(0xFF3E7657);
const _paper = Color(0xFFFFFDF7);
const _cream = Color(0xFFF6F4EB);
const _muted = Color(0xFF758078);
const _line = Color(0xFFE7E5D9);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await TreatmentNotifications.initialize();
  } catch (_) {}
  final cloudEnabled = DefaultFirebaseOptions.isConfigured;
  if (cloudEnabled) await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(StanaApp(cloudEnabled: cloudEnabled));
}

class StanaApp extends StatefulWidget {
  const StanaApp({this.cloudEnabled = false, super.key});

  final bool cloudEnabled;

  @override
  State<StanaApp> createState() => _StanaAppState();
}

class _StanaAppState extends State<StanaApp> {
  late final AppDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stâna noastră',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _forest, surface: _paper),
        scaffoldBackgroundColor: _cream,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(backgroundColor: _cream, surfaceTintColor: Colors.transparent),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _paper,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _line)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _line)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _leaf, width: 1.5)),
        ),
      ),
      home: widget.cloudEnabled ? AuthGate(database: _database) : AnimalListScreen(database: _database),
    );
  }
}

String formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

int lambingSeriesYear(DateTime date) => date.month >= 11 ? date.year + 1 : date.year;

class AnimalListScreen extends StatefulWidget {
  const AnimalListScreen({required this.database, this.accountActions = const [], super.key});

  final AppDatabase database;
  final List<Widget> accountActions;

  @override
  State<AnimalListScreen> createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State<AnimalListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  int _tabIndex = 0;
  String _group = 'all';
  String _statusFilter = 'active';

  static const _statusFilters = [('active', 'În turmă'), ('sold', 'Vândute'), ('slaughtered', 'Sacrificate'), ('all', 'Toate'), ('deleted', 'Șterse')];

  List<Animal> _filterStatus(List<Animal> animals) => switch (_statusFilter) {
        'deleted' => animals.where((animal) => animal.deletedAt != null).toList(),
        'all' => animals.where((animal) => animal.deletedAt == null).toList(),
        _ => animals.where((animal) => animal.deletedAt == null && animal.status == _statusFilter).toList(),
      };
  // Miel = animal sub un an; fără dată a nașterii, animalul se consideră adult.
  bool _isLamb(Animal animal) {
    final born = animal.birthDate;
    return born != null && DateTime.now().difference(born).inDays < 365;
  }

  List<Animal> _filterGroup(List<Animal> animals) => switch (_group) {
        'lambs' => animals.where(_isLamb).toList(),
        'sheep' => animals.where((animal) => !_isLamb(animal)).toList(),
        _ => animals,
      };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Animal> _filterAnimals(List<Animal> animals) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return animals;
    final digits = query.replaceAll(RegExp(r'\D'), '');
      return animals.where((animal) {
      final tag = animal.earTag.toLowerCase();
      final tagDigits = tag.replaceAll(RegExp(r'\D'), '');
      return animal.name.toLowerCase().contains(query) ||
          animal.breed.toLowerCase().contains(query) ||
          tag.contains(query) ||
        (digits.length >= 3 && tagDigits.endsWith(digits));
    }).toList();
  }

  Future<void> _addAnimal() async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _paper,
      builder: (context) => AddAnimalSheet(database: widget.database),
    );
    if (saved == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Animalul a fost adăugat în turmă.')));
    }
  }

  Future<void> _addLambing() async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _paper,
      builder: (context) => AddLambingSheet(database: widget.database),
    );
    if (saved == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fătarea și mieii au fost salvați.')));
    }
  }

  Future<void> _addTreatment() async {
    final result = await showModalBottomSheet<({bool reminderRequested, bool reminderScheduled})>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _paper,
      builder: (context) => AddTreatmentSheet(database: widget.database),
    );
    if (result != null && mounted) {
      final message = !result.reminderRequested || result.reminderScheduled
          ? 'Tratamentul a fost salvat.'
          : 'Tratamentul a fost salvat, dar notificarea nu s-a programat. Verifică permisiunile și data controlului.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _addCurrentRecord() {
    if (_tabIndex == 0) {
      _addAnimal();
    } else if (_tabIndex == 1) {
      _addLambing();
    } else {
      _addTreatment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: _forest, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.grass_rounded, color: _paper, size: 20)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Stâna noastră', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
            Text(['EVIDENȚA TURMEI', 'JURNALUL MIEILOR', 'SĂNĂTATEA TURMEI'][_tabIndex], style: TextStyle(fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w700, color: _muted)),
          ]),
        ]),
        actions: widget.accountActions,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCurrentRecord,
        backgroundColor: _forest,
        foregroundColor: _paper,
        icon: const Icon(Icons.add),
        label: Text(['Animal nou', 'Fătare', 'Tratament'][_tabIndex], style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: _tabIndex == 0 ? StreamBuilder<List<Animal>>(
        stream: widget.database.watchAnimals(includeInactive: true, includeDeleted: true),
        builder: (context, snapshot) {
          if (snapshot.hasError) return _ErrorState(message: 'Nu am putut citi baza de date locală.');
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: _leaf));
          final activeCount = snapshot.data!.where((animal) => animal.deletedAt == null && animal.status == 'active').length;
          final grouped = _filterGroup(_filterStatus(snapshot.data!));
          final animals = _filterAnimals(grouped);
          return CustomScrollView(slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              sliver: SliverList.list(children: [
                const Text('Bună, oameni harnici.', style: TextStyle(fontFamily: 'serif', fontSize: 29, height: 1.2, fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
                const SizedBox(height: 6),
                const Text('Fișele animalelor voastre, păstrate la un loc.', style: TextStyle(fontSize: 13, color: _muted)),
                const SizedBox(height: 20),
                _SummaryBanner(count: activeCount),
                const SizedBox(height: 22),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Turma mea', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                  Text('${grouped.length} ${grouped.length == 1 ? 'animal' : 'animale'}', style: const TextStyle(fontSize: 11, color: _muted)),
                ]),
                const SizedBox(height: 12),
                Wrap(spacing: 8, children: [
                  for (final option in _statusFilters)
                    ChoiceChip(
                      label: Text(option.$2),
                      selected: _statusFilter == option.$1,
                      onSelected: (_) => setState(() => _statusFilter = option.$1),
                    ),
                ]),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: [
                  for (final option in const [('all', 'Toate'), ('sheep', 'Oi'), ('lambs', 'Miei')])
                    ChoiceChip(
                      label: Text(option.$2),
                      selected: _group == option.$1,
                      onSelected: (_) => setState(() => _group = option.$1),
                    ),
                ]),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Nume, rasă sau ultimele 3 cifre'),
                ),
                const SizedBox(height: 7),
              ]),
            ),
            if (animals.isEmpty)
              SliverFillRemaining(hasScrollBody: false, child: _EmptyState(hasQuery: _query.trim().isNotEmpty))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList.separated(
                  itemCount: animals.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: _line),
                  itemBuilder: (context, index) => _AnimalTile(
                    animal: animals[index],
                    onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => AnimalDetailScreen(database: widget.database, animalId: animals[index].id))),
                  ),
                ),
              ),
          ]);
        },
      ) : _tabIndex == 1
          ? LambingsScreen(database: widget.database)
          : TreatmentsScreen(database: widget.database),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) => setState(() => _tabIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.pets_outlined), selectedIcon: Icon(Icons.pets_rounded), label: 'Turmă'),
          NavigationDestination(icon: Icon(Icons.child_friendly_outlined), selectedIcon: Icon(Icons.child_friendly_rounded), label: 'Fătări'),
          NavigationDestination(icon: Icon(Icons.medical_services_outlined), selectedIcon: Icon(Icons.medical_services_rounded), label: 'Sănătate'),
        ],
      ),
    );
  }
}

class LambingsScreen extends StatefulWidget {
  const LambingsScreen({required this.database, super.key});
  final AppDatabase database;

  @override
  State<LambingsScreen> createState() => _LambingsScreenState();
}

class _LambingsScreenState extends State<LambingsScreen> {
  late int _selectedYear = lambingSeriesYear(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Lambing>>(
      stream: widget.database.watchLambings(),
      builder: (context, lambingSnapshot) {
        if (lambingSnapshot.hasError) return const _ErrorState(message: 'Nu am putut citi registrul fătărilor.');
        if (!lambingSnapshot.hasData) return const Center(child: CircularProgressIndicator(color: _leaf));
        return StreamBuilder<List<LambingLamb>>(
          stream: widget.database.watchLambingLambs(),
          builder: (context, linkSnapshot) => StreamBuilder<List<Animal>>(
          stream: widget.database.watchAnimals(includeInactive: true),
          builder: (context, animalSnapshot) {
            final animals = animalSnapshot.data ?? const <Animal>[];
            final byId = {for (final animal in animals) animal.id: animal};
            final lambsByLambing = <String, List<Animal>>{};
            for (final link in linkSnapshot.data ?? const <LambingLamb>[]) {
              final lamb = byId[link.animalId];
              if (lamb != null) lambsByLambing.putIfAbsent(link.lambingId, () => []).add(lamb);
            }
            final allRecords = lambingSnapshot.data!;
            final years = {
              lambingSeriesYear(DateTime.now()),
              ...allRecords.map((record) => lambingSeriesYear(record.occurredAt)),
            }.toList()
              ..sort((first, second) => second.compareTo(first));
            if (!years.contains(_selectedYear)) _selectedYear = years.first;
            final records = allRecords.where((record) => lambingSeriesYear(record.occurredAt) == _selectedYear).toList();
            return CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                sliver: SliverList.list(children: [
                  const Text('Fătări', style: TextStyle(fontFamily: 'serif', fontSize: 29, fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
                  const SizedBox(height: 5),
                  const Text('Mamele și mieii, cu istoricul lor păstrat.', style: TextStyle(fontSize: 13, color: _muted)),
                  const SizedBox(height: 18),
                  _SummaryBanner(count: records.length),
                  const SizedBox(height: 22),
                  DropdownButtonFormField<int>(
                    initialValue: _selectedYear,
                    decoration: const InputDecoration(labelText: 'Seria de fătări'),
                    items: [
                      for (final year in years) DropdownMenuItem(value: year, child: Text('Fătări $year')),
                    ],
                    onChanged: (year) {
                      if (year != null) setState(() => _selectedYear = year);
                    },
                  ),
                  const SizedBox(height: 14),
                  Text('Fătări $_selectedYear · ${records.length} ${records.length == 1 ? 'înregistrare' : 'înregistrări'}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                ]),
              ),
              if (records.isEmpty)
                SliverFillRemaining(hasScrollBody: false, child: _RecordEmptyState(icon: Icons.child_friendly_rounded, title: 'Nicio fătare în $_selectedYear', detail: 'Înregistrează fătările din această serie folosind butonul „Fătare”.'))
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList.separated(
                    itemCount: records.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: _line),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      final mother = byId[record.damId];
                      final lambs = lambsByLambing[record.id] ?? const <Animal>[];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const CircleAvatar(backgroundColor: Color(0xFFFAF0D6), child: Icon(Icons.child_friendly_rounded, color: Color(0xFFB5831D))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(formatDate(record.occurredAt), style: const TextStyle(fontSize: 11, color: _muted)),
                            const SizedBox(height: 3),
                            Text(mother?.name ?? 'Mamă necunoscută', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                            if (mother != null) Text('Crotaliu ${mother.earTag}', style: const TextStyle(fontSize: 10, color: _muted)),
                            const SizedBox(height: 5),
                            Text(record.notes.isEmpty ? record.birthType : '${record.birthType} · ${record.notes}', style: const TextStyle(fontSize: 11, color: _muted)),
                          ])),
                          const SizedBox(width: 10),
                          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            const Text('Miel / miei', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _muted)),
                            const SizedBox(height: 4),
                            if (lambs.isEmpty)
                              const Text('Înregistrare fără miel', style: TextStyle(fontSize: 10, color: _muted))
                            else
                              for (final lamb in lambs)
                                InkWell(
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => AnimalDetailScreen(database: widget.database, animalId: lamb.id))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text('${lamb.name.isEmpty ? 'Miel' : lamb.name} · ${lamb.earTag}', textAlign: TextAlign.end, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _leaf)),
                                  ),
                                ),
                          ]),
                        ]),
                      );
                    },
                  ),
                ),
            ]);
          },
        ),
        );
      },
    );
  }
}

class TreatmentsScreen extends StatelessWidget {
  const TreatmentsScreen({required this.database, super.key});
  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Treatment>>(
      stream: database.watchTreatments(),
      builder: (context, treatmentSnapshot) {
        if (treatmentSnapshot.hasError) return const _ErrorState(message: 'Nu am putut citi istoricul tratamentelor.');
        if (!treatmentSnapshot.hasData) return const Center(child: CircularProgressIndicator(color: _leaf));
        return StreamBuilder<List<Animal>>(
          stream: database.watchAnimals(includeInactive: true),
          builder: (context, animalSnapshot) {
            final byId = {for (final animal in animalSnapshot.data ?? const <Animal>[]) animal.id: animal};
            final records = treatmentSnapshot.data!;
            return CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                sliver: SliverList.list(children: [
                  const Text('Sănătate', style: TextStyle(fontFamily: 'serif', fontSize: 29, fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
                  const SizedBox(height: 5),
                  const Text('Tratamentele administrate și controalele următoare.', style: TextStyle(fontSize: 13, color: _muted)),
                  const SizedBox(height: 18),
                  _SummaryBanner(count: records.length),
                  const SizedBox(height: 22),
                  Text('${records.length} ${records.length == 1 ? 'înregistrare' : 'înregistrări'}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                ]),
              ),
              if (records.isEmpty)
                const SliverFillRemaining(hasScrollBody: false, child: _RecordEmptyState(icon: Icons.medical_services_outlined, title: 'Niciun tratament încă', detail: 'Adaugă un tratament pentru a începe istoricul medical.'))
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList.separated(
                    itemCount: records.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: _line),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      final animal = byId[record.animalId];
                      final dose = record.doseValue == null ? '' : ' · ${record.doseValue} ${record.doseUnit ?? ''}'.trimRight();
                      final followUp = record.followUpAt == null ? '' : '\nDe refăcut: ${formatDate(record.followUpAt!)}';
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: const CircleAvatar(backgroundColor: Color(0xFFF9E9E3), child: Icon(Icons.medical_services_outlined, color: Color(0xFFD96D54))),
                        title: Text(record.productName, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                        subtitle: Text('${animal?.name ?? 'Animal necunoscut'} · ${formatDate(record.administeredAt)}$dose$followUp${record.notes.isEmpty ? '' : '\n${record.notes}'}', style: const TextStyle(fontSize: 11, height: 1.5, color: _muted)),
                        isThreeLine: record.notes.isNotEmpty || record.followUpAt != null,
                      );
                    },
                  ),
                ),
            ]);
          },
        );
      },
    );
  }
}

class _RecordEmptyState extends StatelessWidget {
  const _RecordEmptyState({required this.icon, required this.title, required this.detail});
  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 28, 30, 90),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 38, color: _leaf),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
            const SizedBox(height: 5),
            Text(detail, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: _muted)),
          ]),
        ),
      );
}

class AddLambingSheet extends StatefulWidget {
  const AddLambingSheet({required this.database, super.key});
  final AppDatabase database;

  @override
  State<AddLambingSheet> createState() => _AddLambingSheetState();
}

class _AddLambingSheetState extends State<AddLambingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _notes = TextEditingController();
  final _motherSearch = TextEditingController();
  final _lambs = <_LambDraft>[_LambDraft()];
  String? _damId;
  DateTime _occurredAt = DateTime.now();
  String _birthType = 'single';
  bool _saving = false;

  @override
  void dispose() {
    _notes.dispose();
    _motherSearch.dispose();
    for (final lamb in _lambs) {
      lamb.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, initialDate: _occurredAt, firstDate: DateTime(1990), lastDate: DateTime.now());
    if (date != null) setState(() => _occurredAt = date);
  }

  List<Animal> _filterMothers(List<Animal> mothers) {
    final query = _motherSearch.text.trim().toLowerCase();
    if (query.isEmpty) return mothers.take(6).toList();
    final digits = query.replaceAll(RegExp(r'\D'), '');
    return mothers.where((animal) {
      final tagDigits = animal.earTag.replaceAll(RegExp(r'\D'), '');
      return animal.name.toLowerCase().contains(query) ||
          animal.breed.toLowerCase().contains(query) ||
          animal.earTag.toLowerCase().contains(query) ||
        (digits.length >= 3 && tagDigits.endsWith(digits));
    }).take(6).toList();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _damId == null) return;
    setState(() => _saving = true);
    try {
      await widget.database.recordLambing(
        lambingId: const Uuid().v4(),
        damId: _damId!,
        occurredAt: _occurredAt,
        birthType: _birthType,
        notes: _notes.text,
        lambs: _lambs.map((lamb) => LambBirth(
          name: lamb.name.text,
          sex: lamb.sex,
          breed: lamb.breed.text,
          earTag: lamb.earTag.text,
          mark: lamb.mark.text,
          birthWeightKg: double.tryParse(lamb.weight.text.replaceAll(',', '.')),
          notes: lamb.notes.text,
        )).toList(),
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      _showSaveError(error);
    }
  }

  void _showSaveError(Object error) {
    if (!mounted) return;
    setState(() => _saving = false);
    final duplicate = error.toString().toLowerCase().contains('unique');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(duplicate ? 'Unul dintre crotalii este deja folosit.' : 'Nu am putut salva fătarea. Verifică datele și încearcă din nou.')));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Animal>>(
      stream: widget.database.watchAnimals(),
      builder: (context, snapshot) {
        final mothers = (snapshot.data ?? const <Animal>[]).where((animal) => animal.sex == 'Femelă' && animal.status == 'active').toList();
        final filteredMothers = _filterMothers(mothers);
        Animal? selectedMother;
        for (final mother in mothers) {
          if (mother.id == _damId) {
            selectedMother = mother;
            break;
          }
        }
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.91,
            maxChildSize: 0.97,
            builder: (context, scrollController) => Column(children: [
              const _SheetHeader(eyebrow: 'JURNALUL MIEILOR', title: 'Înregistrează fătarea'),
              if (mothers.isEmpty)
                const Expanded(child: _RecordEmptyState(icon: Icons.pets_outlined, title: 'Nu există mame active', detail: 'Adaugă mai întâi o oaie femelă în turmă.'))
              else
                Expanded(child: Form(
                  key: _formKey,
                  child: ListView(controller: scrollController, padding: const EdgeInsets.fromLTRB(22, 4, 22, 18), children: [
                    const _FormLabel(label: 'Mama'),
                    TextField(
                      controller: _motherSearch,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Nume, rasă sau crotaliu',
                        suffixIcon: _motherSearch.text.isEmpty
                            ? null
                            : IconButton(tooltip: 'Șterge căutarea', onPressed: () { _motherSearch.clear(); setState(() {}); }, icon: const Icon(Icons.close_rounded)),
                      ),
                    ),
                    if (selectedMother != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        decoration: BoxDecoration(color: const Color(0xFFE8F1E8), borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          const Icon(Icons.check_circle_rounded, color: _leaf, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Mama selectată: ${selectedMother.name} · ${selectedMother.earTag}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _forest))),
                        ]),
                      ),
                    ] else
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Selectează mama pentru această fătare.', style: TextStyle(fontSize: 11, color: _muted)),
                      ),
                    if (filteredMothers.isEmpty)
                      const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Nu am găsit o oaie după acest criteriu.', style: TextStyle(fontSize: 11, color: _muted)))
                    else
                      ...filteredMothers.map((mother) => ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(mother.id == _damId ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: mother.id == _damId ? _leaf : _muted, size: 19),
                            title: Text(mother.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            subtitle: Text('${mother.breed} · ${mother.earTag}', style: const TextStyle(fontSize: 10)),
                            onTap: () => setState(() => _damId = mother.id),
                          )),
                    const SizedBox(height: 14),
                    const _FormLabel(label: 'Data fătării'),
                    OutlinedButton.icon(onPressed: _pickDate, icon: const Icon(Icons.calendar_month_rounded), label: Text(formatDate(_occurredAt)), style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
                    const SizedBox(height: 14),
                    const _FormLabel(label: 'Tipul fătării'),
                    DropdownButtonFormField<String>(
                      initialValue: _birthType,
                      items: const [DropdownMenuItem(value: 'single', child: Text('Un miel')), DropdownMenuItem(value: 'twins', child: Text('Gemeni')), DropdownMenuItem(value: 'triplets', child: Text('Tripleți')), DropdownMenuItem(value: 'other', child: Text('Altă situație'))],
                      onChanged: (value) => setState(() => _birthType = value ?? 'single'),
                    ),
                    const SizedBox(height: 18),
                    Row(children: [
                      const Expanded(child: Text('Mieii', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF18352B)))),
                      TextButton.icon(onPressed: () => setState(() => _lambs.add(_LambDraft())), icon: const Icon(Icons.add, size: 18), label: const Text('Adaugă miel')),
                    ]),
                    for (var index = 0; index < _lambs.length; index++)
                      _LambFormCard(
                        key: ObjectKey(_lambs[index]),
                        index: index,
                        draft: _lambs[index],
                        canRemove: _lambs.length > 1,
                        onRemove: () => setState(() { final removed = _lambs.removeAt(index); removed.dispose(); }),
                      ),
                    const SizedBox(height: 12),
                    const _FormLabel(label: 'Observații despre fătare (opțional)'),
                    TextFormField(controller: _notes, maxLines: 2, decoration: const InputDecoration(hintText: 'Note despre mamă sau fătare')),
                    const SizedBox(height: 24),
                    SizedBox(width: double.infinity, height: 49, child: FilledButton.icon(onPressed: _saving || _damId == null ? null : _save, icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.check_rounded), label: Text(_saving ? 'Se salvează…' : 'Salvează fătarea'))),
                    const SizedBox(height: 8),
                  ]),
                )),
            ]),
          ),
        );
      },
    );
  }
}

class _LambDraft {
  final name = TextEditingController();
  final breed = TextEditingController();
  final earTag = TextEditingController();
  final mark = TextEditingController();
  final weight = TextEditingController();
  final notes = TextEditingController();
  String sex = 'Femelă';

  void dispose() {
    name.dispose();
    breed.dispose();
    earTag.dispose();
    mark.dispose();
    weight.dispose();
    notes.dispose();
  }
}

class _LambFormCard extends StatefulWidget {
  const _LambFormCard({required this.index, required this.draft, required this.canRemove, required this.onRemove, super.key});
  final int index;
  final _LambDraft draft;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  State<_LambFormCard> createState() => _LambFormCardState();
}

class _LambFormCardState extends State<_LambFormCard> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: _cream, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Expanded(child: Text('Mielul ${widget.index + 1}', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF18352B)))), if (widget.canRemove) IconButton(onPressed: widget.onRemove, icon: const Icon(Icons.remove_circle_outline), visualDensity: VisualDensity.compact)]),
          TextFormField(controller: widget.draft.name, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(labelText: 'Nume (opțional)')),
          const SizedBox(height: 9),
          SegmentedButton<String>(segments: const [ButtonSegment(value: 'Femelă', label: Text('Femelă')), ButtonSegment(value: 'Mascul', label: Text('Mascul'))], selected: {widget.draft.sex}, onSelectionChanged: (selection) => setState(() => widget.draft.sex = selection.first)),
          const SizedBox(height: 9),
          TextFormField(controller: widget.draft.breed, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Rasă (goală = rasa mamei)')),
          const SizedBox(height: 9),
          TextFormField(controller: widget.draft.earTag, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Crotaliu'), validator: (value) => value == null || value.trim().isEmpty ? 'Crotaliul este obligatoriu.' : null),
          const SizedBox(height: 9),
          TextFormField(controller: widget.draft.weight, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Greutate la naștere (kg, opțional)'), validator: (value) { if (value == null || value.trim().isEmpty) return null; final weight = double.tryParse(value.replaceAll(',', '.')); return weight == null || weight <= 0 ? 'Introdu o greutate validă.' : null; }),
          const SizedBox(height: 9),
          TextFormField(controller: widget.draft.mark, decoration: const InputDecoration(labelText: 'Semn (opțional)')),
        ]),
      );
}

class AddTreatmentSheet extends StatefulWidget {
  const AddTreatmentSheet({required this.database, super.key});
  final AppDatabase database;

  @override
  State<AddTreatmentSheet> createState() => _AddTreatmentSheetState();
}

class _AddTreatmentSheetState extends State<AddTreatmentSheet> {
  final _formKey = GlobalKey<FormState>();
  final _animalSearch = TextEditingController();
  final _product = TextEditingController();
  final _ingredient = TextEditingController();
  final _dose = TextEditingController();
  final _unit = TextEditingController();
  final _reason = TextEditingController();
  final _notes = TextEditingController();
  final _meatWait = TextEditingController();
  final _milkWait = TextEditingController();
  final _animalIds = <String>{};
  DateTime _administeredAt = DateTime.now();
  DateTime? _followUpAt;
  bool _saving = false;

  @override
  void dispose() {
    _animalSearch.dispose();
    _product.dispose(); _ingredient.dispose(); _dose.dispose(); _unit.dispose(); _reason.dispose(); _notes.dispose(); _meatWait.dispose(); _milkWait.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(DateTime initial) => showDatePicker(context: context, initialDate: initial, firstDate: DateTime(1990), lastDate: DateTime(2100));

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_animalIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selectează cel puțin un animal.')));
      return;
    }
    setState(() => _saving = true);
    final selectedIds = _animalIds.toList();
    final treatmentIds = {for (final animalId in selectedIds) animalId: const Uuid().v4()};
    final scheduledTreatmentIds = <String>[];
    var reminderScheduled = _followUpAt == null;
    try {
      if (_followUpAt != null) {
        final selectedAnimals = await (widget.database.select(widget.database.animals)..where((row) => row.id.isIn(selectedIds))).get();
        final animalsById = {for (final animal in selectedAnimals) animal.id: animal};
        reminderScheduled = true;
        for (final animalId in selectedIds) {
          final animal = animalsById[animalId];
          if (animal == null) {
            reminderScheduled = false;
            continue;
          }
          try {
            final scheduled = await TreatmentNotifications.scheduleFollowUp(
              treatmentId: treatmentIds[animalId]!,
              animalName: animal.name,
              treatmentName: _product.text.trim(),
              followUpDate: _followUpAt!,
            );
            reminderScheduled = reminderScheduled && scheduled;
            if (scheduled) scheduledTreatmentIds.add(treatmentIds[animalId]!);
          } catch (_) {
            reminderScheduled = false;
          }
        }
      }
      await widget.database.recordTreatments(
        treatmentIds: treatmentIds,
        animalIds: selectedIds,
        productName: _product.text,
        activeIngredient: _ingredient.text,
        doseValue: double.tryParse(_dose.text.replaceAll(',', '.')),
        doseUnit: _unit.text,
        administeredAt: _administeredAt,
        reason: _reason.text,
        notes: _notes.text,
        withdrawalMeatDays: int.tryParse(_meatWait.text),
        withdrawalMilkDays: int.tryParse(_milkWait.text),
        followUpAt: _followUpAt,
      );
      if (mounted) Navigator.of(context).pop((reminderRequested: _followUpAt != null, reminderScheduled: reminderScheduled));
    } catch (_) {
      for (final treatmentId in scheduledTreatmentIds) {
        try {
          await TreatmentNotifications.cancelFollowUp(treatmentId);
        } catch (_) {}
      }
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nu am putut salva tratamentul. Verifică datele.')));
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Animal>>(
        stream: widget.database.watchAnimals(),
        builder: (context, snapshot) {
          final animals = snapshot.data ?? const <Animal>[];
          final query = _animalSearch.text.trim().toLowerCase();
          final queryDigits = query.replaceAll(RegExp(r'\D'), '');
          final filteredAnimals = animals.where((animal) {
            if (query.isEmpty) return true;
            final tagDigits = animal.earTag.replaceAll(RegExp(r'\D'), '');
            return animal.name.toLowerCase().contains(query) ||
                animal.breed.toLowerCase().contains(query) ||
                animal.earTag.toLowerCase().contains(query) ||
                (queryDigits.length >= 3 && tagDigits.endsWith(queryDigits));
          }).toList();
          final allFilteredSelected = filteredAnimals.isNotEmpty && filteredAnimals.every((animal) => _animalIds.contains(animal.id));
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.9,
              maxChildSize: 0.97,
              builder: (context, scrollController) => Column(children: [
                const _SheetHeader(eyebrow: 'SĂNĂTATEA TURMEI', title: 'Tratament nou'),
                if (animals.isEmpty)
                  const Expanded(child: _RecordEmptyState(icon: Icons.pets_outlined, title: 'Turma este goală', detail: 'Adaugă mai întâi un animal.'))
                else
                  Expanded(child: Form(key: _formKey, child: ListView(controller: scrollController, padding: const EdgeInsets.fromLTRB(22, 4, 22, 18), children: [
                    const _FormLabel(label: 'Animale tratate'),
                    TextField(
                      controller: _animalSearch,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Nume, rasă sau crotaliu',
                        suffixIcon: _animalSearch.text.isEmpty ? null : IconButton(onPressed: () { _animalSearch.clear(); setState(() {}); }, icon: const Icon(Icons.close_rounded)),
                      ),
                    ),
                    Row(children: [
                      Expanded(child: Text('${_animalIds.length} selectate', style: const TextStyle(fontSize: 11, color: _muted))),
                      TextButton(
                        onPressed: filteredAnimals.isEmpty ? null : () => setState(() {
                          if (allFilteredSelected) {
                            _animalIds.removeAll(filteredAnimals.map((animal) => animal.id));
                          } else {
                            _animalIds.addAll(filteredAnimals.map((animal) => animal.id));
                          }
                        }),
                        child: Text(allFilteredSelected ? 'Deselectează rezultatele' : 'Selectează rezultatele'),
                      ),
                    ]),
                    if (filteredAnimals.isEmpty)
                      const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Nu am găsit animale după acest criteriu.', style: TextStyle(fontSize: 11, color: _muted)))
                    else
                      Container(
                        constraints: const BoxConstraints(maxHeight: 220),
                        decoration: BoxDecoration(color: _cream, borderRadius: BorderRadius.circular(11)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredAnimals.length,
                          itemBuilder: (context, index) {
                            final animal = filteredAnimals[index];
                            return CheckboxListTile(
                              dense: true,
                              value: _animalIds.contains(animal.id),
                              onChanged: (selected) => setState(() {
                                if (selected == true) { _animalIds.add(animal.id); } else { _animalIds.remove(animal.id); }
                              }),
                              title: Text(animal.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                              subtitle: Text('${animal.breed} · ${animal.earTag}', style: const TextStyle(fontSize: 10)),
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 13),
                    const _FormLabel(label: 'Produs / tratament'),
                    TextFormField(controller: _product, decoration: const InputDecoration(hintText: 'De ex. deparazitare'), validator: (value) => value == null || value.trim().isEmpty ? 'Completează numele tratamentului.' : null),
                    const SizedBox(height: 12),
                    TextFormField(controller: _ingredient, decoration: const InputDecoration(labelText: 'Substanță activă (opțional)')),
                    const SizedBox(height: 12),
                    Row(children: [Expanded(child: TextFormField(controller: _dose, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Doză'))), const SizedBox(width: 10), SizedBox(width: 110, child: TextFormField(controller: _unit, decoration: const InputDecoration(labelText: 'Unitate')))]),
                    const SizedBox(height: 12),
                    const _FormLabel(label: 'Data administrării'),
                    OutlinedButton.icon(onPressed: () async { final date = await _pickDate(_administeredAt); if (date != null) setState(() => _administeredAt = date); }, icon: const Icon(Icons.calendar_month_rounded), label: Text(formatDate(_administeredAt)), style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft)),
                    const SizedBox(height: 12),
                    TextFormField(controller: _reason, decoration: const InputDecoration(labelText: 'Motiv (opțional)')),
                    const SizedBox(height: 12),
                    Row(children: [Expanded(child: TextFormField(controller: _meatWait, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Așteptare carne (zile)'), validator: _nonNegativeInteger)), const SizedBox(width: 10), Expanded(child: TextFormField(controller: _milkWait, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Așteptare lapte (zile)'), validator: _nonNegativeInteger))]),
                    const SizedBox(height: 12),
                    const _FormLabel(label: 'Data controlului (opțional)'),
                    OutlinedButton.icon(onPressed: () async { final date = await _pickDate(_followUpAt ?? DateTime.now()); if (date != null) setState(() => _followUpAt = date); }, icon: const Icon(Icons.notifications_outlined), label: Text(_followUpAt == null ? 'Alege data' : formatDate(_followUpAt!)), style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft)),
                    if (_followUpAt != null) Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => setState(() => _followUpAt = null), child: const Text('Șterge data controlului'))),
                    const SizedBox(height: 12),
                    TextFormField(controller: _notes, maxLines: 2, decoration: const InputDecoration(labelText: 'Observații (opțional)')),
                    const SizedBox(height: 24),
                    SizedBox(width: double.infinity, height: 49, child: FilledButton.icon(onPressed: _saving || _animalIds.isEmpty ? null : _save, icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.check_rounded), label: Text(_saving ? 'Se salvează…' : 'Salvează pentru ${_animalIds.length}'))),
                    const SizedBox(height: 8),
                  ]))),
              ]),
            ),
          );
        },
      );

  String? _nonNegativeInteger(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final number = int.tryParse(value);
    return number == null || number < 0 ? 'Introdu zile întregi, zero sau mai mult.' : null;
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.eyebrow, required this.title});
  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
        child: Column(children: [
          Container(width: 38, height: 4, decoration: BoxDecoration(color: const Color(0xFFD8DBD2), borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(eyebrow, style: const TextStyle(fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w800, color: _leaf)),
              Text(title, style: const TextStyle(fontSize: 22, fontFamily: 'serif', fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
            ])),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close_rounded)),
          ]),
        ]),
      );
}

class _SummaryBanner extends StatelessWidget {
  const _SummaryBanner({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFFE8F1E8), borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(width: 42, height: 42, decoration: BoxDecoration(color: _paper.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.pets_rounded, color: _leaf)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$count', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
            const Text('animale înregistrate pe acest dispozitiv', style: TextStyle(fontSize: 11, color: _muted)),
          ])),
          const Icon(Icons.phone_android_rounded, color: _leaf, size: 18),
        ]),
      );
}

class _AnimalTile extends StatelessWidget {
  const _AnimalTile({required this.animal, required this.onTap});
  final Animal animal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final female = animal.sex == 'Femelă';
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: CircleAvatar(backgroundColor: female ? const Color(0xFFE8F1E8) : const Color(0xFFE5F0F1), child: Icon(Icons.pets_rounded, color: female ? _leaf : const Color(0xFF4A8290), size: 20)),
      title: Text(animal.name, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
      subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text('${animal.breed} · ${animal.sex.toLowerCase()}\nCrotaliu ${animal.earTag}', style: const TextStyle(fontSize: 11, height: 1.45, color: _muted))),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        EarMarksView(marks: EarMarks.decode(animal.earMarks), height: 28, showLabels: false),
        const Icon(Icons.chevron_right_rounded, color: Color(0xFFA7AEA5)),
      ]),
      isThreeLine: true,
      onTap: onTap,
    );
  }
}

class AnimalDetailScreen extends StatefulWidget {
  const AnimalDetailScreen({required this.database, required this.animalId, super.key});

  final AppDatabase database;
  final String animalId;

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  late Future<AnimalHistory> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = widget.database.loadAnimalHistory(widget.animalId);
  }

  Future<void> _editAnimal() async {
    final history = await widget.database.loadAnimalHistory(widget.animalId);
    if (!mounted) return;
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _paper,
      builder: (context) => AddAnimalSheet(database: widget.database, animal: history.animal),
    );
    if (saved == true && mounted) {
      setState(() => _historyFuture = widget.database.loadAnimalHistory(widget.animalId));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fișa animalului a fost actualizată.')));
    }
  }

  Future<void> _changeStatus(Animal animal) async {
    final notes = TextEditingController();
    var status = animal.status;
    var date = DateTime.now();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Schimbă starea'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final option in const [('active', 'În turmă'), ('sold', 'Vândut(ă)'), ('slaughtered', 'Sacrificat(ă)'), ('deceased', 'Decedat(ă)'), ('transferred', 'Transferat(ă)')])
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(status == option.$1 ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: _leaf),
                  title: Text(option.$2),
                  onTap: () => setLocal(() => status = option.$1),
                ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.event_outlined),
                label: Text(formatDate(date)),
                onPressed: () async {
                  final picked = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2000), lastDate: DateTime.now());
                  if (picked != null) setLocal(() => date = picked);
                },
              ),
              const SizedBox(height: 8),
              TextField(controller: notes, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Detalii (ex: cumpărător, preț)'), maxLines: 2),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Anulează')),
            FilledButton(onPressed: status == animal.status ? null : () => Navigator.pop(context, true), child: const Text('Salvează')),
          ],
        ),
      ),
    );
    final text = notes.text;
    notes.dispose();
    if (confirmed != true || !mounted) return;
    await widget.database.archiveAnimal(animalId: animal.id, status: status, notes: text, occurredAt: date);
    if (!mounted) return;
    setState(() => _historyFuture = widget.database.loadAnimalHistory(widget.animalId));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starea animalului a fost actualizată.')));
  }

  Future<void> _deleteAnimal(Animal animal) async {
    final confirmation = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Ștergi definitiv animalul?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('„${animal.name}” și tratamentele, cântăririle și evenimentele lui vor dispărea de pe toate dispozitivele. Dacă a fost doar vândut sau sacrificat, folosește „Schimbă” la stare.'),
            const SizedBox(height: 12),
            Text('Scrie ȘTERGE ca să confirmi:', style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            TextField(controller: confirmation, autocorrect: false, textCapitalization: TextCapitalization.characters, onChanged: (_) => setLocal(() {})),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Anulează')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB3261E)),
              onPressed: confirmation.text.trim().toUpperCase() == 'ȘTERGE' || confirmation.text.trim().toUpperCase() == 'STERGE' ? () => Navigator.pop(context, true) : null,
              child: const Text('Șterge'),
            ),
          ],
        ),
      ),
    );
    confirmation.dispose();
    if (confirmed != true || !mounted) return;
    await widget.database.deleteAnimal(animal.id);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _restoreAnimal(Animal animal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurezi animalul?'),
        content: Text('„${animal.name}” și istoricul salvat împreună cu el vor reveni în aplicație.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Anulează')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Restaurează')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await widget.database.restoreAnimal(animal.id);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nu am putut restaura animalul. Verifică dacă acest crotaliu este deja folosit de alt animal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Fișa animalului'),
          actions: [IconButton(tooltip: 'Editează fișa', onPressed: _editAnimal, icon: const Icon(Icons.edit_outlined))],
        ),
        body: FutureBuilder<AnimalHistory>(
          future: _historyFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) return const _ErrorState(message: 'Nu am putut încărca fișa animalului.');
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: _leaf));
            final history = snapshot.data!;
            final animal = history.animal;
            final mother = history.mother;
            final motherMarks = mother == null ? const EarMarks() : EarMarks.decode(mother.earMarks);
            final motherMarkDescription = [
              motherMarks.summary,
              if (mother?.mark.isNotEmpty == true) mother!.mark,
            ].where((value) => value.isNotEmpty).join(' · ');
            return CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                sliver: SliverList.list(children: [
                  Row(children: [
                    CircleAvatar(radius: 29, backgroundColor: const Color(0xFFE8F1E8), child: Icon(Icons.pets_rounded, size: 27, color: animal.sex == 'Femelă' ? _leaf : const Color(0xFF4A8290))),
                    const SizedBox(width: 13),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(animal.name, style: const TextStyle(fontFamily: 'serif', fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
                      Text('${animal.breed} · ${animal.sex}', style: const TextStyle(fontSize: 12, color: _muted)),
                    ])),
                  ]),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: _paper, border: Border.all(color: _line), borderRadius: BorderRadius.circular(12)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _DetailField(label: 'CROTALIU', value: animal.earTag),
                      if (animal.internalNumber != null && animal.internalNumber!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _DetailField(label: 'NUMĂR INTERN', value: animal.internalNumber!),
                      ],
                      const SizedBox(height: 12),
                      if (!EarMarks.decode(animal.earMarks).isEmpty) ...[
                        _DetailField(label: 'SEMNE LA URECHI ȘI COARNE', value: EarMarks.decode(animal.earMarks).summary),
                        const SizedBox(height: 10),
                        Center(child: EarMarksView(marks: EarMarks.decode(animal.earMarks), height: 90)),
                        if (animal.mark.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _DetailField(label: 'ALTE DETALII DESPRE SEMN', value: animal.mark),
                        ],
                      ] else
                        _DetailField(label: 'SEMN LA URECHI', value: animal.mark.isEmpty ? 'Nespecificat' : animal.mark),
                      if (animal.birthDate != null) ...[
                        const SizedBox(height: 12),
                        _DetailField(label: 'DATA NAȘTERII', value: _dateText(context, animal.birthDate!)),
                      ],
                      const SizedBox(height: 12),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Expanded(child: _DetailField(label: 'STARE', value: animal.deletedAt == null ? _statusText(animal.status) : 'Șters')),
                        if (animal.deletedAt == null)
                          OutlinedButton(onPressed: () => _changeStatus(animal), child: const Text('Schimbă')),
                      ]),
                    ]),
                  ),
                  if (mother != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: const Color(0xFFE8F1E8), border: Border.all(color: _line), borderRadius: BorderRadius.circular(12)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text('MAMA', style: TextStyle(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w800, color: _leaf)),
                        const SizedBox(height: 8),
                        Text(mother.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                        const SizedBox(height: 10),
                        _DetailField(label: 'CROTALIU', value: mother.earTag),
                        if (mother.internalNumber != null && mother.internalNumber!.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          _DetailField(label: 'NUMĂR INTERN', value: mother.internalNumber!),
                        ],
                        const SizedBox(height: 10),
                        _DetailField(label: 'RASĂ · SEX', value: '${mother.breed} · ${mother.sex}'),
                        if (mother.birthDate != null) ...[
                          const SizedBox(height: 10),
                          _DetailField(label: 'DATA NAȘTERII', value: _dateText(context, mother.birthDate!)),
                        ],
                        const SizedBox(height: 10),
                        _DetailField(label: 'STARE', value: _statusText(mother.status)),
                        const SizedBox(height: 10),
                        _DetailField(
                          label: 'SEMNE LA URECHI ȘI COARNE',
                          value: motherMarkDescription.isEmpty ? 'Nespecificat' : motherMarkDescription,
                        ),
                        const SizedBox(height: 6),
                        Center(child: EarMarksView(marks: motherMarks, height: 75)),
                      ]),
                    ),
                  ],
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: animal.deletedAt == null ? () => _deleteAnimal(animal) : () => _restoreAnimal(animal),
                      icon: Icon(animal.deletedAt == null ? Icons.delete_outline_rounded : Icons.restore_rounded),
                      label: Text(animal.deletedAt == null ? 'Șterge animalul definitiv' : 'Restaurează animalul și istoricul'),
                      style: TextButton.styleFrom(foregroundColor: animal.deletedAt == null ? const Color(0xFFB3261E) : _leaf),
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Text('Istoric', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                  const SizedBox(height: 4),
                  const Text('Fătări, tratamente și alte evenimente', style: TextStyle(fontSize: 11, color: _muted)),
                ]),
              ),
              if (history.entries.isEmpty)
                const SliverFillRemaining(hasScrollBody: false, child: _RecordEmptyState(icon: Icons.history_rounded, title: 'Istoricul începe aici', detail: 'Înregistrările asociate acestui animal vor apărea aici.'))
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  sliver: SliverList.separated(
                    itemCount: history.entries.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: _line),
                    itemBuilder: (context, index) {
                      final entry = history.entries[index];
                      final style = _historyStyle(entry.category);
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: CircleAvatar(backgroundColor: style.$2, child: Icon(style.$1, color: style.$3, size: 19)),
                        title: Text(entry.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF18352B))),
                        subtitle: Text('${_dateText(context, entry.occurredAt)}${entry.detail.isEmpty ? '' : '\n${entry.detail}'}', style: const TextStyle(fontSize: 11, height: 1.5, color: _muted)),
                        isThreeLine: entry.detail.contains('\n'),
                      );
                    },
                  ),
                ),
            ]);
          },
        ),
      );

  String _dateText(BuildContext context, DateTime date) => formatDate(date);

  String _statusText(String status) => switch (status) {
        'active' => 'În turmă',
        'sold' => 'Vândut(ă)',
        'slaughtered' => 'Sacrificat(ă)',
        'deceased' => 'Decedat(ă)',
        'transferred' => 'Transferat(ă)',
        _ => status,
      };

  (IconData, Color, Color) _historyStyle(String category) => switch (category) {
        'birth' || 'lambing' => (Icons.child_friendly_rounded, const Color(0xFFFAF0D6), const Color(0xFFB5831D)),
        'treatment' => (Icons.medical_services_outlined, const Color(0xFFF9E9E3), const Color(0xFFD96D54)),
        'weighing' => (Icons.monitor_weight_outlined, const Color(0xFFE5F0F1), const Color(0xFF4A8290)),
        'breeding' => (Icons.favorite_border_rounded, const Color(0xFFF9E9E3), const Color(0xFFD96D54)),
        _ => (Icons.event_note_rounded, const Color(0xFFE8F1E8), _leaf),
      };
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 8, letterSpacing: 0.8, fontWeight: FontWeight.w800, color: _muted)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF18352B))),
      ]);
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasQuery});
  final bool hasQuery;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 90),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.grass_rounded, size: 34, color: _leaf),
            const SizedBox(height: 10),
            Text(hasQuery ? 'Nu am găsit animalul' : 'Turma începe aici', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF18352B))),
            const SizedBox(height: 5),
            Text(hasQuery ? 'Caută după nume, rasă sau crotaliu.' : 'Adaugă prima fișă cu butonul „Animal nou”.', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: _muted)),
          ]),
        ),
      );
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(message, textAlign: TextAlign.center, style: const TextStyle(color: _muted))));
}

class AddAnimalSheet extends StatefulWidget {
  const AddAnimalSheet({required this.database, this.animal, super.key});
  final AppDatabase database;
  final Animal? animal;

  @override
  State<AddAnimalSheet> createState() => _AddAnimalSheetState();
}

class _AddAnimalSheetState extends State<AddAnimalSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _breed = TextEditingController();
  final _earTag = TextEditingController();
  final _mark = TextEditingController();
  EarMarks _earMarks = const EarMarks();
  String _sex = 'Femelă';
  DateTime? _birthDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final animal = widget.animal;
    if (animal != null) {
      _name.text = animal.name;
      _breed.text = animal.breed;
      _earTag.text = animal.earTag;
      _mark.text = animal.mark;
      _earMarks = EarMarks.decode(animal.earMarks);
      _sex = animal.sex;
      _birthDate = animal.birthDate;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _breed.dispose();
    _earTag.dispose();
    _mark.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final today = DateTime.now();
    final earliestDate = DateTime(1900);
    final currentDate = _birthDate;
    final initialDate = currentDate == null || currentDate.isAfter(today)
        ? today
        : currentDate.isBefore(earliestDate)
            ? earliestDate
            : currentDate;
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: earliestDate,
      lastDate: today,
      locale: const Locale('ro', 'RO'),
    );
    if (date != null) setState(() => _birthDate = date);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final existingAnimal = widget.animal;
      if (existingAnimal == null) {
        await widget.database.addAnimal(
          id: const Uuid().v4(),
          name: _name.text,
          sex: _sex,
          breed: _breed.text,
          earTag: _earTag.text,
          mark: _mark.text,
          earMarks: _earMarks.encode(),
          birthDate: _birthDate,
        );
      } else {
        final oldGeneratedName = 'Miel ${existingAnimal.earTag}';
        final editedName = _name.text.trim() == oldGeneratedName && _earTag.text.trim() != existingAnimal.earTag
            ? 'Miel ${_earTag.text.trim()}'
            : _name.text;
        await widget.database.updateAnimal(
          id: existingAnimal.id,
          name: editedName,
          sex: _sex,
          breed: _breed.text,
          earTag: _earTag.text,
          mark: _mark.text,
          earMarks: _earMarks.encode(),
          birthDate: _birthDate,
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      final isDuplicateTag = error.toString().toLowerCase().contains('unique');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isDuplicateTag ? 'Crotaliul este deja folosit.' : 'Nu am putut salva fișa. Verifică datele și încearcă din nou.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.88,
        maxChildSize: 0.96,
        builder: (context, scrollController) => Column(children: [
          const SizedBox(height: 10),
          Container(width: 38, height: 4, decoration: BoxDecoration(color: const Color(0xFFD8DBD2), borderRadius: BorderRadius.circular(3))),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 12),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('EVIDENȚA TURMEI', style: TextStyle(fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w800, color: _leaf)),
                SizedBox(height: 4),
                Text(widget.animal == null ? 'Animal nou' : 'Editează animalul', style: TextStyle(fontSize: 23, fontFamily: 'serif', fontWeight: FontWeight.w700, color: Color(0xFF18352B))),
              ])),
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close_rounded)),
            ]),
          ),
          Expanded(child: Form(
            key: _formKey,
            child: ListView(controller: scrollController, padding: const EdgeInsets.fromLTRB(22, 4, 22, 16), children: [
              _FormLabel(label: 'Nume sau descriere'),
              TextFormField(controller: _name, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'De ex. Mioara'), validator: _required),
              const SizedBox(height: 15),
              const _FormLabel(label: 'Sex'),
              SegmentedButton<String>(segments: const [ButtonSegment(value: 'Femelă', label: Text('Femelă')), ButtonSegment(value: 'Mascul', label: Text('Mascul'))], selected: {_sex}, onSelectionChanged: (selection) => setState(() => _sex = selection.first)),
              const SizedBox(height: 15),
              _FormLabel(label: 'Rasă'),
              TextFormField(controller: _breed, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(hintText: 'De ex. Țurcană'), validator: _required),
              const SizedBox(height: 15),
              _FormLabel(label: 'Număr de crotaliu'),
              TextFormField(controller: _earTag, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(hintText: 'De ex. RO-004'), validator: _required),
              const SizedBox(height: 15),
              _FormLabel(label: 'Semne la urechi și coarne'),
              EarMarksEditor(value: _earMarks, onChanged: (value) => setState(() => _earMarks = value)),
              const SizedBox(height: 15),
              _FormLabel(label: 'Alte detalii despre semn (opțional)'),
              TextFormField(controller: _mark, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Pentru semne care nu se găsesc în listă'), maxLines: 2),
              const SizedBox(height: 15),
              const _FormLabel(label: 'Data nașterii (opțional)'),
              OutlinedButton.icon(onPressed: _pickBirthDate, icon: const Icon(Icons.calendar_month_rounded), label: Text(_birthDate == null ? 'Alege data' : formatDate(_birthDate!)), style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, height: 49, child: FilledButton.icon(onPressed: _saving ? null : _save, icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.check_rounded), label: Text(_saving ? 'Se salvează…' : widget.animal == null ? 'Adaugă în turmă' : 'Salvează modificările'))),
              const SizedBox(height: 8),
            ]),
          )),
        ]),
      ),
    );
  }

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'Completează acest câmp.' : null;
}

class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF18352B))));
}
