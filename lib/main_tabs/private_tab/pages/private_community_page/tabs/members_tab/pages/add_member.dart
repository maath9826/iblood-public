import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iblood/data.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/providers/auth_provider.dart';
import 'package:iblood/providers/donors_provider.dart';
import 'package:iblood/providers/members_provider.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/widgets/custom_dropdown.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:iblood/widgets/popable_page.dart';
import 'package:iblood/widgets/three_fields_date.dart';

class AddMember extends StatefulWidget {
  static const routeName = '/AddMember';

  const AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  String? _selectedBloodGroup;
  String? _selectedProvince;
  String? _selectedDepartment;
  String? _selectedGrade;
  String? _selectedJob;
  Gender? _selectedGender;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();

  var _isDonor = false;
  var _isDonatedBefore = false;
  var _isAuthBloodGroup = false;

  DateTime? _birthDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateAllFields() {
    print(_selectedProvince != null);
    if (_formKey.currentState!.validate() &&
        _selectedBloodGroup != null &&
        _selectedDepartment != null &&
        _selectedGender != null &&
        _selectedProvince != null &&
        _selectedJob != null &&
        _birthDate != null) {
      return true;
    } else {
      return false;
    }
  }

  _requiredValidation(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PoppablePage(
      label: 'Member',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 28),
                CustomField(
                  controller: _nameController,
                  label: 'name',
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  hint: 'select a gender',
                  list: Gender.values,
                  onChange: (value) {
                    _selectedGender = value as Gender;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                    hint: 'select a blood group',
                    list: bloodGroups,
                    onChange: (value) {
                      _selectedBloodGroup = value as String;
                    }),
                const SizedBox(height: 16),
                ThreeFieldsDate(
                  title: 'Birth date',
                  dayController: _dayController,
                  monthController: _monthController,
                  yearController: _yearController,
                  onChange: (date) {
                    _birthDate = date;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                    hint: 'select a job',
                    list: jobs,
                    onChange: (value) {
                      _selectedJob = value as String;
                    }),
                const SizedBox(height: 16),
                CustomDropdown(
                    hint: 'select a department',
                    list: departments,
                    onChange: (value) {
                      _selectedDepartment = value as String;
                    }),
                const SizedBox(height: 16),
                CustomDropdown(
                  isOptional: true,
                  hint: 'select a grade',
                  list: grades,
                  onChange: (value) {
                    _selectedGrade = value as String;
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                    hint: 'select a province',
                    list: governorates,
                    onChange: (value) {
                      _selectedProvince = value as String;
                    }),
                const SizedBox(height: 16),
                CustomField(
                  controller: _cityController,
                  label: 'city',
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  title: const Text('authentic blood group'),
                  value: _isAuthBloodGroup,
                  onChanged: (value) {
                    setState(() {
                      _isAuthBloodGroup = value!;
                    });
                  },
                  tileColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  title: const Text('donated before'),
                  value: _isDonatedBefore,
                  onChanged: (value) {
                    setState(() {
                      _isDonatedBefore = value!;
                    });
                  },
                  tileColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  title: const Text('register me as donor'),
                  value: _isDonor,
                  onChanged: (value) {
                    setState(() {
                      _isDonor = value!;
                    });
                  },
                  tileColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomField(
                  controller: _phoneNumberController,
                  label: 'phone number',
                  keyboardType: TextInputType.phone,
                  isOptional: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(double.maxFinite, 45))),
                  onPressed: () async {
                    if (_validateAllFields()) {
                      print('validated');
                      try {
                        var memberSnapshot = await MembersProvider(PrivateCommunitiesProvider
                                .currentPrivateCommunityId!)
                            .add(
                          PrivateCommunityMember(
                            name: _nameController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            bloodGroup: _selectedBloodGroup as String,
                            province: _selectedProvince as String,
                            gender: _selectedGender!,
                            city: _cityController.text.trim(),
                            department: _selectedDepartment!,
                            grade: _selectedGrade,
                            job: _selectedJob!,
                            isDonatedBefore: _isDonatedBefore,
                            isDonor: _isDonor,
                            isAuthBloodGroup: _isAuthBloodGroup,
                            birthDate: _birthDate!,
                            creationDate: DateTime.now(),
                          ),
                        );
                        Navigator.of(context).pop();
                      } catch (e, s) {
                        print(e);
                        print(s);
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
      ),
    );
  }
}
