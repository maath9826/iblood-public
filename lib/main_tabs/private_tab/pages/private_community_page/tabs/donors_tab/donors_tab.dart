import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/pages/add_donor.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/pages/donor_details_page.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/widgets/donors_list_item.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/models/user_private_community_junction/user_private_community_junction.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/donors_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:provider/provider.dart';

class DonorsTab extends StatefulWidget {
  final String privateCommunityId;

  const DonorsTab(this.privateCommunityId);

  @override
  State<DonorsTab> createState() => _DonorsTabState();
}

class _DonorsTabState extends State<DonorsTab> {
  var _showMyDonor = false;
  final _donorsProvider = DonorsProvider(
    PrivateCommunitiesProvider.currentPrivateCommunityId!,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CheckboxListTile(
                title: const Text('Show mine only'),
                value: _showMyDonor,
                onChanged: (isShow) => setState(() {
                      _showMyDonor = isShow!;
                    })),
            _showMyDonor
                ? FutureBuilder<QuerySnapshot>(
                    future: _donorsProvider.filterByMemberId(
                        memberId: PrivateCommunitiesProvider.currentMemberId!),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print(snapshot.stackTrace);
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('no data'));
                      }
                      var doc = snapshot.data!.docs[0];
                      var donor =
                          Donor.fromJson(doc.data() as Map<String, dynamic>);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () => Navigator.of(context).pushNamed(
                            DonorDetailsPage.routeName,
                            arguments: DonorDetailsPageArguments(donor: donor),
                          ),
                          title: Text(donor.name!),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                Text(
                                  donor.bloodGroup,
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
                                          await _donorsProvider
                                              .deleteAndUpdateAll(
                                            donorId: doc.id,
                                            donor: donor,
                                          );
                                          setState(() {
                                            _showMyDonor = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // const Icon(Icons.more_vert),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          subtitle: Text(donor.province),
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                            // backgroundColor: Color(0xFF5f7a85),
                            // foregroundColor: Color(0xffcfd8df),
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            radius: 24,
                          ),
                        ),
                      );
                    })
                : StreamBuilder<List<Donor?>>(
                    stream: _donorsProvider.getAll(),
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
                      var donors = snapshot.data!;
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8.0),
                          separatorBuilder: (ctx, i) => const Divider(),
                          itemBuilder: (ctx, i) => ListTile(
                            onTap: () => Navigator.of(context).pushNamed(
                              DonorDetailsPage.routeName,
                              arguments:
                                  DonorDetailsPageArguments(donor: donors[i]!),
                            ),
                            title: Text(donors[i]!.name!),
                            trailing: SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  Text(
                                    donors[i]!.bloodGroup,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  const Icon(Icons.keyboard_arrow_right),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            subtitle: Text(donors[i]!.province),
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                              // backgroundColor: Color(0xFF5f7a85),
                              // foregroundColor: Color(0xffcfd8df),
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              radius: 24,
                            ),
                          ),
                          itemCount: donors.length,
                        ),
                      );
                    }),
          ],
        ),
        Consumer<PrivateCommunityMember>(builder: (ctx, currentMember, _){
          if (!PrivateCommunitiesProvider.currentMember!.isDonor) {
            return Align(
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    AddDonor.routeName,
                    arguments: AddDonorArguments(
                        privateCommunityId: widget.privateCommunityId)),
                child: const Icon(Icons.add),
              ),
              alignment: Alignment.bottomCenter,
            );
          }
          return const SizedBox(height: 0, width: 0,);
        })

      ],
    );
  }
}
