import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/widgets/phone_call_button.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/pages/phone_call_page.dart';
import 'package:iblood/widgets/popable_page.dart';

class DonorDetailsPage extends StatefulWidget {
  static const routeName = '/DonorDetailsPage';

  const DonorDetailsPage({Key? key}) : super(key: key);

  @override
  _DonorDetailsPageState createState() => _DonorDetailsPageState();
}

class _DonorDetailsPageState extends State<DonorDetailsPage> {
  var _isRouteArgsInit = false;
  late final DonorDetailsPageArguments _args;

  @override
  Widget build(BuildContext context) {
    if (!_isRouteArgsInit) {
      _initRouteArgs();
      _isRouteArgsInit = true;
    }

    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(
        title: const Text('Donor'),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // IconButton(
          //   onPressed: () => null,
          //   // Navigator.pushNamed(context, PhoneCallPage.routeName),
          //   icon: Icon(Icons.phone),
          // ),
          // IconButton(
          //   onPressed: () => null,
          //   icon: Icon(Icons.chat),
          // )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: double.maxFinite,
                  child: ListView.separated(
                      itemBuilder: (ctx, i) =>
                          ListTile(
                            title: Text(_args.donor.details[i].key),
                            trailing: Text(_args.donor.details[i].value),
                          ),
                      separatorBuilder: (ctx, int) =>
                          Divider(color: Colors.black38,),
                      itemCount: _args.donor.details.length),
                ),
              ],
            ),),
          if(_args.donor.phoneNumber != null && _args.donor.phoneNumber!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                child: PhoneCallButton(
                  phoneNumber: _args.donor.phoneNumber!,
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
        ],
      ),
    );
  }

  _initRouteArgs() {
    _args = ModalRoute
        .of(context)!
        .settings
        .arguments
    as DonorDetailsPageArguments;
  }
}


