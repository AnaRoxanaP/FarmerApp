import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/app_database.dart';

class FarmLink {
  const FarmLink({required this.farmId, required this.inviteCode});

  final String farmId;
  final String? inviteCode;
}

class FarmService {
  FarmService({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _linkSettingKey = 'cloud_link';
  static const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  /// Întoarce gospodăria legată de cont; folosește copia locală dacă nu există internet.
  Future<String?> currentFarmId(AppDatabase database, String uid) async {
    final cached = await database.readSetting(_linkSettingKey);
    if (cached != null && cached.startsWith('$uid:')) return cached.substring(uid.length + 1);

    final snapshot = await _firestore.collection('users').doc(uid).get();
    final farmId = snapshot.data()?['farmId'] as String?;
    if (farmId != null) await database.writeSetting(_linkSettingKey, '$uid:$farmId');
    return farmId;
  }

  Future<String?> inviteCode(String farmId) async {
    final snapshot = await _firestore.collection('farms').doc(farmId).get();
    return snapshot.data()?['inviteCode'] as String?;
  }

  /// Leagă baza locală de gospodăria din cloud, pentru dispozitivele pe care contul s-a conectat după creare.
  Future<void> attachLocalFarm(AppDatabase database, String farmId) async {
    final snapshot = await _firestore.collection('farms').doc(farmId).get();
    await database.adoptFarm(farmId: farmId, name: (snapshot.data()?['name'] as String?) ?? 'Gospodăria noastră');
  }

  /// Gospodăria locală existentă devine gospodăria din cloud; datele se încarcă separat de SyncService.
  Future<String> createFarm(AppDatabase database, String uid) async {
    final farmId = await database.ensureLocalFarm();
    final farm = await (database.select(database.farms)..where((row) => row.id.equals(farmId))).getSingle();
    final code = await _freeCode();

    await _firestore.collection('farms').doc(farmId).set({
      'name': farm.name,
      'ownerId': uid,
      'inviteCode': code,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _firestore.collection('farms').doc(farmId).collection('members').doc(uid).set({'role': 'owner'});
    await _firestore.collection('invites').doc(code).set({'farmId': farmId});
    await _firestore.collection('users').doc(uid).set({'farmId': farmId});
    await database.writeSetting(_linkSettingKey, '$uid:$farmId');
    return farmId;
  }

  Future<String> joinFarm(AppDatabase database, String uid, String rawCode) async {
    final code = rawCode.trim().toUpperCase();
    final invite = await _firestore.collection('invites').doc(code).get();
    final farmId = invite.data()?['farmId'] as String?;
    if (farmId == null) throw const FarmException('Codul nu există. Verifică-l și încearcă din nou.');

    await _firestore.collection('farms').doc(farmId).collection('members').doc(uid).set({'role': 'member', 'inviteCode': code});
    final farm = await _firestore.collection('farms').doc(farmId).get();
    await _firestore.collection('users').doc(uid).set({'farmId': farmId});
    await database.adoptFarm(farmId: farmId, name: (farm.data()?['name'] as String?) ?? 'Gospodăria noastră');
    await database.writeSetting(_linkSettingKey, '$uid:$farmId');
    return farmId;
  }

  Future<String> _freeCode() async {
    final random = Random.secure();
    while (true) {
      final code = String.fromCharCodes(List.generate(6, (_) => _codeAlphabet.codeUnitAt(random.nextInt(_codeAlphabet.length))));
      final existing = await _firestore.collection('invites').doc(code).get();
      if (!existing.exists) return code;
    }
  }
}

class FarmException implements Exception {
  const FarmException(this.message);

  final String message;

  @override
  String toString() => message;
}
