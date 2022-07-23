import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iblood/blood_bank_system/providers/donor_forms_provider.dart';
import 'package:iblood/main_tabs/account_tab/pages/archive_page/widgets/archive_section.dart';
import 'package:iblood/main_tabs/account_tab/pages/archive_page/widgets/archive_section_item.dart';
import 'package:iblood/others/helpers/enums.dart';
import 'package:iblood/others/helpers/functions.dart';
import 'package:iblood/providers/auth_provider.dart';
import 'package:iblood/widgets/popable_page.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../blood_bank_system/models/donor_form/donor_form.dart';

class ArchivePage extends StatefulWidget {
  static const routeName = '/ArchivePage';

  const ArchivePage({Key? key}) : super(key: key);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return PoppablePage(
      label: 'Archive',
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: DonorFormsProvider().getAll(AuthProvider.userData!.clientId!),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<DonorForm> donorForms =
                    snapshot.data!.docs.map((doc) => DonorForm.fromJson(doc.data())).toList();
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: donorForms
                        .map(
                          (donorForm) => ArchiveSection(
                            label: dateTimeToString(donorForm.creationDate),
                            archiveSectionItem: ArchiveSectionItem(
                              label: 'baghdad blood bank',
                              // subtitle: donorForm.numberOfBags.toString(),
                              tileColor: donorForm.status == DonorFormStatus.rejected
                                  ? Colors.redAccent
                                  : Colors.white,
                              icon: const Icon(
                                FontAwesomeIcons.handHoldingWater,
                              ),
                              numberOfBags: donorForm.numberOfBags,
                              subtitle: donorForm.status == DonorFormStatus.rejected
                                  ? 'rejected because of ${generateRejectionCauseMessage(
                                      cause: donorForm.rejectionCause!,
                                      note: donorForm.rejectionNote,
                                    )}'
                                  : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return const Center(
                child: Text('no data'),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
