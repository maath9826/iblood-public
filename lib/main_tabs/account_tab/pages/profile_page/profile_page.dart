import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:iblood/blood_bank_system/models/client/client.dart';
import 'package:iblood/blood_bank_system/providers/clients_provider.dart';
import 'package:iblood/main_tabs/account_tab/pages/archive_page/widgets/archive_section.dart';
import 'package:iblood/main_tabs/account_tab/pages/archive_page/widgets/archive_section_item.dart';
import 'package:iblood/main_tabs/account_tab/pages/profile_page/widgets/profile_section.dart';
import 'package:iblood/others/helpers/enums.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/auth_provider.dart';
import 'package:iblood/widgets/popable_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/ProfilePage';




  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PoppablePage(
        label: 'Profile',
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            children: [
              const SizedBox(width: double.infinity,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Image.asset(
                      'assets/images/man_avatar.png',
                      height: 100,
                    ),
                  ),
                  Text(
                    AuthProvider.userData!.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AuthProvider.userData!.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              AuthProvider.userData!.clientId == "" || AuthProvider.userData!.clientId == null  ?
              const Padding(
                    padding:  EdgeInsets.all(16.0),
                    child:  ArchiveSectionItem(
                      icon: Icon(Icons.error,color: Colors.red,),
                      tileColor: Colors.white,
                      subtitle: 'You need to activated your account to show your information',
                      label: 'Activation needed',
                    ),
                  )
                  :
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future:
                      ClientsProvider().get(AuthProvider.userData!.clientId!),
                  builder: (ctx, snapshot) {
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }
                    var client = Client.fromJson(snapshot.data!.data()!);
                    return Column(
                      children: [
                        ProfileSection(
                          label: 'Personal Info',
                          info: [
                            PieceOfInfo(label: 'Blood group', content: Text(client.bloodGroup == null ? "" : client.bloodGroup!)),
                            PieceOfInfo(label: 'Date of birth', content: Text(dateTimeToString(client.birthDate))),
                            PieceOfInfo(label: 'Gender', content: Text(enumToString(client.gender))),
                          ],
                        ),
                        ProfileSection(
                          label: 'Address',
                          info: [
                            PieceOfInfo(label: 'Province', content: Text(client.province)),
                            PieceOfInfo(label: 'City', content: Text(client.city)),
                          ],
                        ),
                        ProfileSection(
                          label: 'Blood Bank Info',
                          info: [
                            PieceOfInfo(label: 'Status', content: Text(enumToString(client.status),style: TextStyle(color: client.status == ClientStatus.banned ? Colors.redAccent : null),)),
                            if(client.status == ClientStatus.banned) PieceOfInfo(label: 'Unban date', content: Text( isAssigned(client.unbanDate) ? dateTimeToString(client.unbanDate!): 'permanent' ,style: TextStyle(color:  Colors.redAccent ),)),
                            PieceOfInfo(label: 'Balance', content: Text(client.balance.toString())),
                          ],
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ));
  }
}

class PieceOfInfo {
  final String label;
  final Widget content;
  final IconData? icon;

  const PieceOfInfo({required this.label, required this.content, this.icon});
}
