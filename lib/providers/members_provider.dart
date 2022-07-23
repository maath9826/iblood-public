import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:iblood/data.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/pages/add_donation_request.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/models/private_community/private_community_statistics/private_community_statistics.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/donors_provider.dart';
import 'package:iblood/providers/junctions/user_private_community_junctions_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class MembersProvider with ChangeNotifier {
  late final CollectionReference _membersCollection;
  final String privateCommunityId;

  MembersProvider(this.privateCommunityId) {
    _membersCollection = FirebaseFirestore.instance
        .collection('privateCommunities')
        .doc(privateCommunityId)
        .collection('members');
  }

  Future<DocumentSnapshot<Object?>> get(String memberId) async {
    var memberSnapshot = await _membersCollection.doc(memberId).get();
    return memberSnapshot;
  }

  Future<DocumentReference<Object?>> add(PrivateCommunityMember member) async {
    var memberSnapshot = await _membersCollection.add(member.toJson());

    await updateStatisticsForAddMember(member);

    if (member.isDonor) {
      await DonorsProvider(
              PrivateCommunitiesProvider.currentPrivateCommunityId!)
          .add(
        donor: Donor(
          gender: member.gender,
          bloodGroup: member.bloodGroup,
          city: member.city,
          memberId: memberSnapshot.id,
          province: member.province,
          phoneNumber: member.phoneNumber,
        ),
      );
    }

    return memberSnapshot;
  }

  delete(
    PrivateCommunityMember member,
    String memberId,
  ) async {
    var memberSnapshot = await _membersCollection.doc(memberId).delete();

    await updateStatisticsForDeleteMember(member, memberId);

    await UserPrivateCommunityJunctionsProvider().delete(memberId: memberId);
    if (member.isDonor) {
      var donorsProvider = DonorsProvider(
        PrivateCommunitiesProvider.currentPrivateCommunityId!,
      );
      late final QueryDocumentSnapshot doc;
      late final Donor donor;
      await donorsProvider
          .filterByMemberId(memberId: memberId)
          .then((value) => doc = value.docs[0]);
      donor = Donor.fromJson(doc.data() as Map<String, dynamic>);
      await donorsProvider.deleteAndUpdateStatistics(
        donorId: doc.id,
        donor: donor,
      );
    }

    return memberSnapshot;
  }

  update(String memberId, Map<String, dynamic> data) async {
    await _membersCollection.doc(memberId).update(data);
  }

  // Stream<List<PrivateCommunityMember>>
  Stream<QuerySnapshot<Object?>> getListStream() =>
      _membersCollection.orderBy('creationDate', descending: true).snapshots();
// _membersCollection.orderBy('creationDate',descending: true).snapshots().map((snapshot) => snapshot.docs
//         .map(
//           (doc) => PrivateCommunityMember.fromJson(
//               doc.data() as Map<String, dynamic>),
//         )
//         .toList());
}
