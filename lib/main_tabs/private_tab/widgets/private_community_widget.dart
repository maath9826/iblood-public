import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iblood/dialogs/field_dialog.dart';
import 'package:iblood/main_tabs/private_tab/helpers/functions.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/private_community_page.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/members_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/widgets/custom_field.dart';

import '/providers/junctions/user_private_community_junctions_provider.dart';
import '/models/private_community/private_community.dart';

class PrivateCommunityWidget extends StatefulWidget {
  final PrivateCommunity privateCommunity;
  final String privateCommunityId;

  const PrivateCommunityWidget(
      {required this.privateCommunity,
      required this.privateCommunityId,
      Key? key})
      : super(key: key);

  @override
  _PrivateCommunityWidgetState createState() => _PrivateCommunityWidgetState();
}

class _PrivateCommunityWidgetState extends State<PrivateCommunityWidget> {
  final _userPrivateCommunityJunctionsProvider =
      UserPrivateCommunityJunctionsProvider();

  final _userId = FirebaseAuth.instance.currentUser!.uid;

  var _isLoading = false;

  final membershipCodeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    membershipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Stack(
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          ListTile(
            title: Text(widget.privateCommunity.name),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () async {
              changeLoadingState(true);
              UserPrivateCommunityJunctionsProvider.currentJunctionSnapshot =
                  await _userPrivateCommunityJunctionsProvider
                      .getJunction(
                privateCommunityId: widget.privateCommunityId,
              )
                      .catchError((e) {
                print(e);
              });
              if (UserPrivateCommunityJunctionsProvider.currentJunctionSnapshot!.exists) {
                print('existince');
                if (mounted) {
                  var memberSnapshot =
                      await MembersProvider(widget.privateCommunityId)
                          .get(UserPrivateCommunityJunctionsProvider.currentJunctionSnapshot!.get('memberId'));
                  PrivateCommunitiesProvider.currentMemberId =
                      memberSnapshot.id;
                  PrivateCommunitiesProvider.currentMember =
                      PrivateCommunityMember.fromJson(
                          memberSnapshot.data() as Map<String, dynamic>);

                  PrivateCommunitiesProvider.currentPrivateCommunityId =
                      widget.privateCommunityId;
                  PrivateCommunitiesProvider.currentPrivateCommunity =
                      widget.privateCommunity;

                  changeLoadingState(false);

                  Navigator.of(context).pushNamed(
                    PrivateCommunityPage.routeName,
                    arguments: PrivateCommunityPageArguments(
                      privateCommunity: widget.privateCommunity,
                      id: widget.privateCommunityId,
                    ),
                  );
                }
              } else {
                print('No existince');
                changeLoadingState(false);
                if (mounted) {
                  FieldDialog(
                          fieldController: membershipCodeController,
                          dialogTitle: 'Enter your Membership Code',
                          fieldLabel: 'membership code',
                          onSubmit: _onSubmit)
                      .show(context: context);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _onSubmit({
    required FieldDialog fieldDialog,
    required BuildContext dialogContext,
    required void Function(void Function()) dialogSetState,
  }) async {
    fieldDialog.errorMessage = null;
    if (!fieldDialog.formKey.currentState!.validate()) return;
    try {
      dialogSetState(() {
        fieldDialog.isLoading = true;
      });
      MembersProvider membersProvider =
          MembersProvider(widget.privateCommunityId);
      final memberSnapshot =
          await membersProvider.get(fieldDialog.fieldController.text);
      print('before');
      if (memberSnapshot.exists && (memberSnapshot.get('userId') == null || memberSnapshot.get('userId') == "")) {
        print('it is null');
        print('memberSnapshot.id: ${memberSnapshot.id}');
        print('widget.privateCommunityId: ${widget.privateCommunityId}');
        print('before setting junctions...d..d..d..d..d.d.d.');
        UserPrivateCommunityJunctionsProvider.currentJunctionSnapshot = await _userPrivateCommunityJunctionsProvider.set(
          memberId: memberSnapshot.id,
          privateCommunityId: widget.privateCommunityId,
        );
        print('after setting junctions...d..d..d..d..d.d.d.');
        await FirebaseMessaging.instance
            .subscribeToTopic(widget.privateCommunity.name.split(' ').join());
        await membersProvider.update(
          memberSnapshot.id,
          {"userId": _userId},
        );
        print('before mount');
        if (mounted) {
          print('mounted');
          Navigator.pop(dialogContext);
          PrivateCommunitiesProvider.currentPrivateCommunityId =
              widget.privateCommunityId;
          PrivateCommunitiesProvider.currentPrivateCommunity =
              widget.privateCommunity;
          PrivateCommunitiesProvider.currentMemberId = memberSnapshot.id;
          PrivateCommunitiesProvider.currentMember =
              PrivateCommunityMember.fromJson(
                  memberSnapshot.data() as Map<String, dynamic>);
          Navigator.of(context).pushNamed(
            PrivateCommunityPage.routeName,
            arguments: PrivateCommunityPageArguments(
              privateCommunity: widget.privateCommunity,
              id: widget.privateCommunityId,
            ),
          );
        }
      } else {
        if (fieldDialog.isOpened) {
          dialogSetState(() {
            if (!memberSnapshot.exists) {
              fieldDialog.errorMessage = 'Wrong Code!';
            } else {
              fieldDialog.errorMessage = 'This code is already used';
            }
          });
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
    }

    /// making sure that the dialog exist before changing it's state
    if (fieldDialog.isOpened) {
      dialogSetState(() {
        fieldDialog.isLoading = false;
      });
    }
  }

  changeLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
