import 'package:firebase_auth/firebase_auth.dart';
import 'package:rapidd_technologies/network/abstract/base_firebase_service.dart';

class FirebaseAuthClass extends BaseFirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  bool isUserLoggedIn() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserCredential> loginUser(String email, String password) {
    final userCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  void signOutUser() {
    auth.signOut();
  }

  @override
  Future<UserCredential> signUpUser(
      String name, String email, String password) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
