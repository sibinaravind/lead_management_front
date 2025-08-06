import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../widgets/custom_toast.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen>
    with TickerProviderStateMixin {
  final configController = Get.find<ConfigController>();
  final _formKey = GlobalKey<FormState>();
  // Form fields
  String? _selectedService = 'MIGRATION';
  String? _selectedCountry = '+91';
  String? _selectedBranch = 'AFFINIKIS';
  String? _selectedGender;
  String? _selectedMaritalStatus;

  String? _selectedPhone;
  String? _selectedAltPhone;
  String? _selectedWAPhone;

  String? _selectedPhoneCtry;
  String? _selectedAltPhoneCtry;
  String? _selectedWAPhoneCtry;

  String? _selectedLeadSource;
  String? _selectedLeadCategory;
  String? _selectedStatus;
  String? _selectedServiceType;
  String? _selectedQualification;

  // String? _selectedEmployees;
  String? _selectedDistrict;
  String? _selectedAgent;
  bool _sendGreetings = true;
  bool _sendEmail = false;
  bool _sendWhatsapp = false;
  final bool _visibility = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _waMobileController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _leadDateController = TextEditingController();
  final TextEditingController _mobileOptionalController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  final _dobController = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _countryController = TextEditingController();

  List<String> selectedCountries = [];

  List<String>? _selectedSpecialized;

  @override
  void initState() {
    super.initState();
    _selectedPhoneCtry = "";
    _selectedAltPhoneCtry = "";
    _selectedWAPhoneCtry = "";

    _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _leadDateController.dispose();
    _mobileOptionalController.dispose();
    _locationController.dispose();
    _qualificationController.dispose();
    _courseNameController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.72;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 1600,
                minHeight: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.leaderboard_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Add New Lead',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: 'Capture lead details for follow up',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(24),
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                final availableWidth =
                                                    constraints.maxWidth;
                                                int columnsCount = 1;

                                                if (availableWidth > 1000) {
                                                  columnsCount = 3;
                                                } else if (availableWidth >
                                                    600) {
                                                  columnsCount = 2;
                                                }

                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // const SectionTitle(
                                                    //     title:
                                                    //         'Lead Information',
                                                    //     icon: Icons
                                                    //         .info_outline_rounded),
                                                    // const SizedBox(height: 16),
                                                    // ResponsiveGrid(
                                                    //     columns: columnsCount,
                                                    //     children: [
                                                    //       // CustomDropdownField(
                                                    //       //   label: 'Service',
                                                    //       //   value:
                                                    //       //       _selectedService,
                                                    //       //   items: configController
                                                    //       //           .configData
                                                    //       //           .value
                                                    //       //           .serviceType
                                                    //       //           ?.map((e) =>
                                                    //       //               e.name ??
                                                    //       //               "")
                                                    //       //           .toList() ??
                                                    //       //       [],
                                                    //       //   onChanged: (val) =>
                                                    //       //       setState(() =>
                                                    //       //           _selectedService =
                                                    //       //               val),
                                                    //       //   isRequired: true,
                                                    //       // ),
                                                    //       // CustomDropdownField(
                                                    //       //   label: 'Branch',
                                                    //       //   value:
                                                    //       //       _selectedBranch,
                                                    //       //   items: configProvider
                                                    //       //           .configModelList
                                                    //       //           ?.branch
                                                    //       //           ?.map((e) =>
                                                    //       //               e.name ??
                                                    //       //               "")
                                                    //       //           .toList() ??
                                                    //       //       [],
                                                    //       //   onChanged: (val) =>
                                                    //       //       setState(() =>
                                                    //       //           _selectedBranch =
                                                    //       //               val),
                                                    //       //   isRequired: true,
                                                    //       // ),
                                                    //       // CustomTextFormField(
                                                    //       //   label: 'Lead Date',
                                                    //       //   controller:
                                                    //       //       _leadDateController,
                                                    //       //   readOnly: true,
                                                    //       //   isdate: true,
                                                    //       // ),
                                                    //     ]),
                                                    const SizedBox(height: 32),
                                                    const SectionTitle(
                                                        title:
                                                            'Personal Details',
                                                        icon: Icons
                                                            .person_outline_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomTextFormField(
                                                            label: 'Full Name',
                                                            controller:
                                                                _nameController,
                                                            isRequired: true,
                                                          ),
                                                          CustomPhoneField(
                                                            showCountryCode:
                                                                true,
                                                            label:
                                                                'Mobile Number',
                                                            controller:
                                                                _mobileController,
                                                            selectedCountry:
                                                                _selectedPhoneCtry,
                                                            onCountryChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedPhoneCtry =
                                                                        val),
                                                            isRequired: true,
                                                          ),
                                                          CustomPhoneField(
                                                            label:
                                                                'Whatsapp Number',
                                                            controller:
                                                                _waMobileController,
                                                            selectedCountry:
                                                                _selectedWAPhoneCtry,
                                                            onCountryChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedWAPhoneCtry =
                                                                        val),
                                                            isRequired: false,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Email ID',
                                                            controller:
                                                                _emailController,
                                                          ),
                                                          CustomDateField(
                                                            label: 'DOB',
                                                            controller:
                                                                _dobController,
                                                          ),
                                                        ]),
                                                    const SizedBox(height: 20),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomPhoneField(
                                                            label:
                                                                'Alternate Mobile (Optional)',
                                                            controller:
                                                                _mobileOptionalController,
                                                            selectedCountry:
                                                                _selectedAltPhoneCtry,
                                                            onCountryChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedAltPhoneCtry =
                                                                        val),
                                                          ),
                                                          CustomDropdownField(
                                                            label: 'Gender',
                                                            value:
                                                                _selectedGender,
                                                            items: const [
                                                              'Male',
                                                              'Female',
                                                              'Other'
                                                            ],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedGender =
                                                                        val),
                                                          ),
                                                          CustomCheckDropdown(
                                                            label:
                                                                "Interested Country",
                                                            items: configController
                                                                    .configData
                                                                    .value
                                                                    .country
                                                                    ?.map(
                                                                      (e) =>
                                                                          e.name ??
                                                                          "",
                                                                    )
                                                                    .toList() ??
                                                                [],
                                                            values: [],
                                                            onChanged: (value) {
                                                              selectedCountries =
                                                                  value.cast<
                                                                      String>();
                                                            },
                                                          ),
                                                          CustomCheckDropdown(
                                                            label:
                                                                'Specialized',
                                                            items: configController
                                                                    .configData
                                                                    .value
                                                                    .specialized
                                                                    ?.map((e) =>
                                                                        e.name ??
                                                                        "")
                                                                    .toList() ??
                                                                [],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedSpecialized =
                                                                        val.cast<
                                                                            String>()),
                                                            values: [],
                                                          ),
                                                          CustomDropdownField(
                                                            label:
                                                                'Marital Status',
                                                            value:
                                                                _selectedMaritalStatus,
                                                            items: const [
                                                              'Single',
                                                              'Married',
                                                            ],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedMaritalStatus =
                                                                        val),
                                                          ),
                                                          CustomDropdownField(
                                                            label:
                                                                'Lead Source',
                                                            value:
                                                                _selectedLeadSource,
                                                            items: configController
                                                                    .configData
                                                                    .value
                                                                    .leadSource
                                                                    ?.map((e) =>
                                                                        e.name ??
                                                                        "")
                                                                    .toList() ??
                                                                [],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedLeadSource =
                                                                        val),
                                                          ),
                                                        ]),
                                                    const SizedBox(height: 32),
                                                    const SectionTitle(
                                                        title:
                                                            'Education Details',
                                                        icon: Icons
                                                            .school_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomDropdownField(
                                                            label:
                                                                'Qualification',
                                                            value:
                                                                _selectedQualification,
                                                            items: configController
                                                                    .configData
                                                                    .value
                                                                    .programType
                                                                    ?.map(
                                                                      (e) =>
                                                                          e.name ??
                                                                          "",
                                                                    )
                                                                    .toList() ??
                                                                [],
                                                            onChanged:
                                                                (String? val) {
                                                              setState(() {
                                                                _selectedQualification =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                          CustomTextFormField(
                                                            label:
                                                                'Course Name (If any)',
                                                            controller:
                                                                _courseNameController,
                                                          ),
                                                          // CustomDropdownField(
                                                          //   label:
                                                          //       'Lead Status',
                                                          //   value:
                                                          //       _selectedStatus,
                                                          //   items: configProvider
                                                          //           .configModelList
                                                          //           ?.clientStatus
                                                          //           ?.map(
                                                          //             (e) =>
                                                          //                 e.name ??
                                                          //                 "",
                                                          //           )
                                                          //           .toList() ??
                                                          //       [],
                                                          //   onChanged: (val) =>
                                                          //       setState(() =>
                                                          //           _selectedServiceType =
                                                          //               val),
                                                          // ),
                                                        ]),
                                                    const SizedBox(height: 32),
                                                    const SectionTitle(
                                                        title:
                                                            'Location Details',
                                                        icon: Icons
                                                            .location_on_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                        columns: columnsCount,
                                                        children: [
                                                          CustomTextFormField(
                                                            label: 'Location',
                                                            controller:
                                                                _locationController,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'City',
                                                            controller:
                                                                _cityController,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'State',
                                                            controller:
                                                                _stateController,
                                                          ),
                                                          CustomTextFormField(
                                                            label: 'Country',
                                                            controller:
                                                                _countryController,
                                                          ),
                                                          // CustomDropdownField(
                                                          //   label: 'District',
                                                          //   value:
                                                          //       _selectedDistrict,
                                                          //   items: const [
                                                          //     'District 1',
                                                          //     'District 2',
                                                          //     'District 3'
                                                          //   ],
                                                          //   onChanged: (val) =>
                                                          //       setState(() =>
                                                          //           _selectedDistrict =
                                                          //               val),
                                                          // ),
                                                          CustomDropdownField(
                                                            label:
                                                                'Assigned To',
                                                            value:
                                                                _selectedAgent,
                                                            items: const [
                                                              'Agent 1',
                                                              'Agent 2',
                                                              'Agent 3'
                                                            ],
                                                            onChanged: (val) =>
                                                                setState(() =>
                                                                    _selectedAgent =
                                                                        val),
                                                          ),
                                                        ]),
                                                    Visibility(
                                                        visible: maxWidth > 1000
                                                            ? false
                                                            : true,
                                                        child: const SizedBox(
                                                            height: 32)),
                                                    Visibility(
                                                      visible: maxWidth > 1000
                                                          ? false
                                                          : true,
                                                      child: const SectionTitle(
                                                          title:
                                                              'Communication Preference',
                                                          icon: Icons
                                                              .person_outline_rounded),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Visibility(
                                                      visible: maxWidth > 1000
                                                          ? false
                                                          : true,
                                                      child: ResponsiveGrid(
                                                          columns: columnsCount,
                                                          children: [
                                                            EnhancedSwitchTile(
                                                              label:
                                                                  'Send Greetings',
                                                              icon: Icons
                                                                  .celebration_rounded,
                                                              value:
                                                                  _sendGreetings,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _sendGreetings =
                                                                          val),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            EnhancedSwitchTile(
                                                              label:
                                                                  'Send Email Updates',
                                                              icon: Icons
                                                                  .email_rounded,
                                                              value: _sendEmail,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _sendEmail =
                                                                          val),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            EnhancedSwitchTile(
                                                              label:
                                                                  'WhatsApp Communication',
                                                              icon: Icons
                                                                  .chat_rounded,
                                                              value:
                                                                  _sendWhatsapp,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _sendWhatsapp =
                                                                          val),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    const SectionTitle(
                                                        title:
                                                            'Additional Information',
                                                        icon:
                                                            Icons.note_rounded),
                                                    const SizedBox(height: 16),
                                                    CustomTextFormField(
                                                      label: 'Remarks',
                                                      controller:
                                                          _remarksController,
                                                      maxLines: 3,
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                );
                                              },
                                            )),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // Expanded(
                                        //   child: CustomActionButton(
                                        //     text: 'Reset',
                                        //     icon: Icons.refresh_rounded,
                                        //     onPressed: () {
                                        //       // Reset form logic
                                        //       _formKey.currentState?.reset();
                                        //       setState(() {
                                        //         _selectedService = 'MIGRATION';
                                        //         _selectedCountry = '91';
                                        //         _selectedBranch = 'AFFINIKIS';
                                        //         _selectedGender = null;
                                        //         _selectedLeadSource = null;
                                        //         _selectedLeadCategory = null;
                                        //         _selectedEmployees = null;
                                        //         _selectedDistrict = null;
                                        //         _selectedAgent = null;
                                        //         _sendGreetings = true;
                                        //         _sendEmail = false;
                                        //         _sendWhatsapp = false;
                                        //       });
                                        //     },
                                        //     borderColor: Colors.grey.shade300,
                                        //   ),
                                        // ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomActionButton(
                                            text: 'Cancel',
                                            icon: Icons.close_rounded,
                                            textColor: Colors.grey,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            borderColor: Colors.grey.shade300,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          flex: 2,
                                          child: CustomActionButton(
                                            text: 'Save Lead',
                                            icon: Icons.save_rounded,
                                            isFilled: true,
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF7F00FF),
                                                Color(0xFFE100FF)
                                              ],
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // var completed = await Provider.of<LeadProvider>(context, listen: false).addLead(
                                                //     countryPhoneCode:
                                                //         _selectedPhoneCtry ??
                                                //             '',
                                                //     context,
                                                //     name: _nameController.text
                                                //         .trim(),
                                                //     email: _emailController.text
                                                //         .trim(),
                                                //     phone:
                                                //         "${_mobileController.text.trim()}",
                                                //     alternatePhone:
                                                //         "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
                                                //             .trim(),
                                                //     whatsapp:
                                                //         "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}"
                                                //             .trim(),
                                                //     gender:
                                                //         _selectedGender ?? "",
                                                //     dob: _dobController.text
                                                //             .trim() ??
                                                //         "",
                                                //     matrialStatus:
                                                //         _selectedMaritalStatus ??
                                                //             '',
                                                //     address: _locationController.text
                                                //         .trim(),
                                                //     city: "",
                                                //     state: "",
                                                //     country: "",
                                                //     jobInterests: [],
                                                //     countryInterested:
                                                //         selectedCountries ?? [],
                                                //     expectedSalary: 0,
                                                //     qualification:
                                                //         _selectedQualification ?? "",
                                                //     university: "",
                                                //     passingYear: "",
                                                //     experience: 0,
                                                //     skills: [],
                                                //     profession: "",
                                                //     specializedIn: _selectedSpecialized ?? [],
                                                //     leadSource: _selectedLeadSource ?? "",
                                                //     comment: _remarksController.text.trim(),
                                                //     onCallCommunication: true,
                                                //     onWhatsappCommunication: _sendWhatsapp,
                                                //     onEmailCommunication: _sendEmail,
                                                //     status: _selectedLeadCategory ?? "",
                                                //     serviceType: _selectedService ?? "",
                                                //     branchName: _selectedBranch ?? "");
                                                // if (completed) {
                                                //   CustomToast.showToast(
                                                //       context: context,
                                                //       message:
                                                //           'Lead saved successfully');
                                                //   // Save lead logic
                                                //   // ScaffoldMessenger.of(context)
                                                //   //     .showSnackBar(
                                                //   //   const SnackBar(
                                                //   //       content: Text(
                                                //   //           'Lead saved successfully')),
                                                //   // );
                                                // }
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Visibility(
                              visible: maxWidth > 1000 ? _visibility : false,
                              child: Container(
                                // width: 280,
                                width: MediaQuery.of(context).size.width * .2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.violetPrimaryColor
                                          .withOpacity(0.08),
                                      AppColors.blueSecondaryColor
                                          .withOpacity(0.04),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: AppColors.violetPrimaryColor
                                          .withOpacity(0.15)),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .violetPrimaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Icon(
                                                Icons.person_add_alt_1_rounded,
                                                size: 40,
                                                color: AppColors
                                                    .violetPrimaryColor,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: CustomText(
                                                text:
                                                    'Communication Preferences',
                                                fontWeight: FontWeight.bold,
                                                // fontSize: 17,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            const CustomText(
                                              text:
                                                  'Fill all required fields to add new lead',
                                              fontSize: 13,
                                              color: Colors.grey,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible:
                                              maxWidth > 1000 ? false : true,
                                          child: const SizedBox(height: 24)),
                                      Container(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .violetPrimaryColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Icon(
                                                      Icons
                                                          .notifications_active_rounded,
                                                      size: 20,
                                                      color: AppColors
                                                          .violetPrimaryColor),
                                                ),
                                                const SizedBox(width: 12),
                                                const Expanded(
                                                  child: CustomText(
                                                    maxline: true,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text:
                                                        'Communication Preferences',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Column(
                                              children: [
                                                EnhancedSwitchTile(
                                                  label: 'Send Greetings',
                                                  icon:
                                                      Icons.celebration_rounded,
                                                  value: _sendGreetings,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _sendGreetings = val),
                                                ),
                                                const SizedBox(height: 12),
                                                EnhancedSwitchTile(
                                                  label: 'Send Email Updates',
                                                  icon: Icons.email_rounded,
                                                  value: _sendEmail,
                                                  onChanged: (val) => setState(
                                                      () => _sendEmail = val),
                                                ),
                                                const SizedBox(height: 12),
                                                EnhancedSwitchTile(
                                                  label:
                                                      'WhatsApp Communication',
                                                  icon: Icons.chat_rounded,
                                                  value: _sendWhatsapp,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _sendWhatsapp = val),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
