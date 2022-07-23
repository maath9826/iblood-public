import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/models/user_private_community_junction/user_private_community_junction.dart';
import '/models/private_community/private_community_roles/private_community_roles.dart';

class UserPrivateCommunityJunctionsProvider with ChangeNotifier {
  final CollectionReference userPrivateCommunityJunctionsCollection =
      FirebaseFirestore.instance.collection('user_privateCommunity_junctions');

  final _userId = FirebaseAuth.instance.currentUser!.uid;
  static DocumentSnapshot? currentJunctionSnapshot;

  static UserPrivateCommunityJunction get currentJunction {
    return UserPrivateCommunityJunction.fromJson(currentJunctionSnapshot!.data() as Map<String,dynamic>);
  }

  // Stream<QuerySnapshot> getAll({
  //   String fieldName = 'creationDate',
  //   bool isDescending = true,
  // }) {
  //   return donorsCollection
  //       .orderBy(fieldName, descending: isDescending)
  //       .snapshots()
  //       .handleError(
  //         (error) {
  //       throw error;
  //     },
  //   );
  // }

  Future<DocumentSnapshot<Object?>> set({
    required String privateCommunityId,
    required String memberId,
  }) async {
    print('_userId:${_userId}');
    print('memberId:${memberId}');
    print('privateCommunityId:${privateCommunityId}');
    await userPrivateCommunityJunctionsCollection
        .doc(_userId + '_' + privateCommunityId)
        .set(UserPrivateCommunityJunction(
          privateCommunityId: privateCommunityId,
          userId: _userId,
          memberId: memberId,
          roles: PrivateCommunityRoles(),
        ).toJson());
    print('before get');
    return await userPrivateCommunityJunctionsCollection.doc(_userId + '_' + privateCommunityId).get();
  }

  delete({
    required String memberId,
  }) async {
    await userPrivateCommunityJunctionsCollection
        .where('memberId', isEqualTo: memberId)
        .get()
        .then((snapshot) async {
          if(snapshot.docs.isNotEmpty){
            await userPrivateCommunityJunctionsCollection
                .doc(snapshot.docs[0].id).delete();
          }
    });
  }



  Future<DocumentSnapshot<Object?>> getJunction({
    required String privateCommunityId,
  }) async {
    return await userPrivateCommunityJunctionsCollection
        .doc(_userId + '_' + privateCommunityId)
        .get();
  }
}
