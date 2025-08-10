import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';
import 'package:overseas_front_end/utils/functions/split_phone_number.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../../../controller/config/config_controller.dart';
import '../../../../controller/registration/registration_controller.dart';
import '../../../../model/lead/lead_model.dart';
import '../../../widgets/custom_gender_row_format.dart';
import '../../../widgets/widgets.dart';

class PersonalDetailsTab extends StatefulWidget {
  LeadModel? leadModel;
  final Function(Map<String, dynamic>)? onSave;
  PersonalDetailsTab({
    super.key,
    this.leadModel,
    this.onSave,
  });

  @override
  State<PersonalDetailsTab> createState() => _PersonalDetailsTabState();
}

class _PersonalDetailsTabState extends State<PersonalDetailsTab> {
  final _configController = Get.find<ConfigController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _expectedSalaryController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  bool _onEmailCommunication = true;
  bool _phoneCommunication = false;
  bool _sendWhatsapp = false;
  String? _alternativeCountryCode = '+91';
  String? _emergencyCountryCode = '';
  String? _whatsappCountryCode = '';
  String? _maritalStatus;
  String? _religion;
  String? _nationality;
  String? _countryOfBirth;
  String? _contactCountryCode = '';
  bool withInSixMonths = false;
  int noDays = 0;
  List<String>? selectedCountry = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.leadModel != null) {
      _initializeFromModel(widget.leadModel!);
    }
  }

  void _initializeFromModel(LeadModel model) {
    _nameController.text = model.name ?? '';
    _surnameController.text = model.lastName ?? '';
    _emailController.text = model.email ?? '';
    _contactNumberController.text = model.phone ?? '';
    _contactCountryCode = model.countryCode ?? '';
    MapEntry<String, String>? alternatePhone =
        splitPhoneNumber(model.alternatePhone);
    _alternativeCountryCode = alternatePhone?.key;
    _alternativeNumberController.text = alternatePhone?.value ?? '';
    MapEntry<String, String>? emergencyPhone =
        splitPhoneNumber(model.emergencyContact);
    _emergencyCountryCode = emergencyPhone?.key;
    _emergencyContactController.text = emergencyPhone?.value ?? '';
    MapEntry<String, String>? whatsappPhone = splitPhoneNumber(model.whatsapp);
    _whatsappCountryCode = whatsappPhone?.key;
    _whatsappController.text = whatsappPhone?.value ?? '';
    _genderController.text = model.gender ?? '';
    _dobController.text = model.dob ?? '';
    _maritalStatus = model.maritalStatus;
    _currentLocationController.text = model.address ?? '';
    _birthPlaceController.text = model.birthPlace ?? '';
    _countryOfBirth = model.birthCountry;
    _religion = model.religion;
    _passportNumberController.text = model.passportNumber ?? '';
    _passportExpiryController.text = model.passportExpiryDate ?? '';
    _passwordController.text = model.emailPassword ?? '';
    // _expectedSalaryController.text = model.expectedSalary?.toString() ?? '';
    selectedCountry = model.countryInterested ?? [];
    _onEmailCommunication = model.onEmailCommunication ?? false;
    _phoneCommunication = model.onCallCommunication ?? false;
    _sendWhatsapp = model.onWhatsappCommunication ?? false;
    _remarksController.text = model.note ?? '';
    _nationality = model.country;
    print(selectedCountry);
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
    _passwordController.dispose();
    _expectedSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: LayoutBuilder(builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  int columnsCount = availableWidth > 1000
                      ? 3
                      : (availableWidth > 600 ? 2 : 1);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mandatory Fields Note
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.amber[100],
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 16, left: 20),
                          child: CustomRichText(sections: [
                            RichTextSection(text: 'Fields marked as '),
                            RichTextSection(
                              text: ' *  ',
                              color: const Color.fromRGBO(239, 68, 68, 1),
                            ),
                            RichTextSection(text: 'are Mandatory '),
                          ]),
                        ),
                      ),

                      // Personal Details Fields
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
                          CustomGenderRowFormatWidget(
                            selectedGender: _genderController.text,
                            isRequired: true,
                            onGenderChanged: (value) => setState(
                                () => _genderController.text = value ?? ''),
                          ),
                          CustomPhoneField(
                            label: 'Contact Number',
                            controller: _contactNumberController,
                            selectedCountry: _contactCountryCode,
                            onCountryChanged: (value) =>
                                setState(() => _contactCountryCode = value),
                            isRequired: true,
                          ),
                          CustomPhoneField(
                            label: 'Alternative Number',
                            controller: _alternativeNumberController,
                            selectedCountry: _alternativeCountryCode,
                            onCountryChanged: (value) =>
                                setState(() => _alternativeCountryCode = value),
                          ),
                          CustomPhoneField(
                            label: 'WhatsApp Contact Number',
                            controller: _whatsappController,
                            selectedCountry: _whatsappCountryCode,
                            onCountryChanged: (value) =>
                                setState(() => _whatsappCountryCode = value),
                          ),
                          CustomPhoneField(
                            label: 'Emergency Contact Number',
                            controller: _emergencyContactController,
                            selectedCountry: _emergencyCountryCode,
                            onCountryChanged: (value) =>
                                setState(() => _emergencyCountryCode = value),
                          ),
                          CustomTextFormField(
                            label: 'Address',
                            controller: _currentLocationController,
                          ),
                          CustomDropdownField(
                            label: 'Nationality',
                            value: _nationality,
                            items: _configController.configData.value.country
                                    ?.map((e) => e.name ?? "")
                                    .toList() ??
                                [],
                            onChanged: (value) =>
                                setState(() => _nationality = value),
                          ),
                          CustomDateField(
                            label: 'DOB',
                            controller: _dobController,
                            isRequired: true,
                            endDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 15)),
                          ),
                          CustomTextFormField(
                            label: 'Birth Place',
                            controller: _birthPlaceController,
                          ),
                          CustomDropdownField(
                            label: 'Country of Birth',
                            value: _countryOfBirth,
                            items: _configController.configData.value.country
                                    ?.map((e) => e.name ?? "")
                                    .toList() ??
                                [],
                            onChanged: (value) =>
                                setState(() => _countryOfBirth = value),
                          ),
                          CustomDropdownField(
                            label: 'Marital Status',
                            value: _maritalStatus,
                            items: const [
                              'Single',
                              'Married',
                              'Divorced',
                              'Widowed'
                            ],
                            onChanged: (value) =>
                                setState(() => _maritalStatus = value),
                          ),
                          CustomDropdownField(
                            label: 'Religion',
                            value: _religion,
                            items: const [
                              'Hindu',
                              'Muslim',
                              'Christian',
                              'Sikh',
                              'Buddhist',
                              'Jain',
                              'Other'
                            ],
                            onChanged: (value) =>
                                setState(() => _religion = value),
                          ),
                          CustomTextFormField(
                            label: 'Passport Number',
                            controller: _passportNumberController,
                            isRequired: true,
                          ),
                          Column(
                            children: [
                              CustomDateField(
                                label: 'Passport Expiry Date',
                                controller: _passportExpiryController,
                                isRequired: true,
                              ),
                              if (withInSixMonths)
                                CustomText(
                                  text: "Expires within $noDays days",
                                  color: Colors.red,
                                  fontSize: 10,
                                )
                            ],
                          ),
                        ],
                      ),

                      // Email Credentials Section
                      const SizedBox(height: 16),
                      const CustomText(
                        text: 'Email Credentials',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        columns: columnsCount,
                        children: [
                          CustomTextFormField(
                            label: 'Email ID',
                            controller: _emailController,
                            isRequired: true,
                            isEmail: true,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CustomTextFormField(
                            showPasswordToggle: true,
                            label: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),

                      // Candidate Preference Section
                      const SizedBox(height: 16),
                      const CustomText(
                        text: 'Candidate Preference',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        columns: columnsCount,
                        children: [
                          CustomCheckDropdown(
                            label: 'Preferred Countries',
                            values: selectedCountry ?? [],
                            items: _configController.configData.value.country
                                    ?.map((e) => e.name ?? "")
                                    .toList() ??
                                [],
                            onChanged: (selected) => setState(() =>
                                selectedCountry = selected.cast<String>()),
                            isRequired: true,
                          ),
                          // CustomTextFormField(
                          //   label: 'Expected Salary (USD)',
                          //   controller: _expectedSalaryController,
                          //   keyboardType: TextInputType.number,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const CustomText(
                        text: 'Communication Preferences',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        columns:
                            MediaQuery.of(context).size.width > 600 ? 4 : 1,
                        children: [
                          // CustomTextFormField(
                          //   label: 'Remarks',
                          //   controller: _remarksController,
                          //   maxLines: 3,
                          // ),
                          EnhancedSwitchTile(
                            label: ' Phone Communication',
                            icon: Icons.phone_rounded,
                            value: _phoneCommunication,
                            onChanged: (val) =>
                                setState(() => _phoneCommunication = val),
                          ),

                          EnhancedSwitchTile(
                            label: 'Email Communication',
                            icon: Icons.email_rounded,
                            value: _onEmailCommunication,
                            onChanged: (val) =>
                                setState(() => _onEmailCommunication = val),
                          ),

                          EnhancedSwitchTile(
                            label: 'WhatsApp Communication',
                            icon: Icons.chat_rounded,
                            value: _sendWhatsapp,
                            onChanged: (val) =>
                                setState(() => _sendWhatsapp = val),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const CustomText(
                        text: 'Communication Preferences',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                          columns:
                              MediaQuery.of(context).size.width > 600 ? 4 : 1,
                          children: [
                            CustomTextFormField(
                              label: 'Remarks',
                              controller: _remarksController,
                              maxLines: 3,
                            ),
                          ]),

                      // Action Buttons
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
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final updatedModel = LeadModel(
                                      sId: widget.leadModel?.sId,
                                      clientId: widget.leadModel?.clientId,
                                      name: _nameController.text.trim(),
                                      lastName: _surnameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      emailPassword:
                                          _passwordController.text.trim(),
                                      phone:
                                          _contactNumberController.text.trim(),
                                      countryCode: _contactCountryCode,
                                      alternatePhone:
                                          '$_alternativeCountryCode ${_alternativeNumberController.text.trim()}',
                                      whatsapp:
                                          '$_whatsappCountryCode ${_whatsappController.text.trim()}',
                                      emergencyContact:
                                          '$_emergencyCountryCode ${_emergencyContactController.text.trim()}',
                                      gender: _genderController.text.trim(),
                                      dob: _dobController.text,
                                      maritalStatus: _maritalStatus,
                                      country: _nationality,
                                      address: _currentLocationController.text
                                          .trim(),
                                      birthPlace:
                                          _birthPlaceController.text.trim(),
                                      birthCountry: _countryOfBirth,
                                      religion: _religion,
                                      passportNumber:
                                          _passportNumberController.text.trim(),
                                      passportExpiryDate:
                                          _passportExpiryController.text.trim(),
                                      // expectedSalary: int.tryParse(_expectedSalaryController.text.trim()),
                                      note: _remarksController.text.trim(),
                                      onEmailCommunication:
                                          _onEmailCommunication,
                                      onCallCommunication: _phoneCommunication,
                                      onWhatsappCommunication: _sendWhatsapp,
                                      countryInterested: selectedCountry);
                                  showLoaderDialog(context);
                                  bool result =
                                      await Get.find<RegistrationController>()
                                          .updatePersonalDetails(
                                    lead: updatedModel,
                                    customerId: widget.leadModel?.sId ?? '',
                                  );

                                  if (result) {
                                    Navigator.pop(context);
                                    CustomToast.showToast(
                                      context: context,
                                      backgroundColor: Colors.green,
                                      message:
                                          'Personal details Successfully updated ',
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    CustomToast.showToast(
                                      context: context,
                                      backgroundColor: Colors.red,
                                      message: Get.find<
                                                  RegistrationController>()
                                              .errorMessage ??
                                          'Failed to update personal details',
                                    );
                                  }
                                }
                              },
                            ),
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
