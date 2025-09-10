import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/lead/lead_controller.dart';
import '../../../model/lead/lead_model.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});
  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final configController = Get.find<ConfigController>();
  final officersController = Get.find<OfficersController>();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  // Form controllers
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
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

  // Form values
  String? _selectedService = 'MIGRATION';
  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedPhoneCtry = "+91";
  String? _selectedAltPhoneCtry = "+91";
  String? _selectedWAPhoneCtry = "+91";
  String? _selectedLeadSource;
  String? _selectedQualification;
  String? _selectedCourse;
  String? _selectedAgent;
  bool _onCallCommunication = false;
  List<String> selectedCountries = [];
  List<String>? _selectedSpecialized;
  String? _selectedProfession;
  // Preferences
  bool _phoneCommunication = true;
  bool _sendEmail = false;
  bool _sendWhatsapp = false;

  @override
  void initState() {
    super.initState();
    _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Focus on the name field when the dialog opens
      await officersController.fetchOfficersList();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _leadDateController.dispose();
    _mobileOptionalController.dispose();
    _locationController.dispose();
    _qualificationController.dispose();
    _courseNameController.dispose();
    _remarksController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
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
                  // Header Section
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
                  // Form Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main Form
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
                                        controller: _scrollController,
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          controller: _scrollController,
                                          padding: const EdgeInsets.all(24),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              final availableWidth =
                                                  constraints.maxWidth;
                                              int columnsCount =
                                                  availableWidth > 1000
                                                      ? 3
                                                      : availableWidth > 600
                                                          ? 2
                                                          : 1;

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SectionTitle(
                                                      title: 'Primary Details',
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
                                                        showCountryCode: true,
                                                        label: 'Mobile Number',
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
                                                      CustomDropdownField(
                                                        label: 'Job Category',
                                                        isRequired: true,
                                                        value:
                                                            _selectedLeadSource,
                                                        items: configController
                                                                .configData
                                                                .value
                                                                .jobCategory
                                                                ?.map((e) =>
                                                                    e.name ??
                                                                    "")
                                                                .toList() ??
                                                            [],
                                                        onChanged: (val) =>
                                                            setState(() =>
                                                                _selectedProfession =
                                                                    val),
                                                      ),
                                                      CustomCheckDropdown(
                                                        label:
                                                            "Country Interested",
                                                        items: configController
                                                                .configData
                                                                .value
                                                                .country
                                                                ?.map((e) =>
                                                                    e.name ??
                                                                    "")
                                                                .toList() ??
                                                            [],
                                                        values: [],
                                                        onChanged: (value) {
                                                          selectedCountries =
                                                              value.cast<
                                                                  String>();
                                                        },
                                                      ),
                                                      CustomDropdownField(
                                                        label: 'Lead Source',
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
                                                      CustomOfficerDropDown(
                                                        label: 'Assigned To',
                                                        value: _selectedAgent,
                                                        items:
                                                            officersController
                                                                .officersList
                                                                .map((e) =>
                                                                    e.name ??
                                                                    "")
                                                                .toList(),
                                                        onChanged: (p0) {
                                                          _selectedAgent = p0
                                                                  ?.split(",")
                                                                  .last ??
                                                              "";
                                                        },
                                                        // isRequired: true,
                                                        isSplit: true,
                                                        // prefixIcon:
                                                        //     Icons.person,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const SectionTitle(
                                                      title:
                                                          'Professional Details',
                                                      icon: Icons
                                                          .person_outline_rounded),
                                                  const SizedBox(height: 20),
                                                  ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        CustomCheckDropdown(
                                                          label: 'Specialized',
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
                                                        CustomTextFormField(
                                                          controller:
                                                              _skillController,
                                                          label: 'Skills',
                                                        ),
                                                        CustomDropdownField(
                                                          label: 'Education',
                                                          value:
                                                              _selectedQualification,
                                                          items: configController
                                                                  .configData
                                                                  .value
                                                                  .programType
                                                                  ?.map((e) =>
                                                                      e.name ??
                                                                      "")
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
                                                        CustomDropdownField(
                                                          label:
                                                              'Education Program',
                                                          value:
                                                              _selectedCourse,
                                                          items: configController
                                                                  .configData
                                                                  .value
                                                                  .program
                                                                  ?.map((e) =>
                                                                      e.name ??
                                                                      "")
                                                                  .toList() ??
                                                              [],
                                                          onChanged:
                                                              (String? val) {
                                                            setState(() {
                                                              _selectedCourse =
                                                                  val;
                                                            });
                                                          },
                                                        ),
                                                      ]),
                                                  const SizedBox(height: 20),
                                                  const SectionTitle(
                                                      title: 'Personal Details',
                                                      icon: Icons
                                                          .person_outline_rounded),
                                                  const SizedBox(height: 20),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
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
                                                        isEmail: true,
                                                      ),
                                                      CustomDateField(
                                                        label: 'DOB',
                                                        controller:
                                                            _dobController,
                                                        endDate: DateTime.now()
                                                            .subtract(
                                                          const Duration(
                                                              days: 365 * 18),
                                                        ),
                                                        // initialDate:
                                                        //     DateTime.now()
                                                        //         .subtract(
                                                        //   const Duration(
                                                        //       days: 365 * 18),
                                                        // ),
                                                        isRequired: false,
                                                        onChanged:
                                                            (formattedDate) {
                                                          _dobController.text =
                                                              formattedDate;
                                                        },
                                                      ),
                                                      CustomPhoneField(
                                                        label:
                                                            'Alternate Mobile',
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
                                                        value: _selectedGender,
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
                                                      CustomDropdownField(
                                                        label: 'Marital Status',
                                                        value:
                                                            _selectedMaritalStatus,
                                                        items: const [
                                                          'Single',
                                                          'Married'
                                                        ],
                                                        onChanged: (val) =>
                                                            setState(() =>
                                                                _selectedMaritalStatus =
                                                                    val),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 32),
                                                  // Education Details Section

                                                  // Location Details Section
                                                  const SectionTitle(
                                                      title: 'Location Details',
                                                      icon: Icons
                                                          .location_on_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomTextFormField(
                                                        label: 'Address',
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
                                                    ],
                                                  ),
                                                  // Communication Preferences (for small screens)
                                                  if (maxWidth <= 1000) ...[
                                                    const SizedBox(height: 32),
                                                    const SectionTitle(
                                                        title:
                                                            'Communication Preference',
                                                        icon: Icons
                                                            .person_outline_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        EnhancedSwitchTile(
                                                          label:
                                                              ' Phone Communication',
                                                          icon: Icons
                                                              .phone_rounded,
                                                          value:
                                                              _phoneCommunication,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _phoneCommunication =
                                                                      val),
                                                        ),
                                                        EnhancedSwitchTile(
                                                          label:
                                                              'Email Communication',
                                                          icon: Icons
                                                              .email_rounded,
                                                          value: _sendEmail,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _sendEmail =
                                                                      val),
                                                        ),
                                                        EnhancedSwitchTile(
                                                          label:
                                                              'WhatsApp Communication',
                                                          icon: Icons
                                                              .chat_rounded,
                                                          value: _sendWhatsapp,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _sendWhatsapp =
                                                                      val),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  const SizedBox(height: 16),
                                                  // Additional Information
                                                  const SectionTitle(
                                                      title:
                                                          'Additional Information',
                                                      icon: Icons.note_rounded),
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
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Form Buttons
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
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
                                                  showLoaderDialog(context);
                                                  await Get.find<
                                                          LeadController>()
                                                      .createLead(
                                                    context,
                                                    LeadModel(
                                                      countryCode:
                                                          _selectedPhoneCtry ??
                                                              '',
                                                      name: _nameController.text
                                                          .trim(),
                                                      email: _emailController
                                                          .text
                                                          .trim(),
                                                      phone: _mobileController
                                                          .text
                                                          .trim(),
                                                      alternatePhone:
                                                          _mobileOptionalController
                                                                      .text
                                                                      .trim() !=
                                                                  ""
                                                              ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
                                                                  .trim()
                                                              : "",
                                                      whatsapp: _waMobileController
                                                                  .text
                                                                  .trim() !=
                                                              ""
                                                          ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}"
                                                              .trim()
                                                          : "",
                                                      gender:
                                                          _selectedGender ?? "",
                                                      dob: _dobController.text
                                                              .trim() ??
                                                          "",
                                                      maritalStatus:
                                                          _selectedMaritalStatus ??
                                                              '',
                                                      address:
                                                          _locationController
                                                              .text
                                                              .trim(),
                                                      city: _cityController.text
                                                          .trim(),
                                                      state: _stateController
                                                          .text
                                                          .trim(),
                                                      country:
                                                          _countryController
                                                              .text
                                                              .trim(),
                                                      jobInterests: [],
                                                      countryInterested:
                                                          selectedCountries ??
                                                              [],
                                                      expectedSalary: 0,
                                                      qualification:
                                                          _selectedCourse ?? "",
                                                      experience: 0,
                                                      skills: _skillController
                                                                  .text !=
                                                              ''
                                                          ? [
                                                              _skillController
                                                                  .text
                                                                  .trim()
                                                            ]
                                                          : [],
                                                      profession:
                                                          _selectedProfession,
                                                      specializedIn:
                                                          _selectedSpecialized ??
                                                              [],
                                                      leadSource:
                                                          _selectedLeadSource ??
                                                              "",
                                                      onCallCommunication:
                                                          _onCallCommunication,
                                                      onWhatsappCommunication:
                                                          _sendWhatsapp,
                                                      onEmailCommunication:
                                                          _sendEmail,
                                                      status: "HOT",
                                                      serviceType:
                                                          _selectedService ??
                                                              "",
                                                      branch: "AFFINIX",
                                                      note: _remarksController
                                                          .text
                                                          .trim(),
                                                    ),
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            // Side Panel (visible only on large screens)
                            if (maxWidth > 1000)
                              Container(
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
                                                  label:
                                                      'On call Communication',
                                                  icon: Icons.call,
                                                  value: _onCallCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _onCallCommunication =
                                                              val),
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
