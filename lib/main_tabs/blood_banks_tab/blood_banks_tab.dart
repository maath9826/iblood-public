import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/blood_banks_tab/pages/blood_bank_bags_page/blood_bank_page.dart';

import '/others/helpers/routes_arguments.dart';
import 'data.dart';

class BloodBanksMainPage extends StatefulWidget {
  const BloodBanksMainPage({Key? key}) : super(key: key);

  @override
  _BloodBanksMainPageState createState() => _BloodBanksMainPageState();
}

class _BloodBanksMainPageState extends State<BloodBanksMainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Padding(
        //   padding:  EdgeInsets.only(top: 24.0,left: 24,right: 24),
        //   child:  TextField(
        //     decoration: InputDecoration(
        //         border: OutlineInputBorder(),
        //         prefixIcon: Icon(
        //           Icons.search,
        //         ),
        //         hintText: 'Search'),
        //   ),
        // ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 24.0,left: 24,right: 24),
            separatorBuilder: (ctx, i) => const SizedBox(
              height: 14,
            ),
            itemBuilder: (ctx, i) => Card(
              margin: const EdgeInsets.all(0),
              child: ListTile(
                title: Text(bloodBanks[i].label),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => Navigator.of(context).pushNamed(
                  BloodBankPage.routeName,
                  arguments: BloodBankBagsPageArguments(
                    id: bloodBanks[i].id,
                    label: bloodBanks[i].label,
                  ),
                ),
              ),
            ),
            itemCount: bloodBanks.length,
          ),
        ),
      ],
    );
  }
}
