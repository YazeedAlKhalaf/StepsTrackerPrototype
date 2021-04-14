import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseService {
  FirebaseApp _firebaseApp;
  FirebaseApp get firebaseApp => _firebaseApp;

  Future<void> init() async {
    _firebaseApp = await Firebase.initializeApp();
  }
}
