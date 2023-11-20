import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseService {
  Future<UserCredential> loginUser(String email, String password);
  Future<UserCredential> signUpUser(String name, String email, String password);
  void signOutUser();
  bool isUserLoggedIn();
}
