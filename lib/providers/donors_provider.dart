import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/pages/add_donation_request.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/members_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class DonorsProvider with ChangeNotifier {
  late final CollectionReference donorsCollection;
  final String privateCommunityId;

  DonorsProvider(this.privateCommunityId) {
    donorsCollection = FirebaseFirestore.instance
        .collection('privateCommunities')
        .doc(privateCommunityId)
        .collection('donors');
  }

  Stream<List<Donor?>> getAll({
    String fieldName = 'creationDate',
    bool isDescending = true,
  }) =>
      donorsCollection
          .orderBy(fieldName, descending: isDescending)
          .snapshots()
          .where((snapshot) {
        for (var i = 0; i < snapshot.docs.length; i++) {
          var doc = snapshot.docs[i];
          if (doc.get('creationDate') == null) {
            return false;
          }
        }
        return true;
      }).map((snapshot) {
        return snapshot.docs
            .map((doc) => Donor.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });

  add({
    required Donor donor,
  }) async {
    Map<String, dynamic> data = donor.toJson();
    data['creationDate'] = FieldValue.serverTimestamp();
    data['name'] = 'Donor ${faker.randomGenerator.integer(1000000, min: 1)}';

    await donorsCollection.add(data);
    await MembersProvider(privateCommunityId).update(
      donor.memberId,
      {
        'isDonor': true,
      },
    );
    PrivateCommunitiesProvider.currentMember!.changeIsDonor(true);
    await updateStatisticsForAddDonor(donor);
  }

  deleteAndUpdateAll({
    required String donorId,
    required Donor donor,
  }) async {
    await donorsCollection.doc(donorId).delete();
    await MembersProvider(privateCommunityId).update(
      donor.memberId,
      {
        'isDonor': false,
      },
    );
    PrivateCommunitiesProvider.currentMember!.changeIsDonor(false);
    await updateStatisticsForDeleteDonor(donor);
  }

  deleteAndUpdateStatistics({
    required String donorId,
    required Donor donor,
  }) async {
    await donorsCollection.doc(donorId).delete();
    await updateStatisticsForDeleteDonor(donor);
  }

  Future<QuerySnapshot<Object?>> filterByMemberId({
    required String memberId,
  }) async =>
      donorsCollection.where('memberId', isEqualTo: memberId).get();
}
