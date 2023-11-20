import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapidd_technologies/network/abstract/base_firestore_sevice.dart';

class FirestoreService extends BaseFirestoreService {
  final _fireStoreInstance = FirebaseFirestore.instance;
  @override
  Future addDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      await _fireStoreInstance
          .collection(collectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      await _fireStoreInstance
          .collection(collectionName)
          .doc(docName)
          .update(data)
          .then((value) => log('Data update'))
          .catchError((error) => log(error.toString()));
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future getUserDataFromFirestore(String collectionName, String docName) async {
    try {
      final userData = await _fireStoreInstance
          .collection(collectionName)
          .doc(docName)
          .get();

      return userData.data();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
