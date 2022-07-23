import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iblood/blood_bank_system/providers/clients_provider.dart';
import 'package:iblood/main_tabs/blood_bank_donors_tab/pages/client_details_page.dart';
import 'package:provider/provider.dart';

import '../../blood_bank_system/models/client/client.dart';
import '../../models/donor/donor.dart';
import '../../models/private_community/private_community_member/private_community_member.dart';
import '../../others/helpers/routes_arguments.dart';
import '../../providers/donors_provider.dart';
import '../../providers/private_communities_provider.dart';
import '../private_tab/pages/private_community_page/tabs/donors_tab/pages/add_donor.dart';
import '../private_tab/pages/private_community_page/tabs/donors_tab/pages/donor_details_page.dart';

class BloodBankDonorsTab extends StatefulWidget {
  const BloodBankDonorsTab();

  @override
  State<BloodBankDonorsTab> createState() => _BloodBankDonorsTabState();
}

class _BloodBankDonorsTabState extends State<BloodBankDonorsTab> {
  var _showMyDonor = false;
  final _clientsProvider = ClientsProvider();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
              StreamBuilder<List<Client>?>(
                stream: _clientsProvider.getAllStream(),
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
                  var clients = snapshot.data!;
                  print('data after progress: $clients');
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      separatorBuilder: (ctx, i) => const Divider(),
                      itemBuilder: (ctx, i) => ListTile(
                        onTap: () => Navigator.of(context).pushNamed(
                          ClientDetailsPage.routeName,
                          arguments:
                          clients[i],
                        ),
                        title: Text(clients[i].name),
                        trailing: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              if(clients[i].bloodGroup != null && clients[i].bloodGroup!.isNotEmpty)
                                Text(
                                  clients[i].bloodGroup!,
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
                        subtitle: Text(clients[i].province),
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                          // backgroundColor: Color(0xFF5f7a85),
                          // foregroundColor: Color(0xffcfd8df),
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.white,
                          radius: 24,
                        ),
                      ),
                      itemCount: clients.length,
                    ),
                  );
              }),
          ],
        ),
      ],
    );
  }
}
