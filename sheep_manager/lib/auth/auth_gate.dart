import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/app_database.dart';
import '../main.dart';
import '../services/sync_service.dart';
import 'farm_service.dart';

String _authMessage(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'invalid-credential' || 'wrong-password' || 'user-not-found' || 'invalid-login-credentials' => 'Email sau parolă greșită.',
      'email-already-in-use' => 'Există deja un cont cu acest email. Alege „Am deja cont”.',
      'weak-password' => 'Parola trebuie să aibă cel puțin 6 caractere.',
      'invalid-email' => 'Adresa de email nu este validă.',
      'network-request-failed' => 'Nu ai internet. Încearcă din nou când te conectezi.',
      'too-many-requests' => 'Prea multe încercări. Așteaptă câteva minute.',
      _ => 'Autentificarea a eșuat (${error.code}).',
    };
  }
  if (error is FarmException) return error.message;
  if (error is FirebaseException && error.code == 'permission-denied') return 'Nu ai acces la această gospodărie.';
  if (error is FirebaseException) return 'Eroare cloud (${error.code}). Încearcă din nou.';
  return 'Ceva nu a mers (${error.runtimeType}). Încearcă din nou.';
}

class AuthGate extends StatelessWidget {
  const AuthGate({required this.database, super.key});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const _Loading();
        final user = snapshot.data;
        if (user == null) return const LoginScreen();
        return FarmGate(key: ValueKey(user.uid), user: user, database: database);
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _createAccount = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final auth = FirebaseAuth.instance;
      if (_createAccount) {
        await auth.createUserWithEmailAndPassword(email: _email.text.trim(), password: _password.text);
      } else {
        await auth.signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text);
      }
    } catch (error) {
      if (mounted) setState(() => _error = _authMessage(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resetPassword() async {
    final email = _email.text.trim();
    if (email.isEmpty) {
      setState(() => _error = 'Scrie mai întâi adresa de email.');
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ți-am trimis un email pentru parolă nouă.')));
    } catch (error) {
      if (mounted) setState(() => _error = _authMessage(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Icon(Icons.grass_rounded, size: 48),
                  const SizedBox(height: 12),
                  Text('Stâna noastră', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(_createAccount ? 'Creează-ți contul' : 'Intră în cont', textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => (value == null || !value.contains('@')) ? 'Scrie o adresă de email validă' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    autofillHints: [_createAccount ? AutofillHints.newPassword : AutofillHints.password],
                    decoration: const InputDecoration(labelText: 'Parolă'),
                    onFieldSubmitted: (_) => _submit(),
                    validator: (value) => (value == null || value.length < 6) ? 'Cel puțin 6 caractere' : null,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _busy ? null : _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: _busy ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(_createAccount ? 'Creează cont' : 'Intră'),
                    ),
                  ),
                  TextButton(
                    onPressed: _busy ? null : () => setState(() {
                      _createAccount = !_createAccount;
                      _error = null;
                    }),
                    child: Text(_createAccount ? 'Am deja cont' : 'Nu am cont, vreau să-mi fac unul'),
                  ),
                  if (!_createAccount) TextButton(onPressed: _busy ? null : _resetPassword, child: const Text('Am uitat parola')),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FarmGate extends StatefulWidget {
  const FarmGate({required this.user, required this.database, super.key});

  final User user;
  final AppDatabase database;

  @override
  State<FarmGate> createState() => _FarmGateState();
}

class _FarmGateState extends State<FarmGate> {
  final _farms = FarmService();
  late Future<String?> _farmId = _farms.currentFarmId(widget.database, widget.user.uid);

  void _reload() => setState(() => _farmId = _farms.currentFarmId(widget.database, widget.user.uid));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _farmId,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const _Loading();
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Nu am putut verifica gospodăria. Verifică internetul.', textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FilledButton(onPressed: _reload, child: const Text('Încearcă din nou')),
                  TextButton(onPressed: () => FirebaseAuth.instance.signOut(), child: const Text('Ieși din cont')),
                ]),
              ),
            ),
          );
        }
        final farmId = snapshot.data;
        if (farmId == null) {
          return FarmSetupScreen(user: widget.user, database: widget.database, farms: _farms, onLinked: _reload);
        }
        return SyncedHome(key: ValueKey(farmId), database: widget.database, farmId: farmId, farms: _farms);
      },
    );
  }
}

class FarmSetupScreen extends StatefulWidget {
  const FarmSetupScreen({required this.user, required this.database, required this.farms, required this.onLinked, super.key});

  final User user;
  final AppDatabase database;
  final FarmService farms;
  final VoidCallback onLinked;

  @override
  State<FarmSetupScreen> createState() => _FarmSetupScreenState();
}

class _FarmSetupScreenState extends State<FarmSetupScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      widget.onLinked();
    } catch (error) {
      if (mounted) setState(() => _error = _authMessage(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _create() => _run(() async {
        final farmId = await widget.farms.createFarm(widget.database, widget.user.uid);
        await SyncService(database: widget.database, farmId: farmId).uploadEverything();
      });

  Future<void> _join() => _run(() => widget.farms.joinFarm(widget.database, widget.user.uid, _code.text));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [TextButton(onPressed: () => FirebaseAuth.instance.signOut(), child: const Text('Ieși din cont'))]),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('Gospodăria ta', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 20),
                const Text('Ești prima persoană din familie care folosește aplicația?'),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _busy ? null : _create,
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('Creez gospodăria nouă')),
                ),
                const SizedBox(height: 32),
                const Text('Altcineva a creat deja gospodăria? Cere-i codul de invitație.'),
                const SizedBox(height: 8),
                TextField(
                  controller: _code,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(labelText: 'Cod de invitație'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _busy ? null : _join,
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('Mă alătur gospodăriei')),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
                if (_busy) const Padding(padding: EdgeInsets.only(top: 16), child: Center(child: CircularProgressIndicator())),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SyncedHome extends StatefulWidget {
  const SyncedHome({required this.database, required this.farmId, required this.farms, super.key});

  final AppDatabase database;
  final String farmId;
  final FarmService farms;

  @override
  State<SyncedHome> createState() => _SyncedHomeState();
}

class _SyncedHomeState extends State<SyncedHome> {
  late final SyncService _sync = SyncService(database: widget.database, farmId: widget.farmId)..start();

  @override
  void dispose() {
    _sync.stop();
    super.dispose();
  }

  Future<void> _showInviteCode() async {
    final code = await widget.farms.inviteCode(widget.farmId);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cod de invitație'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Dă acest cod celorlalți din familie. Îl scriu după ce își fac cont.'),
          const SizedBox(height: 16),
          SelectableText(code ?? 'indisponibil', style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: 4, fontWeight: FontWeight.w800)),
        ]),
        actions: [
          if (code != null) TextButton(onPressed: () => Clipboard.setData(ClipboardData(text: code)), child: const Text('Copiază')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Închide')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimalListScreen(
      database: widget.database,
      accountActions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle_outlined),
          onSelected: (value) {
            if (value == 'invite') _showInviteCode();
            if (value == 'signout') FirebaseAuth.instance.signOut();
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'invite', child: Text('Cod de invitație')),
            PopupMenuItem(value: 'signout', child: Text('Ieși din cont')),
          ],
        ),
      ],
    );
  }
}
