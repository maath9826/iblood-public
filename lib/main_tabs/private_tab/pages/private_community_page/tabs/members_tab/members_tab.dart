import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/pages/member_details_page/member_details_page.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/models/user/user.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/members_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/providers/users_provider.dart';

import '../../../../../../data.dart';
import 'pages/add_member.dart';

class MembersTab extends StatelessWidget {
  final _membersProvider = MembersProvider(
    PrivateCommunitiesProvider.currentPrivateCommunityId!,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      StreamBuilder<QuerySnapshot>(
          stream: _membersProvider.getListStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var members = snapshot.data!.docs
                .map(
                  (doc) => PrivateCommunityMember.fromJson(
                      doc.data() as Map<String, dynamic>),
                )
                .toList();
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (ctx, i) => const Divider(),
              itemBuilder: (ctx, i) => ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  MemberDetailsPage.routeName,
                  arguments: MemberDetailsPageArguments(
                    member: members[i],
                    memberId: snapshot.data!.docs[i].id,
                  ),
                ),
                title: Text(members[i].name),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Text(
                        members[i].bloodGroup,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Expanded(
                        child: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (ctx) => [
                            PopupMenuItem(
                              child: const Text('delete'),
                              onTap: () async {
                                await _membersProvider.delete(
                                  members[i],
                                  snapshot.data!.docs[i].id,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                subtitle: Text(members[i].province),
                leading: CircleAvatar(
                  child: members[i].gender == Gender.male
                      ? const Icon(Icons.male)
                      : const Icon(Icons.female),
                  // backgroundColor: Color(0xFF5f7a85),
                  // foregroundColor: Color(0xffcfd8df),
                  backgroundColor: members[i].gender == Gender.male
                      ? Colors.blueAccent
                      : Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  radius: 24,
                ),
              ),
              itemCount: members.length,
            );
          }),
      Align(
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(
            AddMember.routeName,
          ),
          child: const Icon(Icons.add),
        ),
        alignment: Alignment.bottomCenter,
      ),
    ]);
  }
}
