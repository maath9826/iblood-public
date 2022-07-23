import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/pages/add_donation_request.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:iblood/models/private_community/private_community.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class PrivateCommunitiesProvider with ChangeNotifier {
  CollectionReference privateCommunitiesCollection =
      FirebaseFirestore.instance.collection('privateCommunities');
  static String? currentPrivateCommunityId;
  static PrivateCommunity? currentPrivateCommunity;
  static String? currentMemberId;
  static PrivateCommunityMember? currentMember;

  Stream<QuerySnapshot> getAll({bool isDescending = true,}) {
    return privateCommunitiesCollection
        .orderBy('creationDate', descending: isDescending)
        .snapshots().handleError((error) {
      throw error;
    },);
  }

  add({
    required DonationRequest donationRequest,
    required BuildContext context,
  }) async {
    privateCommunitiesCollection
        .add(donationRequest.toJson())
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('succeeded'),
              content: const Text('donation request has been added'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ),
          ),
        )
        .then(
          (value) => Navigator.of(context).pop(),
        )
        .catchError(
      (error) {
        const errorMessage =
            'error occurred.';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add donation request failed'),
            content: const Text(errorMessage),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
      },
    );
    notifyListeners();
  }

  update(String privateCommunityId, Map<String, dynamic> data) async => await privateCommunitiesCollection.doc(privateCommunityId).update({
    'statistics': data
  });

  Future<DocumentSnapshot<Object?>> get(String privateCommunityId) async => await privateCommunitiesCollection.doc(privateCommunityId).get();

}
