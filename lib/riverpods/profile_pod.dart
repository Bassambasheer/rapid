import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapidd_technologies/network/firestore_service.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? data;
  FirestoreService fStore = FirestoreService();

  getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid ?? '';
    try {
      data = await fStore.getUserDataFromFirestore('user', uid);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}

final profileProvider =
    ChangeNotifierProvider<ProfileProvider>((ref) => ProfileProvider());
