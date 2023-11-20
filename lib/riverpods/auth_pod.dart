import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapidd_technologies/Utils/utils.dart';
import 'package:rapidd_technologies/network/firebase_auth.dart';
import 'package:rapidd_technologies/network/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  UserCredential? _userCredential;
  final Map<String, dynamic> _userData = {};
  FirebaseAuthClass fAuth = FirebaseAuthClass();
  FirestoreService fStore = FirestoreService();
  bool _isLoading = false;
  bool _isObscure = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
    }
  }

  bool get isObscure => _isObscure;

  set isObscure(bool value) {
    if (_isObscure != value) {
      _isObscure = value;
    }
    notifyListeners();
  }

  UserCredential? get userCredential => _userCredential;
  Map<String, dynamic> get userData => _userData;

  Future<UserCredential> loginUser(String email, String password) async {
    setLoader(true);
    try {
      _userCredential = await fAuth.loginUser(email, password);
      setLoader(false);
      return _userCredential!;
    } catch (e) {
      log(e.toString());
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<UserCredential> signUpUser(
      String name, String email, String password) async {
    var isSuccess = false;
    setLoader(true);
    _userCredential = await fAuth.signUpUser(
      name,
      email,
      password,
    );
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'uid': _userCredential!.user!.uid,
      'createdAt': DateTime.now().microsecondsSinceEpoch.toString(),
      'bio': '',
      'profile_pic': '',
      'batches': []
    };
    String uid = _userCredential!.user!.uid;
    Utils.saveStringValue('uid', uid);
    isSuccess = await addUserData(data, 'user', uid);
    if (isSuccess) {
      return _userCredential!;
    } else {
      throw Exception('Signup Failed');
    }
  }

  userSignOut() {
    fAuth.signOutUser();
    Utils.saveBooleanValue('isLoggedIn', false);
  }

  Future<bool> addUserData(
      Map<String, dynamic> data, String collectionName, String docName) async {
    var value = false;
    try {
      await fStore.addDataToFirestore(data, collectionName, docName);
      value = true;
    } catch (e) {
      log(e.toString());
      value = false;
    }
    return value;
  }

  setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
