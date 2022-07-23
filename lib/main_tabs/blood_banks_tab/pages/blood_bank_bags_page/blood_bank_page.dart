import 'package:flutter/material.dart';
import 'package:iblood/blood_bank_system/models/blood_warehouse/blood_warehouse.dart';
import 'package:iblood/blood_bank_system/providers/storage_provider.dart';
import 'package:iblood/main_tabs/blood_banks_tab/data.dart';

import '/others/helpers/routes_arguments.dart';

class BloodBankPage extends StatefulWidget {
  static const routeName = '/blood_bank_bags_page';

  const BloodBankPage({Key? key}) : super(key: key);

  @override
  _BloodBankPageState createState() => _BloodBankPageState();
}

class _BloodBankPageState extends State<BloodBankPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _args = ModalRoute.of(context)!.settings.arguments
    //     as BloodBankBagsPageArguments;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Baghdad Blood Bank',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text('Address - Baghdad / Al-Mansour'),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 1,
          ),
        ),
        body: StreamBuilder<BloodWarehouse>(
            stream: StorageProvider().getBlood(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child:  CircularProgressIndicator());
              }
              var bloodBags = [
                BloodBag(label: 'A+', amount: snapshot.data!.aPos),
                BloodBag(label: 'A-', amount: snapshot.data!.aNeg),
                BloodBag(label: 'B+', amount: snapshot.data!.bPos),
                BloodBag(label: 'B-', amount: snapshot.data!.bNeg),
                BloodBag(label: 'AB+', amount: snapshot.data!.abPos),
                BloodBag(label: 'AB-', amount: snapshot.data!.abNeg),
                BloodBag(label: 'O+', amount: snapshot.data!.oPos),
                BloodBag(label: 'O-', amount: snapshot.data!.oNeg),
              ];
              return ListView.separated(
                padding: const EdgeInsets.all(24.0),
                separatorBuilder: (ctx, i) => const SizedBox(
                  height: 14,
                ),
                itemBuilder: (ctx, i) => Card(
                  margin: const EdgeInsets.all(0),
                  child: ListTile(
                    title: Text(bloodBags[i].label),
                    trailing: Text(
                      bloodBags[i].amount.toString(),
                      style: TextStyle(
                        color: bloodBags[i].amount > 0
                            ? Colors.green
                            : Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                itemCount: bloodBags.length,
              );
            }),
      ),
    );
  }
}
