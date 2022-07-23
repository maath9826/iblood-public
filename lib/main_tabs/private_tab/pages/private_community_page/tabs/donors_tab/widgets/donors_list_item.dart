import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/widgets/phone_call_button.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/pages/donor_details_page.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';

class DonorsListItem extends StatelessWidget {
  final Donor donor;
  const DonorsListItem({required this.donor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.of(context).pushNamed(
            DonorDetailsPage.routeName,
            arguments: DonorDetailsPageArguments(donor: donor),
          )
      ,
      title: Text(donor.bloodGroup),
      trailing: const Icon(Icons.keyboard_arrow_right),
      // SizedBox(
      //   width: 60,
      //   child: Row(
      //     children: [
      //       Text(
      //         donor.bloodGroup,
      //         style: const TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.green),
      //       ),
      //       const Icon(Icons.keyboard_arrow_right),
      //     ],
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   ),
      // ),
      subtitle: Text(donor.province),
      leading: const CircleAvatar(
        child: Icon(Icons.person),
        // backgroundColor: Color(0xFF5f7a85),
        // foregroundColor: Color(0xffcfd8df),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        radius: 24,

      ),

    );
  }
}

