import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iblood/data.dart';
import 'package:iblood/models/donation_request/donation_request.dart';
import 'package:iblood/providers/donation_request_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/services/local_push_notification_service.dart';
import 'package:iblood/widgets/custom_dropdown.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:iblood/widgets/popable_page.dart';

class AddDonationRequest extends StatefulWidget {
  static const routeName = '/AddDonationRequest';

  const AddDonationRequest({Key? key}) : super(key: key);

  @override
  _AddDonationRequestState createState() => _AddDonationRequestState();
}

class _AddDonationRequestState extends State<AddDonationRequest> {
  var donationRequestProvider = DonationRequestProvider(
      PrivateCommunitiesProvider.currentPrivateCommunityId!);

  String? _selectedBloodGroup;
  String? _selectedLocation;

  final TextEditingController _phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color _dropdownBorderColor = Colors.black54;

  bool _validateAllFields() {
    if (_formKey.currentState!.validate() && _selectedBloodGroup != null) {
      return true;
    } else {
      return false;
    }
  }

  _requiredValidation(String value) {
    if (value.isEmpty) return 'This field is required';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PoppablePage(
      label: 'Donation Request',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.end ,
            children: [
              const SizedBox(height: 18),
              const SizedBox(height: 10),
              CustomField(
                controller: _phoneNumberController,
                label: 'phone number',
                validator: (value) {
                  return _requiredValidation(_phoneNumberController.text);
                },
                keyboardType: TextInputType.phone,
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
                hint: const Text('Select Location'),
                items: governorates
                    .map(
                      (el) => DropdownMenuItem(
                        child: Text(el),
                        value: el,
                      ),
                    )
                    .toList(),
                value: _selectedLocation,
                onChanged: (value) => setState(() {
                  _selectedLocation = value as String;
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDropdown(
                hint: 'Select Blood Group',
                list: bloodGroups,
                selectedItem: _selectedBloodGroup,
                onChange: (value) => setState(() {
                  _selectedBloodGroup = value as String;
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(Size(double.maxFinite, 45))),
                onPressed: () async {
                  if (_validateAllFields()) {
                    try {
                      await donationRequestProvider.add(
                        donationRequest: DonationRequest(
                          phoneNumber: _phoneNumberController.text,
                          bloodGroup: _selectedBloodGroup as String,
                          location: _selectedLocation as String,
                          creationDate: DateTime.now(),
                        ),
                        context: context,
                      );
                      await LocalPushNotificationService
                          .sendNotificationToTopic(
                        '${PrivateCommunitiesProvider.currentPrivateCommunity!.name} Donation Request',
                        '$_selectedBloodGroup blood group is requested',
                          PrivateCommunitiesProvider.currentPrivateCommunity!.name.split(' ').join()
                      );
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('succeeded'),
                          content:
                              const Text('donation request has been added'),
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
                    } catch (e, s) {
                      print(e);
                      print(s);
                      const errorMessage = 'error occurred.';
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add donation request failed'),
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
