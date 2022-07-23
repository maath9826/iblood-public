import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iblood/blood_bank_system/models/client/client.dart';

class ClientsProvider{
  final _collectionRef = FirebaseFirestore.instanceFor(app: Firebase.app('BBSystem'))
      .collection('clients');

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getClientFromDonorCode({
    required String donorCode,
  }) async {
      return await _collectionRef
          .orderBy('__name__')
          .endAt([donorCode + "\uf8ff"])
          .startAt([donorCode])
          .get().then((snapshot) => snapshot.docs[0]);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String clientId) async {
    print('clientId: $clientId',);
    var client = await _collectionRef
        .doc(clientId)
        .get()
        .catchError((error) {
          print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          print(error);
      throw error;
    });
    print('clientttttttt: $client');
    return client;
  }

  Stream<List<Client>?> getAllStream() =>
    _collectionRef.where('isPublic',isEqualTo: true).snapshots().map((snapshot) {
      print('this is the docs: ${snapshot.docs}');
      return snapshot.size == 0 ? null : snapshot.docs.map((doc) => Client.fromJson(doc.data())).toList();
    });




  Stream<Client?> getStream(String clientId) => _collectionRef
      .doc(clientId)
      .snapshots().map((snapshot) => snapshot.data() == null ? null : Client.fromJson(snapshot.data()!));
}











