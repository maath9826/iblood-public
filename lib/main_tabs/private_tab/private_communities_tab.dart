import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/providers/private_communities_provider.dart';
import '/models/private_community/private_community.dart';
import 'widgets/private_community_widget.dart';

class PrivateCommunitiesTab extends StatefulWidget {
  const PrivateCommunitiesTab({Key? key}) : super(key: key);

  @override
  _PrivateCommunitiesTabState createState() => _PrivateCommunitiesTabState();
}

class _PrivateCommunitiesTabState extends State<PrivateCommunitiesTab> {
  final _privateCommunitiesProvider = PrivateCommunitiesProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: _privateCommunitiesProvider
                .getAll()
                .handleError((onError) => print(onError)),
            builder: (context, snapshot) {
              /// if there is a data
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var privateCommunitiesSnapshot = snapshot.data!.docs;
                var privateCommunities = privateCommunitiesSnapshot
                    .map(
                      (privateCommunitySnapshot) => PrivateCommunity.fromJson(
                        privateCommunitySnapshot.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        bottom: 24.0, left: 24, right: 24,),
                    separatorBuilder: (ctx, i) => const SizedBox(
                      height: 14,
                    ),
                    itemBuilder: (ctx, i) => PrivateCommunityWidget(privateCommunity: privateCommunities[i], privateCommunityId: privateCommunitiesSnapshot[i].id,),
                    itemCount: privateCommunitiesSnapshot.length,
                  ),
                );
              }
              /// if there is no data
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ],
    );
  }

}
