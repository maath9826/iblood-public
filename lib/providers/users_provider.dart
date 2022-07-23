import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/user.dart';

class UsersProvider with ChangeNotifier {

  Future<void> set(User user, String userId) async {
    Map<String,dynamic> data = user.toJson();
    data['creationDate'] = FieldValue.serverTimestamp();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(data)
        .catchError((error) {
      throw error;
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> get(
      String userId) async =>
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .catchError((error) {
        throw error;
      });
  Stream<User?> getStream(String userId) => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots().map((snapshot) => snapshot.data() == null ? null : User.fromJson(snapshot.data()!));

  Future<void> update(
      String userId,
      Map<String,dynamic> data,
      ) async =>
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(data)
          .catchError((error) {
        throw error;
      });

}








