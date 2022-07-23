import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/pages/add_donation_request.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class DonationRequestProvider with ChangeNotifier {
  late final CollectionReference donationRequestsCollection;
  final String privateCommunityId;
  DonationRequestProvider(this.privateCommunityId){
    donationRequestsCollection = FirebaseFirestore.instance.collection('privateCommunities').doc(privateCommunityId).collection('donationRequests');
  }

  Stream<QuerySnapshot> getAll({required String fieldName,required BuildContext context, bool isDescending = false}) {
    return donationRequestsCollection
        .orderBy(fieldName, descending: isDescending)
        .snapshots().handleError(      (error) {
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
    },);
  }

  add({
    required DonationRequest donationRequest,
    required BuildContext context,
  }) async {
    await donationRequestsCollection
        .add(donationRequest.toJson());
    notifyListeners();
  }
}
