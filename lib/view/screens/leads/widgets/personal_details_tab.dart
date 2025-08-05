import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_check_dropdown.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_gender_row_format.dart';
import '../../../widgets/custom_phone_number_field.dart';
import '../../../widgets/custom_rich_text.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/responsive_grid.dart';

class VacanyDeatilsTab extends StatefulWidget {
  const VacanyDeatilsTab({super.key});

  @override
  State<VacanyDeatilsTab> createState() => _VacanyDeatilsTabState();
}

class _VacanyDeatilsTabState extends State<VacanyDeatilsTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _alternativeNumberController =
      TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentLocationController =
      TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _passportExpiryController =
      TextEditingController();
  final TextEditingController _skypeController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _alternativeCountryCode = '+91';
  String? _maritalStatus = 'Choose ...';
  String? _religion = 'Choose ...';
  String? _nationality = 'India';
  String? _countryOfBirth = 'India';
  String? _gender = 'Male';
  String? _contactCountryCode = '+91';
  bool withInSixMonths = false;
  int noDays = 0;
  List<dynamic>? selectedCountry = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _nameController.text = '';
    _contactNumberController.text = '';
    _emailController.text = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _dobController.dispose();
    _contactNumberController.dispose();
    _alternativeNumberController.dispose();
    _emergencyContactController.dispose();
    _emailController.dispose();
    _currentLocationController.dispose();
    _birthPlaceController.dispose();
    _passportNumberController.dispose();
    _passportExpiryController.dispose();
    _skypeController.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectPassportExpiry(BuildContext context) async {
    final now = DateTime.now();
    final sixMonthsFromNow = DateTime(now.year, now.month + 6, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() {
        withInSixMonths = picked.isBefore(sixMonthsFromNow);
        noDays = picked.difference(now).inDays;
        _passportExpiryController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mandatory Fields Note

          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: LayoutBuilder(builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  int columnsCount = 1;

                  if (availableWidth > 1000) {
                    columnsCount = 3;
                  } else if (availableWidth > 600) {
                    columnsCount = 2;
                  }

                  // New UI based on the commented section
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.amber[100],
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 16, left: 20),
                          child: CustomRichText(sections: [
                            RichTextSection(
                              text: 'Fields marked as ',
                            ),
                            RichTextSection(
                                text: ' *  ',
                                color: const Color.fromRGBO(239, 68, 68, 1)),
                            RichTextSection(
                              text: 'are Mandatory ',
                            ),
                          ]),
                        ),
                      ),
                      // Profile Picture and Name/Surname

                      ResponsiveGrid(
                        columns: columnsCount,
                        children: [
                          CustomTextFormField(
                            label: 'Name',
                            controller: _nameController,
                            isRequired: true,
                          ),
                          CustomTextFormField(
                            label: 'Last Name',
                            controller: _surnameController,
                          ),
                          CustomGenderRowFormatWidget(),
                          CustomPhoneField(
                            label: 'Contact Number',
                            controller: _contactNumberController,
                            selectedCountry: _contactCountryCode,
                            onCountryChanged: (value) {
                              setState(() {
                                _contactCountryCode = value;
                              });
                            },
                            isRequired: true,
                          ),
                          CustomPhoneField(
                            label: 'Alternative Number',
                            controller: _alternativeNumberController,
                            selectedCountry: _alternativeCountryCode,
                            onCountryChanged: (value) {
                              setState(() {
                                _alternativeCountryCode = value;
                              });
                            },
                          ),
                          CustomPhoneField(
                            label: 'Emergency Contact Number',
                            controller: _alternativeNumberController,
                            selectedCountry: _alternativeCountryCode,
                            onCountryChanged: (value) {
                              setState(() {
                                _alternativeCountryCode = value;
                              });
                            },
                          ),
                          CustomTextFormField(
                            label: 'Email ID',
                            controller: _emailController,
                          ),
                          CustomTextFormField(
                            label: 'Address',
                            controller: _currentLocationController,
                          ),
                          CustomDropdownField(
                            label: 'Nationality',
                            value: _nationality,
                            items: [
                              'India',
                              'USA',
                              'UK',
                              'Australia',
                              'Canada',
                              'Other'
                            ],
                            onChanged: (value) {
                              setState(() {
                                _nationality = value;
                              });
                            },
                          ),
                          CustomTextFormField(
                            label: 'DOB (Age NaN)',
                            controller: _dobController,
                            isRequired: true,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          CustomTextFormField(
                            label: 'Birth Place',
                            controller: _birthPlaceController,
                          ),
                          CustomDropdownField(
                            label: 'Country of Birth',
                            value: _countryOfBirth,
                            items: [
                              'India',
                              'USA',
                              'UK',
                              'Australia',
                              'Canada',
                              'Other'
                            ],
                            onChanged: (value) {
                              setState(() {
                                _countryOfBirth = value;
                              });
                            },
                          ),
                          CustomDropdownField(
                            label: 'Marital Status',
                            value: _maritalStatus,
                            items: [
                              'Choose ...',
                              'Single',
                              'Married',
                              'Divorced',
                              'Widowed'
                            ],
                            onChanged: (value) {
                              setState(() {
                                _maritalStatus = value;
                              });
                            },
                          ),
                          CustomDropdownField(
                            label: 'Religion',
                            value: _religion,
                            items: [
                              'Choose ...',
                              'Hindu',
                              'Muslim',
                              'Christian',
                              'Sikh',
                              'Buddhist',
                              'Jain',
                              'Other'
                            ],
                            onChanged: (value) {
                              setState(() {
                                _religion = value;
                              });
                            },
                          ),
                          CustomTextFormField(
                            label: 'Passport Number',
                            controller: _passportNumberController,
                            isRequired: true,
                          ),
                          Column(
                            children: [
                              CustomTextFormField(
                                label: 'Passport Expiry Date',
                                controller: _passportExpiryController,
                                isRequired: true,
                                readOnly: true,
                                onTap: () {
                                  _selectPassportExpiry(context);
                                },
                              ),
                              Visibility(
                                  visible: withInSixMonths,
                                  child: CustomText(
                                    text: "Expires within $noDays days",
                                    color: Colors.red,
                                    fontSize: 10,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const CustomText(
                          text: 'Email Credential',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        columns: columnsCount,
                        children: [
                          CustomTextFormField(
                            label: 'Email ID',
                            controller: _emailIdController,
                          ),
                          CustomTextFormField(
                            label: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const CustomText(
                          text: 'Candidate Preference',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        columns: columnsCount,
                        children: [
                          CustomCheckDropdown(
                            label: 'Designation',
                            values: selectedCountry ?? [],
                            items: const [
                              'India',
                              'USA',
                              'UK',
                              'Australia',
                              'Canada',
                              'Other'
                            ],
                            onChanged: (selected) =>
                                setState(() => selectedCountry = selected),
                            isRequired: true,
                          ),
                          CustomTextFormField(
                            label: 'Expected Salary',
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 16),
                            CustomButton(
                              text: 'Save',
                              width: 100,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Save form data
                                  Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
