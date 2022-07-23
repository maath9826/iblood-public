import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/private_community_page.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/members_provider.dart';

import '/providers/junctions/user_private_community_junctions_provider.dart';
import '/widgets/custom_field.dart';
import '/models/private_community/private_community.dart';

final _userPrivateCommunityJunctionsProvider =
    UserPrivateCommunityJunctionsProvider();

final _userId = FirebaseAuth.instance.currentUser!.uid;

var _isLoading = false;

final _membershipCodeController = TextEditingController();

final _formKey = GlobalKey<FormState>();

String? _errorMessage;

getMembership({
  required String privateCommunityId,
}) async {
  var junctionSnapshot = await _userPrivateCommunityJunctionsProvider
      .getJunction(
    privateCommunityId: privateCommunityId,
  )
      .catchError((e) {
    print(e);
  });
  return junctionSnapshot;
}



