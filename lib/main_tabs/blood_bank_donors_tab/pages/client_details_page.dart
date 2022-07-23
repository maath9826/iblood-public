import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/widgets/phone_call_button.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/pages/phone_call_page.dart';
import 'package:iblood/widgets/popable_page.dart';

class ClientDetailsPage extends StatefulWidget {
  static const routeName = '/ClientDetailsPage';

  const ClientDetailsPage({Key? key}) : super(key: key);

  @override
  _ClientDetailsPageState createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  var _isRouteArgsInit = false;
  late final _args;

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
                            title: Text(_args.details[i].key),
                            trailing: Text(_args.details[i].value),
                          ),
                      separatorBuilder: (ctx, int) =>
                          Divider(color: Colors.black38,),
                      itemCount: _args.details.length),
                ),
              ],
            ),),
          if(_args.phoneNumber != null && _args.phoneNumber!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                child: PhoneCallButton(
                  phoneNumber: _args.phoneNumber!,
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
        .arguments;
    print('argssss:$_args');
  }
}


