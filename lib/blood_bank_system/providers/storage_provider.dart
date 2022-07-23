import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iblood/blood_bank_system/models/blood_warehouse/blood_warehouse.dart';
import 'package:iblood/blood_bank_system/models/client/client.dart';

class StorageProvider{

  Stream<BloodWarehouse> getBlood() => FirebaseFirestore.instanceFor(app: Firebase.app('BBMS'))
        .collection('storage')
        .doc('blood').snapshots().map((snapshot) => BloodWarehouse.fromJson(snapshot.data()!));

  Stream<Client?> getStream(String clientId) => FirebaseFirestore.instanceFor(app: Firebase.app('BBMS'))
      .collection('clients')
      .doc(clientId)
      .snapshots().map((snapshot) => snapshot.data() == null ? null : Client.fromJson(snapshot.data()!));
}











