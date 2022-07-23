import 'package:flutter/material.dart';
import 'package:iblood/data.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/donation_requests_tab.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/members_tab/members_tab.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/junctions/user_private_community_junctions_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/widgets/popable_page.dart';
import 'package:provider/provider.dart';

import '/main_tabs/blood_banks_tab/data.dart';
import '/others/helpers/routes_arguments.dart';
import '/main_tabs/private_tab/data.dart';
import 'tabs/donors_tab/donors_tab.dart';
import 'tabs/statistics/statistics.dart';

class PrivateCommunityPage extends StatefulWidget {
  static const routeName = '/PrivateCommunityPage';

  const PrivateCommunityPage({Key? key}) : super(key: key);

  @override
  _PrivateCommunityPageState createState() => _PrivateCommunityPageState();
}

class _PrivateCommunityPageState extends State<PrivateCommunityPage> {
  var _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments
        as PrivateCommunityPageArguments;
    var tabs = [
      DonorsTab(_args.id),
      DonationRequestsTab(privateCommunityId: _args.id,),
      const Statistics(),
      MembersTab(),
    ];
    return ChangeNotifierProvider(
      create: (ctx) => PrivateCommunitiesProvider.currentMember,
      child: Scaffold(
        // backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(_args.privateCommunity.name),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.vpn_lock,
            //   ),
            //   label: 'Private',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_pin,
              ),
              label: 'Donors',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.view_list,
              ),
              label: 'Requests',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
              ),
              label: 'Statistics',
            ),
            if(UserPrivateCommunityJunctionsProvider.currentJunction.roles.isEditor) const BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: 'Members',
            ),
          ],
          selectedItemColor: Colors.black87,
          selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          unselectedItemColor: Colors.black38,
          selectedFontSize: 12,
          elevation: 10,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          iconSize: 28,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
