import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/blood_bank_donors_tab/blood_bank_donors_tab.dart';
import 'package:iblood/main_tabs/blood_banks_tab/blood_banks_tab.dart';
import 'package:iblood/main_tabs/blood_banks_tab/pages/blood_bank_bags_page/blood_bank_page.dart';
import 'package:iblood/main_tabs/private_tab/private_communities_tab.dart';
import 'package:iblood/main_tabs/account_tab/account_tab.dart';
import 'package:iblood/main_tabs/public_tab/public_communities_tab.dart';

class MainTabs extends StatefulWidget {
  static const routeName = '/MainPages';

  const MainTabs({Key? key}) : super(key: key);

  @override
  _MainTabsState createState() {
    return _MainTabsState();
  }
}

class _MainTabsState extends State<MainTabs> {
  final _mainTabs = [
    // {"widget": BloodBanksMainPage(), "title": "Blood Banks"},
    {"widget": BloodBankPage(), "title": ""},
    {"widget": BloodBankDonorsTab(), "title": "Donors"},
    {"widget": PrivateCommunitiesTab(), "title": "Private Communities"},
    {"widget": AccountTab(), "title": "Account"}
    // PublicCommunitiesMainPage(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              centerTitle: true,
              title: Text(_mainTabs[_currentIndex]["title"] as String),

            ),
      body: _mainTabs[_currentIndex]["widget"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Banks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Donors',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.vpn_lock,
            ),
            label: 'Private',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Account',
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
    );
  }
}
