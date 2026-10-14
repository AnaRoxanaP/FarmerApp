import 'package:firebase_core/firebase_core.dart';

const _placeholder = 'COMPLETEAZA';

/// Valorile se iau din Firebase Console → Setări proiect → Aplicațiile tale → Web (SDK setup and configuration).
/// Sunt publice într-o aplicație web; datele sunt protejate de regulile din firestore.rules.
class DefaultFirebaseOptions {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMe5yLfISjNh3zb2peG_ilkEbePjtF9qo',
    appId: '1:257245309599:web:c0b40a22eccbb8ea3ed0aa',
    messagingSenderId: '257245309599',
    projectId: 'farmerapp-378c8',
    authDomain: 'farmerapp-378c8.firebaseapp.com',
    storageBucket: 'farmerapp-378c8.firebasestorage.app',
    measurementId: 'G-W9K8KZ093X',
  );

  static bool get isConfigured => web.apiKey != _placeholder && web.projectId != _placeholder;
}
