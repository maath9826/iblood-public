import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorFormsProvider {
  final FirebaseAuth _fbAuthInstance = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String clientId) async =>
      await FirebaseFirestore.instanceFor(app: Firebase.app('BBSystem'))
          .collection('clients')
          .doc(clientId)
          .get()
          .catchError((error) {
        throw error;
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getAll(String clientId) async =>
      await FirebaseFirestore.instanceFor(app: Firebase.app('BBSystem'))
          .collection('donorForms')
          .where('clientId', isEqualTo: clientId)
          .orderBy('creationDate', descending: true)
          .get();
}
