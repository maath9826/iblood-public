
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:iblood/data.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/donation_request_provider.dart';
import 'package:iblood/providers/donors_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:iblood/widgets/popable_page.dart';

class AddDonor extends StatefulWidget {
  static const routeName = '/AddDonor';
  const AddDonor({Key? key}) : super(key: key);

  @override
  _AddDonorState createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {

  String? _selectedBloodGroup;
  String? _selectedProvince;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateAllFields() {
    if (_formKey.currentState!.validate() && _selectedBloodGroup != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PoppablePage(
      label: 'Donor',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.end ,
            children: [
              const SizedBox(height: 18),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) return 'This field is required';
                },
                menuMaxHeight: 200,
                isExpanded: true,
                hint: const Text('Select Blood Group'),
                items: bloodGroups
                    .map(
                      (el) => DropdownMenuItem(
                    child: Text(el),
                    value: el,
                  ),
                )
                    .toList(),
                value: _selectedBloodGroup,
                onChanged: (value) => setState(() {
                  _selectedBloodGroup = value as String;
                }),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) return 'This field is required';
                },
                menuMaxHeight: 200,
                isExpanded: true,
                hint: const Text('Select Province'),
                items: governorates
                    .map(
                      (el) => DropdownMenuItem(
                        child: Text(el),
                        value: el,
                      ),
                    )
                    .toList(),
                value: _selectedProvince,
                onChanged: (value) => setState(() {
                  _selectedProvince = value as String;
                }),
              ),
              const SizedBox(height: 16),
              CustomField(
                controller: _cityController,
                label: 'city',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'This field is required';
                },
              ),
              const SizedBox(height: 16),
              CustomField(
                controller: _phoneNumberController,
                label: 'phone number',
                keyboardType: TextInputType.phone,
                isOptional: true,
              ),
              const SizedBox(
                height: 46,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(Size(double.maxFinite, 45))),
                onPressed: () async {

                    if (_validateAllFields()) {

                      try {
                        await DonorsProvider(PrivateCommunitiesProvider.currentPrivateCommunityId!).add(
                            donor: Donor(
                              memberId: PrivateCommunitiesProvider.currentMemberId!,
                              phoneNumber: _phoneNumberController.text.trim(),
                              bloodGroup: _selectedBloodGroup!,
                              province: _selectedProvince!,
                              city: _cityController.text.trim(),
                              gender: PrivateCommunitiesProvider.currentMember!.gender,
                            ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('succeeded'),
                            content: const Text('donor has been added'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'))
                            ],
                          ),
                        );
                      }catch(e,s){
                        print(e);
                        print(s);
                        const errorMessage = 'error occurred.';
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Add donor failed'),
                            content: const Text(errorMessage),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'))
                            ],
                          ),
                        );
                      }
                    }

                },
                child: const Text(
                  'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


