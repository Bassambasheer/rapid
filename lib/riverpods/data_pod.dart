import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapidd_technologies/Utils/model/data_model.dart';

class DataProvider extends ChangeNotifier {
  Future<String> createData(Data note) async {
    String email = FirebaseAuth.instance.currentUser!.email ?? '';
    final doc = FirebaseFirestore.instance.collection(email).doc();
    note.id = doc.id;
    await doc.set(note.toJson());
    return doc.id;
  }

  Stream<List<Data>> getData() {
    String email = FirebaseAuth.instance.currentUser!.email ?? '';
    return FirebaseFirestore.instance.collection(email).snapshots().map(
        (event) =>
            event.docs.map((json) => Data.fromJson(json.data())).toList());
  }

  Future updateData(Data data) async {
    String email = FirebaseAuth.instance.currentUser!.email ?? '';
    final doc = FirebaseFirestore.instance.collection(email).doc(data.id);
    await doc.update(data.toJson());
  }

  Future deleteData(String id) async {
    String email = FirebaseAuth.instance.currentUser!.email ?? '';
    final doc = FirebaseFirestore.instance.collection(email).doc(id);
    await doc.delete();
  }
}

final dataProvider =
    ChangeNotifierProvider<DataProvider>((ref) => DataProvider());
