import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/account_tab/pages/profile_page/profile_page.dart';
import 'package:iblood/main_tabs/account_tab/pages/profile_page/widgets/profile_section.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/pages/phone_call_page.dart';
import 'package:iblood/widgets/popable_page.dart';

class MemberDetailsPage extends StatefulWidget {
  static const routeName = '/MemberDetailsPage';

  const MemberDetailsPage({Key? key}) : super(key: key);

  @override
  _MemberDetailsPageState createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  var _isRouteArgsInit = false;
  late final MemberDetailsPageArguments _args;
  late String memberId;
  late PrivateCommunityMember member;

  @override
  Widget build(BuildContext context) {
    if (!_isRouteArgsInit) {
      _args = ModalRoute.of(context)!.settings.arguments
          as MemberDetailsPageArguments;
      _isRouteArgsInit = true;
      memberId = _args.memberId;
      member = _args.member;
    }
    

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
                    member.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Card(child: Row(
                  //   children: [
                  //     Text('Membership code:  '),
                  //     SelectableText(memberId),
                  //   ],
                  // ),),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
              Column(
                    children: [
                      ProfileSection(
                        label: 'Personal Info',
                        info: [
                          PieceOfInfo(label: 'Blood group', content: Text(member.bloodGroup)),
                          PieceOfInfo(label: 'Date of birth', content: Text(dateTimeToString(member.birthDate))),
                          PieceOfInfo(label: 'Gender', content: Text(enumToString(member.gender))),
                          PieceOfInfo(label: 'Job', content: Text(member.job)),
                          PieceOfInfo(label: 'Department', content: Text(member.department)),
                          if(member.grade != null && member.grade != "")
                            PieceOfInfo(label: 'Grade', content: Text(member.grade!)),
                          if(member.phoneNumber != null && member.phoneNumber != "")
                            PieceOfInfo(label: 'phoneNumber', content: Text(member.phoneNumber!)),
                          PieceOfInfo(label: 'Donated Before', content: Text(member.isDonatedBefore ? 'Yes':'No')),
                          PieceOfInfo(label: 'Authenticated Blood Group', content: Text(member.isAuthBloodGroup ? 'Yes':'No')),
                          PieceOfInfo(label: 'Donor', content: Text(member.isDonor ? 'Yes':'No')),
                        ],
                      ),
                      ProfileSection(
                        label: 'Address',
                        info: [
                          PieceOfInfo(label: 'Province', content: Text(member.province)),
                          PieceOfInfo(label: 'City', content: Text(member.city)),
                        ],
                      ),
                      ProfileSection(
                        label: 'Others',
                        info: [
                          PieceOfInfo(label: 'Membership code', content: SelectableText(memberId)),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ));
      
  }
}
