import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iblood/blood_bank_system/models/client/client.dart';
import 'package:iblood/blood_bank_system/providers/clients_provider.dart';
import 'package:iblood/dialogs/field_dialog.dart';
import 'package:iblood/main_tabs/account_tab/pages/profile_page/profile_page.dart';
import 'package:iblood/main_tabs/account_tab/widgets/account_section_item.dart';
import 'package:iblood/models/user/user.dart';
import 'package:iblood/others/helpers/enums.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/auth_provider.dart';
import 'package:iblood/providers/users_provider.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:provider/provider.dart';

import 'pages/archive_page/archive_page.dart';
import 'widgets/account_section.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final activationCodeController = TextEditingController();
  var isActivationSucceeded = false;

  Client? _client;

  @override
  void dispose() {
    // TODO: implement dispose
    activationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AccountSection(
            label: 'Profile',
            items: [
              AccountSectionItem(
                // color: isAssigned(_client) && _client!.status == ClientStatus.banned ? Colors.redAccent : null,
                label: AuthProvider.userData!.userName,
                subtitle: AuthProvider.userData!.email,
                icon: Icons.person,
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTabFunction: () => Navigator.of(context).pushNamed(ProfilePage.routeName),
              ),
            ],
          ),
          // Consumer<User>(
          //   builder: (ctx, user, _) {
          //     return AccountSection(
          //       label: 'General',
          //       items: [
          //         AccountSectionItem(
          //           label: 'Activation',
          //           subtitle: user.clientId == "" || user.clientId == null
          //               ? 'activate your account'
          //               : "your account has been activated",
          //           icon: Icons.assignment_turned_in,
          //           trailing: Text(
          //             user.clientId == "" || user.clientId == null ? 'not activated' : 'activated',
          //             style: TextStyle(
          //                 color: user.clientId == "" || user.clientId == null
          //                     ? Colors.red
          //                     : Colors.green),
          //           ),
          //           onTabFunction: () =>
          //           user.clientId == "" || user.clientId == null
          //               ? FieldDialog(
          //               fieldController: activationCodeController,
          //               dialogTitle: 'Enter your Activation Code',
          //               fieldLabel: 'activation code',
          //               onSubmit: _onSubmit,
          //               fieldLength: 8
          //           ).show(context: context)
          //               : null,
          //         ),
          //       ],
          //     );
          //   }
          // ),

          StreamBuilder<User?>(
              stream: UsersProvider().getStream(AuthProvider.userId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print(snapshot.stackTrace);
                }
                if (snapshot.hasData) {
                  var user = snapshot.data!;
                  return AccountSection(
                    label: 'General',
                    items: [
                      AccountSectionItem(
                        label: 'Activation',
                        subtitle: user.clientId == "" || user.clientId == null
                            ? 'activate your account'
                            : "your account has been activated",
                        icon: Icons.assignment_turned_in,
                        trailing: Text(
                          user.clientId == "" || user.clientId == null ? 'not activated' : 'activated',
                          style: TextStyle(
                              color: user.clientId == "" || user.clientId == null
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        onTabFunction: () =>
                        user.clientId == "" || user.clientId == null
                            ? FieldDialog(
                            fieldController: activationCodeController,
                            dialogTitle: 'Enter your Activation Code',
                            fieldLabel: 'activation code',
                            onSubmit: _onSubmit,
                            fieldLength: 8
                        ).show(context: context)
                            : null,
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              }),
          // Consumer<User>(builder: (ctx, user, _) {
          //   return AccountSection(
          //     label: 'Blood Bank Info',
          //     items: [
          //       AccountSectionItem(
          //         label: 'Balance',
          //         subtitle: 'Your blood bags balance',
          //         icon: Icons.account_balance,
          //         trailing: !isAssigned(user.clientId)
          //             ? const Icon(
          //                 Icons.error,
          //                 color: Colors.red,
          //               )
          //             : StreamBuilder<Client?>(
          //                 stream: ClientsProvider().getStream(user.clientId!),
          //                 builder: (context, snapshot) {
          //                   if (snapshot.hasError) {
          //                     print(snapshot.error);
          //                     print(snapshot.stackTrace);
          //                   }
          //                   if (snapshot.hasData) {
          //                     _client = snapshot.data!;
          //                     return Text(
          //                       _client!.balance.toString(),
          //                       style: const TextStyle(
          //                         color: Colors.green,
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 20,
          //                       ),
          //                     );
          //                   }
          //                   return const CircularProgressIndicator();
          //                 }),
          //       ),
          //       AccountSectionItem(
          //         label: 'Archive',
          //         subtitle: 'Your donation archive',
          //         icon: Icons.storage,
          //         onTabFunction: () => user.clientId == "" || user.clientId == null
          //             ? null
          //             : Navigator.of(context).pushNamed(ArchivePage.routeName),
          //         trailing: user.clientId == "" || user.clientId == null
          //             ? const Icon(
          //                 Icons.error,
          //                 color: Colors.red,
          //               )
          //             : const Icon(
          //                 Icons.keyboard_arrow_right,
          //               ),
          //       ),
          //     ],
          //   );
          // }),
          StreamBuilder<User?>(
              stream: UsersProvider().getStream(AuthProvider.userId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print(snapshot.stackTrace);
                }
                if (snapshot.hasData) {
                  var user = snapshot.data!;
                  return AccountSection(
                    label: 'Blood Bank Info',
                    items: [
                      AccountSectionItem(
                        label: 'Balance',
                        subtitle: 'Your blood bags balance',
                        icon: Icons.account_balance,
                        trailing: !isAssigned(user.clientId)
                            ? const Icon(
                          Icons.error,
                          color: Colors.red,
                        )
                            : StreamBuilder<Client?>(
                            stream: ClientsProvider().getStream(user.clientId!),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                print(snapshot.stackTrace);
                              }
                              if (snapshot.hasData) {
                                _client = snapshot.data!;
                                return Text(
                                  _client!.balance.toString(),
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                      ),
                      AccountSectionItem(
                        label: 'Archive',
                        subtitle: 'Your donation archive',
                        icon: Icons.storage,
                        onTabFunction: () => user.clientId == "" || user.clientId == null
                            ? null
                            : Navigator.of(context).pushNamed(ArchivePage.routeName),
                        trailing: user.clientId == "" || user.clientId == null
                            ? const Icon(
                          Icons.error,
                          color: Colors.red,
                        )
                            : const Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              }),
          AccountSection(
            label: 'Actions',
            items: [
              AccountSectionItem(
                label: 'Logout',
                subtitle: 'Logout from iblood',
                icon: Icons.logout,
                onTabFunction: () => Provider.of<AuthProvider>(context, listen: false).logout(),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  void _onSubmit({
    required FieldDialog fieldDialog,
    required BuildContext dialogContext,
    required void Function(void Function()) dialogSetState,
  }) async {
    final String userId = AuthProvider.userId;

    fieldDialog.errorMessage = null;

    if (!fieldDialog.formKey.currentState!.validate()) return;

    try {
      dialogSetState(() {
        fieldDialog.isLoading = true;
      });
      var clientProvider = ClientsProvider();
      // final clientSnapshot = await clientProvider.get(fieldDialog.fieldController.text);
      final clientSnapshot = await clientProvider.getClientFromDonorCode(
        donorCode: fieldDialog.fieldController.text,
      );
      if (clientSnapshot.exists) {
          await AuthProvider.userData!.activateUser(userId, clientSnapshot.id);
          dialogSetState(() {
            fieldDialog.isActivationSucceeded = true;
          });

      } else {
        if (fieldDialog.isOpened) {
          dialogSetState(() {
            if (!clientSnapshot.exists) {
              fieldDialog.errorMessage = 'Wrong Code!';
            } else {
              fieldDialog.errorMessage = 'This code is already used';
            }
          });
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
      fieldDialog.errorMessage = 'Wrong Code!';
    }

    /// making sure that the dialog exist before changing it's state
    if (fieldDialog.isOpened) {
      dialogSetState(() {
        fieldDialog.isLoading = false;
      });
    }
  }
}
