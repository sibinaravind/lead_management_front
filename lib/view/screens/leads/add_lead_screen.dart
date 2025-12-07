import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/model/lead/academic_record_model.dart';
import 'package:overseas_front_end/model/lead/exam_record_model.dart';
import 'package:overseas_front_end/model/lead/travel_record_model.dart';
import 'package:overseas_front_end/model/lead/work_record_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../controller/lead/lead_controller.dart';
import '../../../model/lead/lead_model.dart';
import '../../widgets/delete_confirm_dialog.dart';

class AddLeadScreen extends StatefulWidget {
  final LeadModel? leadToEdit;
  const AddLeadScreen({super.key, this.leadToEdit});
  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen>
    with SingleTickerProviderStateMixin {
  final leadController = Get.find<LeadController>();
  final configController = Get.find<ConfigController>();
  final officersController = Get.find<OfficersController>();
  final _formKey = GlobalKey<FormState>();
  late ScrollController _scrollController;
  late TabController _tabController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _waMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileOptionalController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _preferredLocationController =
      TextEditingController();
  final TextEditingController _preferredDateController =
      TextEditingController();
  final TextEditingController _sourceCampaignController =
      TextEditingController();
  final TextEditingController _expectedSalaryController =
      TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _specializedInController =
      TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _annualIncomeController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _creditScoreController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _emailPasswordController =
      TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _passportExpiryController =
      TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _jobGapController = TextEditingController();
  final TextEditingController _firstJobDateController = TextEditingController();
  final TextEditingController _idProofNumber = TextEditingController();
  String? selectedIdProofType;
  // Form values - Primary Data
  String? _selectedService = 'LEAD';
  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedPhoneCtry = "+91";
  String? _selectedAltPhoneCtry = "+91";
  String? _selectedWAPhoneCtry = "+91";
  String? _selectedLeadSource;
  String? _selectedStatus = "NEW";
  // String? _selectedBranch;
  String? _selectedOfficer;
  String? _selectedEmploymentStatus;
  String? _selectedBirthCountry;
  // Communication preferences
  bool _onCallCommunication = false;
  bool _phoneCommunication = true;
  bool _emailCommunication = false;
  bool _whatsappCommunication = false;
  // Loan related
  bool _loanRequired = false;
  bool _hasExistingLoans = false;
  final TextEditingController _loanAmountController = TextEditingController();
  // Lists and arrays
  List<String> _selectedInterestedIn = [];
  List<String> _selectedCountriesInterested = [];
  List<String> _selectedVisitedCountries = [];
  List<String> _selectedCoursesInterested = [];
  // Academic Records
  final List<AcademicRecordModel> _academicRecords = [];
  // Exam Records
  final List<ExamRecordModel> _examRecords = [];
  // Travel Records
  final List<TravelRecordModel> _travelRecords = [];
  // Work Records
  final List<WorkRecordModel> _workRecords = [];
  // Travel Preferences
  String? _selectedTravelPurpose;
  String? _selectedVisaTypeRequired;
  String? _selectedAccommodationPreference;
  final TextEditingController _travelDurationController =
      TextEditingController();
  final TextEditingController _numberOfTravelersController =
      TextEditingController();
  bool _requiresTravelInsurance = false;
  bool _requiresHotelBooking = false;
  bool _requiresFlightBooking = false;
  // Education Preferences
  String? _selectedPreferredStudyMode;
  String? _selectedBatchPreference;
  String? _selectedHighestQualification;

  String? _selectedHeightQualification;
  final TextEditingController _yearOfPassingController =
      TextEditingController();

  // Migration Preferences
  String? _selectedTargetVisaType;
  bool _hasRelativesAbroad = false;
  bool _requiresJobAssistance = false;
  final TextEditingController _relativeCountryController =
      TextEditingController();
  final TextEditingController _relativeRelationController =
      TextEditingController();
  final TextEditingController _preferredSettlementCityController =
      TextEditingController();

  final TextEditingController _leadDateController = TextEditingController();
  // Vehicle Preferences
  String? _selectedVehicleType;
  String? _selectedBrandPreference;

  String? _selectedFuelType;
  String? _selectedTransmission;
  String? _selectedInsuranceType;
  final TextEditingController _modelPreferenceController =
      TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();

  // Property Preferences
  String? _selectedPropertyType;
  String? _selectedPropertyUse;
  String? _selectedFurnishingPreference;
  bool _requiresHomeLoan = false;
  bool _requiresLegalAssistance = false;
  final TextEditingController _loanAmountRealEstateController =
      TextEditingController();
  final TextEditingController _possessionTimelineController =
      TextEditingController();

  // Group Details
  String? _selectedGroupType;
  final TextEditingController _totalPeoplesController = TextEditingController();
  List<Widget> tabs = [
    Tab(text: 'Primary Data', icon: Icon(Icons.person, size: 16)),
    Tab(
        text: 'Financial & Professional',
        icon: Icon(Icons.business_center, size: 16)),
    Tab(text: 'Documents', icon: Icon(Icons.folder, size: 16)),
    Tab(text: 'Education', icon: Icon(Icons.school, size: 16)),
    Tab(text: 'Travel', icon: Icon(Icons.flight, size: 16)),
    Tab(text: 'Migration', icon: Icon(Icons.public, size: 16)),
    Tab(text: 'Real Estate', icon: Icon(Icons.home, size: 16)),
    Tab(text: 'Vehicle', icon: Icon(Icons.directions_car, size: 16)),
    Tab(text: 'Other', icon: Icon(Icons.more_horiz, size: 16)),
  ];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: tabs.length, vsync: this);
    _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    // _preferredDateController.text = DateFormat("yyyy-MM-dd")
    //     .format(DateTime.now().add(const Duration(days: 30)));
    // _passportExpiryController.text = DateFormat("dd/MM/yyyy")
    //     .format(DateTime.now().add(const Duration(days: 365 * 5)));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await officersController.fetchOfficersList();
      FocusScope.of(context).requestFocus(FocusNode());
    });
    populateLeadData(widget.leadToEdit);
  }

  // If editing, populate controllers and fields with existing data
  void populateLeadData(LeadModel? lead) {
    if (lead == null) return;
    _nameController.text = lead.name ?? '';
    _emailController.text = lead.email ?? '';
    _mobileController.text = lead.phone ?? '';
    _selectedPhoneCtry = lead.countryCode ?? '+91';
    // Split country code and number for alternatePhone
    if (lead.alternatePhone != null && lead.alternatePhone!.isNotEmpty) {
      final altParts = lead.alternatePhone!.split(' ');
      if (altParts.length > 1) {
        _selectedAltPhoneCtry = altParts.first;
        _mobileOptionalController.text = altParts.sublist(1).join(' ');
      } else {
        _mobileOptionalController.text = lead.alternatePhone!;
      }
    } else {
      _mobileOptionalController.text = '';
    }

    // Split country code and number for whatsapp
    if (lead.whatsapp != null && lead.whatsapp!.isNotEmpty) {
      final waParts = lead.whatsapp!.split(' ');
      if (waParts.length > 1) {
        _selectedWAPhoneCtry = waParts.first;
        _waMobileController.text = waParts.sublist(1).join(' ');
      } else {
        _waMobileController.text = lead.whatsapp!;
      }
    } else {
      _waMobileController.text = '';
    }
    _selectedOfficer = lead.officerId;
    _selectedGender = lead.gender;
    _dobController.text = lead.dob ?? '';
    _selectedMaritalStatus = lead.maritalStatus;
    _selectedService = lead.serviceType;
    _addressController.text = lead.address ?? '';
    _cityController.text = lead.city ?? '';
    _stateController.text = lead.state ?? '';
    _countryController.text = lead.country ?? '';
    _pincodeController.text = lead.pincode ?? '';
    _selectedLeadSource = lead.leadSource;
    _sourceCampaignController.text = lead.sourceCampaign ?? '';
    _selectedStatus = lead.status;
    // _selectedBranch = lead.branch;
    _noteController.text = lead.note ?? '';
    _selectedInterestedIn = List<String>.from(lead.interestedIn ?? []);
    _feedbackController.text = lead.feedback ?? '';
    _selectedCountriesInterested =
        List<String>.from(lead.countryInterested ?? []);
    _expectedSalaryController.text = lead.expectedSalary?.toString() ?? '';
    _fieldOfStudyController.text = lead.qualification ?? '';
    _experienceController.text = lead.experience?.toString() ?? '';
    _skillsController.text = lead.skills ?? '';
    _professionController.text = lead.profession ?? '';
    _specializedInController.text = lead.specializedIn ?? '';
    _selectedEmploymentStatus = lead.employmentStatus;
    _annualIncomeController.text = lead.annualIncome?.toString() ?? '';
    _panCardController.text = lead.panCardNumber ?? '';
    _gstController.text = lead.gstNumber ?? '';
    _hasExistingLoans = lead.hasExistingLoans ?? false;
    _creditScoreController.text = lead.creditScore?.toString() ?? '';
    _firstJobDateController.text = lead.firstJobDate ?? '';
    _selectedBirthCountry = lead.birthCountry;
    _birthPlaceController.text = lead.birthPlace ?? '';
    _emailPasswordController.text = lead.emailPassword ?? '';
    _emergencyContactController.text = lead.emergencyContact ?? '';
    _passportNumberController.text = lead.passportNumber ?? '';
    _passportExpiryController.text = lead.passportExpiryDate ?? '';
    _religionController.text = lead.religion ?? '';
    _jobGapController.text = lead.jobGapMonths?.toString() ?? '';
    _academicRecords.clear();
    if (lead.academicRecords != null)
      _academicRecords.addAll(lead.academicRecords!);
    _examRecords.clear();
    if (lead.examRecords != null) _examRecords.addAll(lead.examRecords!);
    _travelRecords.clear();
    if (lead.travelRecords != null) _travelRecords.addAll(lead.travelRecords!);
    _workRecords.clear();
    if (lead.workRecords != null) _workRecords.addAll(lead.workRecords!);
    _selectedTravelPurpose = lead.travelPurpose;
    _numberOfTravelersController.text =
        lead.numberOfTravelers?.toString() ?? '';
    _selectedAccommodationPreference = lead.accommodationPreference;
    _selectedVisitedCountries = List<String>.from(lead.visitedCountries ?? []);
    _selectedVisaTypeRequired = lead.visaTypeRequired;
    _travelDurationController.text = lead.travelDuration?.toString() ?? '';
    _requiresTravelInsurance = lead.requiresTravelInsurance ?? false;
    _requiresHotelBooking = lead.requiresHotelBooking ?? false;
    _requiresFlightBooking = lead.requiresFlightBooking ?? false;
    _selectedPreferredStudyMode = lead.preferredStudyMode;
    _selectedBatchPreference = lead.batchPreference;
    _selectedHighestQualification = lead.highestQualification;
    _yearOfPassingController.text = lead.yearOfPassing?.toString() ?? '';
    _selectedHeightQualification = lead.fieldOfStudy;
    _selectedCoursesInterested =
        List<String>.from(lead.coursesInterested ?? []);
    _selectedTargetVisaType = lead.targetVisaType;
    _hasRelativesAbroad = lead.hasRelativesAbroad ?? false;
    _relativeCountryController.text = lead.relativeCountry ?? '';
    _relativeRelationController.text = lead.relativeRelation ?? '';
    _requiresJobAssistance = lead.requiresJobAssistance ?? false;
    _preferredSettlementCityController.text =
        lead.preferredSettlementCity ?? '';
    _selectedVehicleType = lead.vehicleType;
    // _selectedBranch = lead.bra ?? '';
    _modelPreferenceController.text = lead.modelPreference ?? '';
    _selectedFuelType = lead.fuelType;
    _selectedTransmission = lead.transmission;
    _downPaymentController.text = lead.downPaymentAvailable?.toString() ?? '';
    _selectedInsuranceType = lead.insuranceType;
    _selectedPropertyType = lead.propertyType;
    _selectedPropertyUse = lead.propertyUse;
    _requiresHomeLoan = lead.requiresHomeLoan ?? false;
    _loanAmountRealEstateController.text =
        lead.loanAmountRequiredRealEstate?.toString() ?? '';
    _possessionTimelineController.text = lead.possessionTimeline ?? '';
    _selectedFurnishingPreference = lead.furnishingPreference;
    _requiresLegalAssistance = lead.requiresLegalAssistance ?? false;
    _loanRequired = lead.loanRequired ?? false;
    _loanAmountController.text = lead.loanAmountRequired?.toString() ?? '';
    _onCallCommunication = lead.onCallCommunication ?? false;
    _phoneCommunication = lead.phoneCommunication ?? true;
    _emailCommunication = lead.emailCommunication ?? false;
    _whatsappCommunication = lead.whatsappCommunication ?? false;
    _selectedOfficer = lead.officerId;
    _budgetController.text = lead.budget?.toString() ?? '';
    _preferredLocationController.text = lead.preferredLocation ?? '';
    _preferredDateController.text = lead.preferredDate ?? '';
    _totalPeoplesController.text = lead.totalPeoples ?? '';
    _selectedGroupType = lead.groupType;
    _selectedBrandPreference = lead.brandPreference;
    selectedIdProofType = lead.idProofType;
    _idProofNumber.text = lead.idProofNumber ?? '';
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _leadDateController.dispose();
    _mobileOptionalController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    _dobController.dispose();
    _noteController.dispose();
    _feedbackController.dispose();
    _budgetController.dispose();
    _preferredLocationController.dispose();
    _preferredDateController.dispose();
    _sourceCampaignController.dispose();
    _loanAmountController.dispose();
    _expectedSalaryController.dispose();
    _fieldOfStudyController.dispose();
    _skillsController.dispose();
    _professionController.dispose();
    _experienceController.dispose();
    _annualIncomeController.dispose();
    _panCardController.dispose();
    _gstController.dispose();
    _creditScoreController.dispose();
    _birthPlaceController.dispose();
    _emailPasswordController.dispose();
    _emergencyContactController.dispose();
    _passportNumberController.dispose();
    _passportExpiryController.dispose();
    _religionController.dispose();
    _jobGapController.dispose();
    _firstJobDateController.dispose();
    _travelDurationController.dispose();
    _numberOfTravelersController.dispose();
    _yearOfPassingController.dispose();
    _relativeCountryController.dispose();
    _relativeRelationController.dispose();
    _preferredSettlementCityController.dispose();
    _modelPreferenceController.dispose();
    _downPaymentController.dispose();
    _loanAmountRealEstateController.dispose();
    _possessionTimelineController.dispose();
    _totalPeoplesController.dispose();
    _idProofNumber.dispose();
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
                  // Tab Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primaryColor,
                      tabs: tabs,
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
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          // Tab 1: Primary Data
                                          _buildPrimaryDataTab(context),
                                          // Tab 2: Professional Details
                                          _buildProfessionalTab(context),
                                          // Tab 3: Documents & Records
                                          _buildDocumentsTab(context),
                                          // Tab 4: Education Details
                                          _buildEducationTab(context),
                                          // Tab 5: Travel Preferences
                                          _buildTravelTab(context),
                                          // Tab 6: Migration Details
                                          _buildMigrationTab(context),
                                          // Tab 7: Real Estate & Vehicle
                                          _buildRealEstateTab(context),
                                          // Tab 7: Real Estate & Vehicle
                                          _buildVehicleTab(context),

                                          // Tab 8: Other Details
                                          _buildOtherTab(context),
                                        ],
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
                                                  await _saveLeadData();
                                                } else {
                                                  CustomSnackBar.show(context,
                                                      "Validaton failed \n Please Check the form fields",
                                                      backgroundColor: AppColors
                                                          .redSecondaryColor);
                                                }
                                                // Navigator.pop(context);
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
                            // Side Panel
                            if (maxWidth > 1000)
                              Container(
                                width: MediaQuery.of(context).size.width * .2,
                                decoration: BoxDecoration(
                                  gradient: AppColors.blueBoxGradient,
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
                                                        .violetPrimaryColor,
                                                  ),
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
                                                      'On Call Communication',
                                                  icon: Icons.call,
                                                  value: _onCallCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _onCallCommunication =
                                                              val),
                                                ),
                                                const SizedBox(height: 12),
                                                EnhancedSwitchTile(
                                                  label:
                                                      'Text Message Communication',
                                                  icon: Icons.message_rounded,
                                                  value: _phoneCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _phoneCommunication =
                                                              val),
                                                ),
                                                const SizedBox(height: 12),
                                                EnhancedSwitchTile(
                                                  label: 'Email Communication',
                                                  icon: Icons.email_rounded,
                                                  value: _emailCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _emailCommunication =
                                                              val),
                                                ),
                                                const SizedBox(height: 12),
                                                EnhancedSwitchTile(
                                                  label:
                                                      'WhatsApp Communication',
                                                  icon: Icons.chat_rounded,
                                                  value: _whatsappCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _whatsappCommunication =
                                                              val),
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

  // Primary Data Tab
  Widget _buildPrimaryDataTab(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          int columnsCount = availableWidth > 1000
              ? 3
              : availableWidth > 600
                  ? 2
                  : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Personal Information',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Full Name',
                    controller: _nameController,
                    isRequired: true,
                  ),
                  CustomPhoneField(
                    showCountryCode: true,
                    label: 'Mobile Number',
                    controller: _mobileController,
                    selectedCountry: _selectedPhoneCtry,
                    onCountryChanged: (val) =>
                        setState(() => _selectedPhoneCtry = val),
                    isRequired: true,
                  ),
                  CustomTextFormField(
                    label: 'Email',
                    controller: _emailController,
                    isEmail: true,
                  ),
                  CustomPhoneField(
                    label: 'Alternate Phone',
                    controller: _mobileOptionalController,
                    selectedCountry: _selectedAltPhoneCtry,
                    onCountryChanged: (val) =>
                        setState(() => _selectedAltPhoneCtry = val),
                  ),
                  CustomPhoneField(
                    label: 'Whatsapp Number',
                    controller: _waMobileController,
                    selectedCountry: _selectedWAPhoneCtry,
                    onCountryChanged: (val) =>
                        setState(() => _selectedWAPhoneCtry = val),
                  ),
                  CustomDropdownField(
                    label: 'Gender',
                    value: _selectedGender,
                    items: const ['Male', 'Female', 'Other'],
                    onChanged: (val) => setState(() => _selectedGender = val),
                  ),
                  CustomDateField(
                    label: 'Date of Birth',
                    controller: _dobController,
                    endDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _dobController.text = formattedDate;
                    },
                  ),
                  CustomDropdownField(
                    label: 'Marital Status',
                    value: _selectedMaritalStatus,
                    items: [
                      'Single',
                      'Married',
                      'Divorced',
                      'Widowed',
                      'Separated'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedMaritalStatus = val),
                  ),
                  CustomDropdownField(
                    label: 'Religion',
                    value: _religionController.text,
                    items: const [
                      'Hinduism',
                      'Islam',
                      'Christianity',
                      'Sikhism',
                      'Buddhism',
                      'Jainism',
                      'Other'
                    ],
                    onChanged: (val) =>
                        setState(() => _religionController.text = val ?? ''),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Lead Information',
                icon: Icons.leaderboard_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  // CustomDropdownField(
                  //   label: 'Service Type',
                  //   isRequired: true,
                  //   value: _selectedService,
                  //   items: const [
                  //     'LEAD',
                  //     'TRAVEL',
                  //     'MIGRATION',
                  //     'EDUCATION',
                  //     'REAL_ESTATE',
                  //     'VEHICLE'
                  //   ],
                  //   onChanged: (val) => setState(() => _selectedService = val),
                  // ),

                  CustomDropdownField(
                    label: 'Lead Source',
                    value: _selectedLeadSource,
                    items: configController.configData.value.leadSource
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        ['Website', 'Referral', 'Walk-in', 'Social Media'],
                    onChanged: (val) =>
                        setState(() => _selectedLeadSource = val),
                  ),
                  CustomTextFormField(
                    label: 'Source Campaign',
                    controller: _sourceCampaignController,
                  ),
                  CustomDropdownField(
                    label: 'Status',
                    value: _selectedStatus,
                    items: configController.configData.value.clientStatus
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        [
                          'NEW',
                          'CONTACTED',
                          'QUALIFIED',
                          'PROPOSAL',
                          'NEGOTIATION',
                          'WON',
                          'LOST'
                        ],
                    onChanged: (val) => setState(() => _selectedStatus = val),
                  ),
                  // CustomDropdownField(
                  //   label: 'Branch',
                  //   value: _selectedBranch,
                  //   items: const [
                  //     'Bangalore HQ',
                  //     'Delhi Office',
                  //     'Mumbai Office',
                  //     'Chennai Office'
                  //   ],
                  //   onChanged: (val) => setState(() => _selectedBranch = val),
                  // ),
                  CustomOfficerDropDown(
                    label: 'Assigned Officer',
                    selectedOfficerId: _selectedOfficer,
                    officers: officersController.officersList,
                    onChanged: (value) {
                      _selectedOfficer = value?.split(",").last.trim() ?? "";
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Budget & Preferences',
                icon: Icons.attach_money_rounded,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  int columnsCount = availableWidth > 1000
                      ? 3
                      : availableWidth > 600
                          ? 2
                          : 1;

                  return ResponsiveGrid(
                    columns: columnsCount,
                    children: [
                      CustomCheckDropdown(
                        label: "Interested In",
                        items: configController.configData.value.serviceType
                                ?.map((e) => e.name ?? "")
                                .toList() ??
                            [],
                        values: _selectedInterestedIn,
                        onChanged: (value) {
                          setState(() {
                            _selectedInterestedIn = value.cast<String>();
                          });
                        },
                      ),
                      CustomTextFormField(
                        label: 'Budget',
                        controller: _budgetController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.currency_rupee_rounded,
                      ),
                      CustomCheckDropdown(
                        label: "Country Interested",
                        items: configController.configData.value.country
                                ?.map((e) => e.name ?? "")
                                .toList() ??
                            [
                              'Canada',
                              'Australia',
                              'USA',
                              'UK',
                              'India',
                              'Germany',
                              'France'
                            ],
                        values: _selectedCountriesInterested,
                        onChanged: (value) {
                          setState(() {
                            _selectedCountriesInterested = value.cast<String>();
                          });
                        },
                      ),
                      CustomTextFormField(
                        label: 'Preferred Location',
                        controller: _preferredLocationController,
                      ),
                      CustomDateField(
                        label: 'Preferred Date',
                        controller: _preferredDateController,
                        initialDate: DateTime.now(),
                        onChanged: (formattedDate) {
                          _preferredDateController.text = formattedDate;
                        },
                      ),
                      CustomTextFormField(
                        label: 'Total Peoples',
                        controller: _totalPeoplesController,
                        keyboardType: TextInputType.number,
                      ),
                      CustomDropdownField(
                        label: 'Group Type',
                        value: _selectedGroupType,
                        items: const [
                          'Family',
                          'Friends',
                          'Couple',
                          'Solo',
                          'Corporate',
                          'Other'
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedGroupType = val),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              const SectionTitle(
                title: 'Location Details',
                icon: Icons.location_on_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Address',
                    controller: _addressController,
                  ),
                  CustomTextFormField(
                    label: 'City',
                    controller: _cityController,
                  ),
                  CustomTextFormField(
                    label: 'State',
                    controller: _stateController,
                  ),
                  CustomTextFormField(
                    label: 'Country',
                    controller: _countryController,
                  ),
                  CustomTextFormField(
                    label: 'Pincode',
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomDropdownField(
                    label: 'Birth Country',
                    value: _selectedBirthCountry,
                    items: configController.configData.value.country
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        ['India', 'USA', 'UK', 'Canada', 'Australia'],
                    onChanged: (val) =>
                        setState(() => _selectedBirthCountry = val),
                  ),
                  CustomTextFormField(
                    label: 'Birth Place',
                    controller: _birthPlaceController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Emergency Contact',
                icon: Icons.emergency_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Emergency Contact',
                    controller: _emergencyContactController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Additional Information',
                icon: Icons.note_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: 1,
                children: [
                  CustomTextFormField(
                    label: 'Notes',
                    controller: _noteController,
                    maxLines: 3,
                    hintText: 'e.g., Client asked about Europe trip packages.',
                  ),
                  CustomTextFormField(
                    label: 'Feedback',
                    controller: _feedbackController,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  // Professional Details Tab
  Widget _buildProfessionalTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          int columnsCount = availableWidth > 1000
              ? 3
              : availableWidth > 600
                  ? 2
                  : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Professional Information',
                icon: Icons.business_center_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Profession',
                    controller: _professionController,
                  ),
                  CustomTextFormField(
                    label: 'Annual Income',
                    controller: _annualIncomeController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.currency_rupee_rounded,
                  ),
                  CustomTextFormField(
                    label: 'Expected Salary',
                    controller: _expectedSalaryController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.currency_rupee_rounded,
                  ),
                  CustomDropdownField(
                    label: 'Employment Status',
                    value: _selectedEmploymentStatus,
                    items: const [
                      'Employed',
                      'Unemployed',
                      'Self-Employed',
                      'Student',
                      'Retired'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedEmploymentStatus = val),
                  ),
                  CustomTextFormField(
                    label: 'Experience (years)',
                    controller: _experienceController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    label: 'Job Gap (months)',
                    controller: _jobGapController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomDateField(
                    label: 'First Job Date',
                    controller: _firstJobDateController,
                    endDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _firstJobDateController.text = formattedDate;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Skills & Specialization',
                icon: Icons.engineering_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Skills',
                    controller: _skillsController,
                  ),
                  CustomTextFormField(
                    label: 'Specialized In',
                    controller: _specializedInController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Financial Information',
                icon: Icons.monetization_on_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  EnhancedSwitchTile(
                    label: 'Loan Required',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _loanRequired,
                    onChanged: (val) => setState(() => _loanRequired = val),
                  ),
                  if (_loanRequired)
                    CustomTextFormField(
                      label: 'Loan Amount Required',
                      controller: _loanAmountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.currency_rupee_rounded,
                    ),
                  EnhancedSwitchTile(
                    label: 'Has Existing Loans',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _hasExistingLoans,
                    onChanged: (val) => setState(() => _hasExistingLoans = val),
                  ),
                  CustomTextFormField(
                    label: 'Credit Score',
                    controller: _creditScoreController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  // Documents & Records Tab
  Widget _buildDocumentsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'ID Information',
            icon: Icons.book_online_rounded,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              int columnsCount = availableWidth > 1000
                  ? 3
                  : availableWidth > 600
                      ? 2
                      : 1;

              return ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'ID Proof Type',
                    value: selectedIdProofType,
                    items: const [
                      'Aadhaar Card',
                      'Passport',
                      'Voter ID',
                      'Driving License',
                      'PAN Card',
                      'Other'
                    ],
                    onChanged: (val) =>
                        setState(() => selectedIdProofType = val),
                  ),
                  CustomTextFormField(
                    label: 'ID Proof Number',
                    controller: _idProofNumber,
                  ),
                  CustomTextFormField(
                    label: 'Passport Number',
                    controller: _passportNumberController,
                  ),
                  CustomDateField(
                    label: 'Passport Expiry Date',
                    controller: _passportExpiryController,
                    initialDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _passportExpiryController.text = formattedDate;
                    },
                  ),
                  CustomTextFormField(
                    label: 'PAN Card Number',
                    controller: _panCardController,
                  ),
                  CustomTextFormField(
                    label: 'GST Number',
                    controller: _gstController,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Academic Records',
            icon: Icons.school_rounded,
          ),
          const SizedBox(height: 16),
          ..._academicRecords.asMap().entries.map((entry) {
            int index = entry.key;
            AcademicRecordModel record = entry.value;
            return _buildAcademicRecordCard(index, record);
          }).toList(),
          CustomActionButton(
            text: 'Add Academic Record',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _academicRecords.add(AcademicRecordModel());
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Work Records',
            icon: Icons.work_rounded,
          ),
          const SizedBox(height: 16),
          ..._workRecords.asMap().entries.map((entry) {
            int index = entry.key;
            WorkRecordModel record = entry.value;
            return _buildWorkRecordCard(index, record);
          }).toList(),
          CustomActionButton(
            text: 'Add Work Record',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _workRecords.add(WorkRecordModel());
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Travel Records',
            icon: Icons.flight_takeoff_rounded,
          ),
          const SizedBox(height: 16),
          ..._travelRecords.asMap().entries.map((entry) {
            int index = entry.key;
            TravelRecordModel record = entry.value;
            return _buildTravelRecordCard(index, record);
          }).toList(),
          CustomActionButton(
            text: 'Add Travel Record',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _travelRecords.add(TravelRecordModel());
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Exam Records',
            icon: Icons.assignment_rounded,
          ),
          const SizedBox(height: 16),
          ..._examRecords.asMap().entries.map((entry) {
            int index = entry.key;
            ExamRecordModel record = entry.value;
            return _buildExamRecordCard(index, record);
          }).toList(),
          CustomActionButton(
            text: 'Add Exam Record',
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _examRecords.add(ExamRecordModel());
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            textColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // // Education Tab
  Widget _buildEducationTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          int columnsCount = availableWidth > 1000
              ? 3
              : availableWidth > 600
                  ? 2
                  : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Educational Background',
                icon: Icons.school_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'Highest Qualification',
                    value: _selectedHeightQualification,
                    items: configController.configData.value.courseType
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        const ['PG', 'UG'],
                    onChanged: (val) =>
                        setState(() => _selectedHeightQualification = val),
                  ),
                  CustomTextFormField(
                    label: 'Field of Study',
                    controller: _fieldOfStudyController,
                  ),
                  CustomTextFormField(
                    label: 'Year of Passing',
                    controller: _yearOfPassingController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Courses Interested',
                icon: Icons.menu_book_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomCheckDropdown(
                    label: "Courses Interested",
                    items: configController.configData.value.courses
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        [
                          'MBA',
                          'MS Computer Science',
                          'BBA',
                          'BE Mechanical',
                          'MBBS',
                          'BA Economics'
                        ],
                    values: _selectedCoursesInterested,
                    onChanged: (value) {
                      setState(() {
                        _selectedCoursesInterested = value.cast<String>();
                      });
                    },
                  ),
                  CustomDropdownField(
                    label: 'Preferred Study Mode',
                    value: _selectedPreferredStudyMode,
                    items: const ['Online', 'Offline', 'Hybrid'],
                    onChanged: (val) =>
                        setState(() => _selectedPreferredStudyMode = val),
                  ),
                  CustomDropdownField(
                    label: 'Batch Preference',
                    value: _selectedBatchPreference,
                    items: const ['Morning', 'Afternoon', 'Evening', 'Weekend'],
                    onChanged: (val) =>
                        setState(() => _selectedBatchPreference = val),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  // Travel Tab
  Widget _buildTravelTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          int columnsCount = availableWidth > 1000
              ? 3
              : availableWidth > 600
                  ? 2
                  : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Travel Preferences',
                icon: Icons.flight_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'Travel Purpose',
                    value: _selectedTravelPurpose,
                    items: const [
                      'Holiday',
                      'Business',
                      'Education',
                      'Medical',
                      'Family Visit'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedTravelPurpose = val),
                  ),
                  CustomDropdownField(
                    label: 'Visa Type Required',
                    value: _selectedVisaTypeRequired,
                    items: const [
                      'Tourist',
                      'Business',
                      'Student',
                      'Work',
                      'Transit'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedVisaTypeRequired = val),
                  ),
                  CustomTextFormField(
                    label: 'Number of Travelers',
                    controller: _numberOfTravelersController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    label: 'Travel Duration (days)',
                    controller: _travelDurationController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomDropdownField(
                    label: 'Accommodation Preference',
                    value: _selectedAccommodationPreference,
                    items: const [
                      'Hotel',
                      'Apartment',
                      'Hostel',
                      'Resort',
                      'Homestay'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedAccommodationPreference = val),
                  ),
                  CustomCheckDropdown(
                    label: "Country Interested",
                    items: configController.configData.value.country
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        [
                          'Canada',
                          'Australia',
                          'USA',
                          'UK',
                          'India',
                          'Germany',
                          'France'
                        ],
                    values: _selectedCountriesInterested,
                    onChanged: (value) {
                      setState(() {
                        _selectedCountriesInterested = value.cast<String>();
                      });
                    },
                  ),
                  CustomDropdownField(
                    label: 'Group Type',
                    value: _selectedGroupType,
                    items: const [
                      'Family',
                      'Friends',
                      'Couple',
                      'Solo',
                      'Corporate',
                      'Other'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedGroupType = val),
                  ),
                  CustomTextFormField(
                    label: 'Total Peoples',
                    controller: _totalPeoplesController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    label: 'Preferred Location',
                    controller: _preferredLocationController,
                  ),
                  CustomDateField(
                    label: 'Preferred Date',
                    controller: _preferredDateController,
                    initialDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _preferredDateController.text = formattedDate;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: 'Travel Services',
                icon: Icons.confirmation_number_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  EnhancedSwitchTile(
                    label: 'Requires Travel Insurance',
                    icon: Icons.security_rounded,
                    value: _requiresTravelInsurance,
                    onChanged: (val) =>
                        setState(() => _requiresTravelInsurance = val),
                  ),
                  EnhancedSwitchTile(
                    label: 'Requires Hotel Booking',
                    icon: Icons.hotel_rounded,
                    value: _requiresHotelBooking,
                    onChanged: (val) =>
                        setState(() => _requiresHotelBooking = val),
                  ),
                  EnhancedSwitchTile(
                    label: 'Requires Flight Booking',
                    icon: Icons.flight_takeoff_rounded,
                    value: _requiresFlightBooking,
                    onChanged: (val) =>
                        setState(() => _requiresFlightBooking = val),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  // Migration Tab
  Widget _buildMigrationTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          int columnsCount = availableWidth > 1000
              ? 3
              : availableWidth > 600
                  ? 2
                  : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Migration Preferences',
                icon: Icons.public_rounded,
              ),
              const SizedBox(height: 16),
              ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'Target Visa Type',
                    value: _selectedTargetVisaType,
                    items: const [
                      'Work Visa',
                      'Student Visa',
                      'Permanent Residency',
                      'Business Visa',
                      'Family Visa'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedTargetVisaType = val),
                  ),
                  CustomCheckDropdown(
                    label: "Country Interested",
                    items: configController.configData.value.country
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        [
                          'Canada',
                          'Australia',
                          'USA',
                          'UK',
                          'India',
                          'Germany',
                          'France'
                        ],
                    values: _selectedCountriesInterested,
                    onChanged: (value) {
                      setState(() {
                        _selectedCountriesInterested = value.cast<String>();
                      });
                    },
                  ),
                  CustomTextFormField(
                    label: 'Preferred Location',
                    controller: _preferredLocationController,
                  ),
                  CustomDateField(
                    label: 'Preferred Date',
                    controller: _preferredDateController,
                    initialDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _preferredDateController.text = formattedDate;
                    },
                  ),
                  EnhancedSwitchTile(
                    margin: const EdgeInsets.only(top: 15),
                    label: 'Has Relatives Abroad',
                    icon: Icons.family_restroom_rounded,
                    value: _hasRelativesAbroad,
                    onChanged: (val) =>
                        setState(() => _hasRelativesAbroad = val),
                  ),
                  if (_hasRelativesAbroad) ...[
                    CustomTextFormField(
                      label: 'Relative Country',
                      controller: _relativeCountryController,
                    ),
                    CustomTextFormField(
                      label: 'Relative Relation',
                      controller: _relativeRelationController,
                    ),
                  ],
                  EnhancedSwitchTile(
                    margin: const EdgeInsets.only(top: 15),
                    label: 'Requires Job Assistance',
                    icon: Icons.work_rounded,
                    value: _requiresJobAssistance,
                    onChanged: (val) =>
                        setState(() => _requiresJobAssistance = val),
                  ),
                  EnhancedSwitchTile(
                    margin: const EdgeInsets.only(top: 15),
                    label: 'Requires Flight Booking',
                    icon: Icons.flight_takeoff_rounded,
                    value: _requiresFlightBooking,
                    onChanged: (val) =>
                        setState(() => _requiresFlightBooking = val),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  // Real Estate & Vehicle Tab
  Widget _buildVehicleTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Vehicle Preferences',
            icon: Icons.directions_car_rounded,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              int columnsCount = availableWidth > 1000
                  ? 3
                  : availableWidth > 600
                      ? 2
                      : 1;

              return ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'Vehicle Type',
                    value: _selectedVehicleType,
                    items: configController.configData.value.vehicleType
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        ['Car', 'Bike', 'Scooter', 'SUV', 'Truck'],
                    onChanged: (val) =>
                        setState(() => _selectedVehicleType = val),
                  ),
                  CustomDropdownField(
                    label: 'Brand Preference',
                    value: _selectedBrandPreference,
                    items: configController.configData.value.vehicleBrand
                            ?.map((e) => e.name ?? "")
                            .toList() ??
                        ['Toyota', 'Honda', 'Ford', 'BMW', 'Audi'],
                    onChanged: (val) =>
                        setState(() => _selectedBrandPreference = val),
                  ),
                  CustomTextFormField(
                    label: 'Model Preference',
                    controller: _modelPreferenceController,
                  ),
                  CustomDropdownField(
                    label: 'Fuel Type',
                    value: _selectedFuelType,
                    items: const [
                      'Petrol',
                      'Diesel',
                      'Electric',
                      'Hybrid',
                      'CNG'
                    ],
                    onChanged: (val) => setState(() => _selectedFuelType = val),
                  ),
                  CustomDropdownField(
                    label: 'Transmission',
                    value: _selectedTransmission,
                    items: const ['Automatic', 'Manual'],
                    onChanged: (val) =>
                        setState(() => _selectedTransmission = val),
                  ),
                  CustomDropdownField(
                    label: 'Insurance Type',
                    value: _selectedInsuranceType,
                    items: const [
                      'Comprehensive',
                      'Third Party',
                      'Zero Depreciation'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedInsuranceType = val),
                  ),
                  CustomTextFormField(
                    label: 'Down Payment Available',
                    controller: _downPaymentController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.currency_rupee_rounded,
                  ),
                  EnhancedSwitchTile(
                    label: 'Loan Required',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _loanRequired,
                    onChanged: (val) => setState(() => _loanRequired = val),
                  ),
                  if (_loanRequired)
                    CustomTextFormField(
                      label: 'Loan Amount Required',
                      controller: _loanAmountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.currency_rupee_rounded,
                    ),
                  EnhancedSwitchTile(
                    label: 'Has Existing Loans',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _hasExistingLoans,
                    onChanged: (val) => setState(() => _hasExistingLoans = val),
                  ),
                  CustomTextFormField(
                    label: 'Credit Score',
                    controller: _creditScoreController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Real Estate & Vehicle Tab
  Widget _buildRealEstateTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Real Estate Preferences',
            icon: Icons.home_work_rounded,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              int columnsCount = availableWidth > 1000
                  ? 3
                  : availableWidth > 600
                      ? 2
                      : 1;

              return ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomDropdownField(
                    label: 'Property Type',
                    value: _selectedPropertyType,
                    items: const [
                      'Apartment',
                      'Villa',
                      'Plot',
                      'Commercial',
                      'Farm House'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedPropertyType = val),
                  ),
                  CustomDropdownField(
                    label: 'Property Use',
                    value: _selectedPropertyUse,
                    items: const [
                      'Residential',
                      'Commercial',
                      'Investment',
                      'Rental'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedPropertyUse = val),
                  ),
                  CustomDropdownField(
                    label: 'Furnishing Preference',
                    value: _selectedFurnishingPreference,
                    items: const [
                      'Fully Furnished',
                      'Semi-Furnished',
                      'Unfurnished'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedFurnishingPreference = val),
                  ),
                  CustomDropdownField(
                    label: 'Group Type',
                    value: _selectedGroupType,
                    items: const [
                      'Family',
                      'Friends',
                      'Couple',
                      'Solo',
                      'Corporate',
                      'Other'
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedGroupType = val),
                  ),
                  CustomTextFormField(
                    label: 'Total Peoples',
                    controller: _totalPeoplesController,
                    keyboardType: TextInputType.number,
                  ),
                  EnhancedSwitchTile(
                    label: 'Loan Required',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _loanRequired,
                    onChanged: (val) => setState(() => _loanRequired = val),
                  ),
                  if (_loanRequired)
                    CustomTextFormField(
                      label: 'Loan Amount Required',
                      controller: _loanAmountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.currency_rupee_rounded,
                    ),
                  EnhancedSwitchTile(
                    label: 'Has Existing Loans',
                    margin: const EdgeInsets.only(top: 15),
                    icon: Icons.money_rounded,
                    value: _hasExistingLoans,
                    onChanged: (val) => setState(() => _hasExistingLoans = val),
                  ),
                  CustomTextFormField(
                    label: 'Credit Score',
                    controller: _creditScoreController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomDateField(
                    label: 'Possession Timeline',
                    controller: _possessionTimelineController,
                    initialDate: DateTime.now(),
                    onChanged: (formattedDate) {
                      _possessionTimelineController.text = formattedDate;
                    },
                  ),
                  EnhancedSwitchTile(
                    label: 'Requires Legal Assistance',
                    icon: Icons.gavel_rounded,
                    value: _requiresLegalAssistance,
                    onChanged: (val) =>
                        setState(() => _requiresLegalAssistance = val),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Other Tab
  Widget _buildOtherTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Login Credentials',
            icon: Icons.security_rounded,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              int columnsCount = availableWidth > 1000
                  ? 3
                  : availableWidth > 600
                      ? 2
                      : 1;

              return ResponsiveGrid(
                columns: columnsCount,
                children: [
                  CustomTextFormField(
                    label: 'Email',
                    controller: _emailController,
                    isEmail: true,
                  ),
                  CustomTextFormField(
                    label: 'Email Password',
                    controller: _emailPasswordController,
                    obscureText: false,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Helper Widgets for Records
  Widget _buildAcademicRecordCard(int index, AcademicRecordModel record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Academic Record ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteConfirmationDialog(
                        title: "Delete",
                        message:
                            'Are you sure you want to delete this academic record?',
                        onConfirm: () async {
                          setState(() {
                            _academicRecords.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                int columnsCount = availableWidth > 800
                    ? 3
                    : availableWidth > 500
                        ? 2
                        : 1;

                return ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    CustomTextFormField(
                      label: 'Qualification',
                      controller:
                          TextEditingController(text: record.qualification),
                      onChanged: (value) {
                        _academicRecords[index].qualification = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Institution',
                      controller:
                          TextEditingController(text: record.institution),
                      onChanged: (value) {
                        _academicRecords[index].institution = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Year of Passing',
                      controller: TextEditingController(
                          text: record.yearOfPassing?.toString()),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _academicRecords[index].yearOfPassing =
                            int.tryParse(value);
                      },
                    ),
                    CustomTextFormField(
                      label: 'Percentage / CGPA',
                      controller: TextEditingController(
                          text: record.percentage?.toString()),
                      onChanged: (value) {
                        _academicRecords[index].percentage =
                            double.tryParse(value);
                      },
                    ),
                    CustomTextFormField(
                      label: 'Board',
                      controller: TextEditingController(text: record.board),
                      onChanged: (value) {
                        _academicRecords[index].board = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      controller:
                          TextEditingController(text: record.description),
                      maxLines: 2,
                      onChanged: (value) {
                        _academicRecords[index].description = value;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkRecordCard(int index, WorkRecordModel record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Work Record ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _workRecords.removeAt(index);
                    });
                  },
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                int columnsCount = availableWidth > 800
                    ? 3
                    : availableWidth > 500
                        ? 2
                        : 1;

                return ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    CustomTextFormField(
                      label: 'Company',
                      value: record.company,
                      onChanged: (value) {
                        _workRecords[index].company = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Position',
                      value: record.position,
                      onChanged: (value) {
                        _workRecords[index].position = value;
                      },
                    ),
                    CustomDateField(
                      label: 'Start Date',
                      controller: TextEditingController(text: record.startDate),
                      initialDate: DateTime(1970),
                      focusDate: DateTime.now(),
                      endDate: DateTime.now(),
                      onChanged: (value) {
                        _workRecords[index].startDate = value;
                      },
                    ),
                    CustomDateField(
                      label: 'End Date',
                      controller: TextEditingController(text: record.endDate),
                      initialDate: DateTime(1970),
                      focusDate: DateTime.now(),
                      endDate: DateTime.now().add(Duration(days: 365 * 1)),
                      onChanged: (value) {
                        _workRecords[index].endDate = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      value: record.description,
                      maxLines: 2,
                      onChanged: (value) {
                        _workRecords[index].description = value;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelRecordCard(int index, TravelRecordModel record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Travel Record ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _travelRecords.removeAt(index);
                    });
                  },
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                int columnsCount = availableWidth > 800
                    ? 3
                    : availableWidth > 500
                        ? 2
                        : 1;

                return ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    CustomTextFormField(
                      label: 'Country',
                      value: record.country,
                      onChanged: (value) {
                        _travelRecords[index].country = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Purpose',
                      value: record.purpose,
                      onChanged: (value) {
                        _travelRecords[index].purpose = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Duration',
                      value: record.duration,
                      onChanged: (value) {
                        _travelRecords[index].duration = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Year',
                      value: record.year?.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _travelRecords[index].year = int.tryParse(value);
                      },
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      value: record.description,
                      maxLines: 2,
                      onChanged: (value) {
                        _travelRecords[index].description = value;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamRecordCard(int index, ExamRecordModel record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exam Record ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _examRecords.removeAt(index);
                    });
                  },
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                int columnsCount = availableWidth > 800
                    ? 3
                    : availableWidth > 500
                        ? 2
                        : 1;

                return ResponsiveGrid(
                  columns: columnsCount,
                  children: [
                    CustomTextFormField(
                      label: 'Exam Name',
                      value: record.examName,
                      onChanged: (value) {
                        _examRecords[index].examName = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Score',
                      value: record.score?.toString(),
                      // keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _examRecords[index].score = double.tryParse(value);
                      },
                    ),
                    CustomDateField(
                      label: 'Test Date',
                      controller: TextEditingController(text: record.testDate),
                      initialDate: DateTime(2000),
                      endDate: DateTime.now(),
                      onChanged: (value) {
                        _examRecords[index].testDate = value;
                      },
                    ),
                    CustomDateField(
                      label: 'Validity',
                      controller: TextEditingController(text: record.validity),
                      initialDate: DateTime.now(),
                      onChanged: (value) {
                        _examRecords[index].validity = value;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      value: record.description,
                      maxLines: 2,
                      onChanged: (value) {
                        _examRecords[index].description = value;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveLeadData() async {
    // showLoaderDialog(context);
    LeadModel leadToSave = LeadModel(
      // Primary Data
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _mobileController.text.trim(),
      countryCode: _selectedPhoneCtry ?? '+91',
      alternatePhone: _mobileOptionalController.text.trim().isNotEmpty
          ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
              .trim()
          : "",
      whatsapp: _waMobileController.text.trim().isNotEmpty
          ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}".trim()
          : "",
      gender: _selectedGender ?? "",
      dob: _dobController.text.trim(),
      maritalStatus: _selectedMaritalStatus ?? '',
      serviceType: _selectedService ?? 'LEAD',
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      country: _countryController.text.trim(),
      pincode: _pincodeController.text.trim(),
      leadSource: _selectedLeadSource ?? "",
      sourceCampaign: _sourceCampaignController.text.trim(),
      status: _selectedStatus ?? "NEW",
      // branch: _selectedBranch ?? "",
      note: _noteController.text.trim(),
      interestedIn: _selectedInterestedIn,
      feedback: _feedbackController.text.trim(),
      // Professional Details
      countryInterested: _selectedCountriesInterested,
      expectedSalary: _expectedSalaryController.text.trim().isNotEmpty
          ? int.tryParse(_expectedSalaryController.text.trim())
          : null,
      qualification: _fieldOfStudyController.text.trim(),
      experience: _experienceController.text.trim().isNotEmpty
          ? int.tryParse(_experienceController.text.trim())
          : null,
      skills: _skillsController.text.trim(),
      profession: _professionController.text.trim(),
      specializedIn: _specializedInController.text.trim(),
      employmentStatus: _selectedEmploymentStatus,
      annualIncome: _annualIncomeController.text.trim().isNotEmpty
          ? int.tryParse(_annualIncomeController.text.trim())
          : null,
      panCardNumber: _panCardController.text.trim(),
      gstNumber: _gstController.text.trim(),
      hasExistingLoans: _hasExistingLoans,
      creditScore: _creditScoreController.text.trim().isNotEmpty
          ? int.tryParse(_creditScoreController.text.trim())
          : null,
      firstJobDate: _firstJobDateController.text.trim(),
      // Personal Details
      birthCountry: _selectedBirthCountry,
      birthPlace: _birthPlaceController.text.trim(),
      emailPassword: _emailPasswordController.text.trim(),
      emergencyContact: _emergencyContactController.text.trim(),
      passportNumber: _passportNumberController.text.trim(),
      passportExpiryDate: _passportExpiryController.text.trim(),
      religion: _religionController.text.trim(),
      jobGapMonths: _jobGapController.text.trim().isNotEmpty
          ? int.tryParse(_jobGapController.text.trim())
          : null,
      // Records
      academicRecords: _academicRecords,
      examRecords: _examRecords,
      travelRecords: _travelRecords,
      workRecords: _workRecords,
      // Travel Preferences
      travelPurpose: _selectedTravelPurpose,
      numberOfTravelers: _numberOfTravelersController.text.trim().isNotEmpty
          ? int.tryParse(_numberOfTravelersController.text.trim())
          : null,
      accommodationPreference: _selectedAccommodationPreference,
      visitedCountries: _selectedVisitedCountries,
      visaTypeRequired: _selectedVisaTypeRequired,
      travelDuration: _travelDurationController.text.trim().isNotEmpty
          ? int.tryParse(_travelDurationController.text.trim())
          : null,
      requiresTravelInsurance: _requiresTravelInsurance,
      requiresHotelBooking: _requiresHotelBooking,
      requiresFlightBooking: _requiresFlightBooking,

      // Education Preferences
      preferredStudyMode: _selectedPreferredStudyMode,
      batchPreference: _selectedBatchPreference,
      highestQualification: _fieldOfStudyController.text.trim(),
      yearOfPassing: _yearOfPassingController.text.trim().isNotEmpty
          ? int.tryParse(_yearOfPassingController.text.trim())
          : null,
      fieldOfStudy: _selectedHeightQualification,
      // percentageOrCgpa: _percentageController.text.trim(),
      coursesInterested: _selectedCoursesInterested,

      // Migration Preferences
      targetVisaType: _selectedTargetVisaType,
      hasRelativesAbroad: _hasRelativesAbroad,
      relativeCountry: _relativeCountryController.text.trim(),
      relativeRelation: _relativeRelationController.text.trim(),
      requiresJobAssistance: _requiresJobAssistance,
      preferredSettlementCity: _preferredSettlementCityController.text.trim(),

      // Vehicle Preferences
      vehicleType: _selectedVehicleType,
      brandPreference: _selectedBrandPreference,
      modelPreference: _modelPreferenceController.text.trim(),
      fuelType: _selectedFuelType,
      transmission: _selectedTransmission,
      downPaymentAvailable: _downPaymentController.text.trim().isNotEmpty
          ? int.tryParse(_downPaymentController.text.trim())
          : null,
      insuranceType: _selectedInsuranceType,

      // Property Preferences
      propertyType: _selectedPropertyType,
      propertyUse: _selectedPropertyUse,
      requiresHomeLoan: _requiresHomeLoan,
      loanAmountRequiredRealEstate:
          _loanAmountRealEstateController.text.trim().isNotEmpty
              ? int.tryParse(_loanAmountRealEstateController.text.trim())
              : null,
      possessionTimeline: _possessionTimelineController.text.trim(),
      furnishingPreference: _selectedFurnishingPreference,
      requiresLegalAssistance: _requiresLegalAssistance,

      // Other Details
      loanRequired: _loanRequired,
      loanAmountRequired: _loanAmountController.text.trim().isNotEmpty
          ? int.tryParse(_loanAmountController.text.trim())
          : null,
      onCallCommunication: _onCallCommunication,
      phoneCommunication: _phoneCommunication,
      emailCommunication: _emailCommunication,
      whatsappCommunication: _whatsappCommunication,
      officerId: _selectedOfficer ?? "",
      // productInterested: productsList,
      budget: _budgetController.text.trim().isNotEmpty
          ? int.tryParse(_budgetController.text.trim())
          : null,
      preferredLocation: _preferredLocationController.text.trim(),
      preferredDate: _preferredDateController.text.trim(),
      totalPeoples: _totalPeoplesController.text.trim(),
      groupType: _selectedGroupType,
      idProofType: selectedIdProofType,
      idProofNumber: _idProofNumber.text.trim(),
    );
    if (widget.leadToEdit?.id != null) {
      showLoaderDialog(context);
      await Get.find<LeadController>().updateLead(
        context,
        leadToSave,
        widget.leadToEdit?.id ?? "",
      );
    } else {
      showLoaderDialog(context);
      await Get.find<LeadController>().createLead(
        context,
        leadToSave,
      );
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/model/lead/academic_record_model.dart';
// import 'package:overseas_front_end/model/lead/exam_record_model.dart';
// import 'package:overseas_front_end/model/lead/travel_record_model.dart';
// import 'package:overseas_front_end/model/lead/work_record_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import '../../../controller/lead/lead_controller.dart';
// import '../../../model/lead/lead_model.dart';

// class AddLeadScreen extends StatefulWidget {
//   const AddLeadScreen({super.key});
//   @override
//   State<AddLeadScreen> createState() => _AddLeadScreenState();
// }

// class _AddLeadScreenState extends State<AddLeadScreen>
//     with SingleTickerProviderStateMixin {
//   final leadController = Get.find<LeadController>();
//   final configController = Get.find<ConfigController>();
//   final officersController = Get.find<OfficersController>();
//   final _formKey = GlobalKey<FormState>();
//   late ScrollController _scrollController;
//   late TabController _tabController;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _waMobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileOptionalController =
//       TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();
//   final TextEditingController _feedbackController = TextEditingController();
//   final TextEditingController _budgetController = TextEditingController();
//   final TextEditingController _preferredLocationController =
//       TextEditingController();
//   final TextEditingController _preferredDateController =
//       TextEditingController();
//   final TextEditingController _sourceCampaignController =
//       TextEditingController();
//   final TextEditingController _expectedSalaryController =
//       TextEditingController();
//   final TextEditingController _fieldOfStudyController =
//       TextEditingController();
//   final TextEditingController _skillsController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();
//   final TextEditingController _experienceController = TextEditingController();
//   final TextEditingController _annualIncomeController = TextEditingController();
//   final TextEditingController _panCardController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _creditScoreController = TextEditingController();
//   final TextEditingController _birthPlaceController = TextEditingController();
//   final TextEditingController _emailPasswordController =
//       TextEditingController();
//   final TextEditingController _emergencyContactController =
//       TextEditingController();
//   final TextEditingController _passportNumberController =
//       TextEditingController();
//   final TextEditingController _passportExpiryController =
//       TextEditingController();
//   final TextEditingController _religionController = TextEditingController();
//   final TextEditingController _jobGapController = TextEditingController();
//   final TextEditingController _firstJobDateController = TextEditingController();

//   // Form values - Primary Data
//   String? _selectedService = 'LEAD';
//   String? _selectedGender;
//   String? _selectedMaritalStatus;
//   String? _selectedPhoneCtry = "+91";
//   String? _selectedAltPhoneCtry = "+91";
//   String? _selectedWAPhoneCtry = "+91";
//   String? _selectedLeadSource;
//   String? _selectedStatus = "NEW";
//   String? _selectedBranch;
//   String? _selectedOfficer;
//   String? _selectedEmploymentStatus;
//   String? _selectedBirthCountry;
//   // Communication preferences
//   bool _onCallCommunication = false;
//   bool _phoneCommunication = true;
//   bool _emailCommunication = false;
//   bool _whatsappCommunication = false;
//   // Loan related
//   bool _loanRequired = false;
//   bool _hasExistingLoans = false;
//   final TextEditingController _loanAmountController = TextEditingController();
//   // Lists and arrays
//   List<String> _selectedInterestedIn = [];
//   List<String> _selectedCountriesInterested = [];
//   List<String> _selectedSkills = [];
//   List<String> _selectedSpecializedIn = [];
//   List<String> _selectedVisitedCountries = [];
//   List<String> _selectedCoursesInterested = [];
//   // Academic Records
//   final List<AcademicRecordModel> _academicRecords = [];
//   // Exam Records
//   final List<ExamRecordModel> _examRecords = [];
//   // Travel Records
//   final List<TravelRecordModel> _travelRecords = [];
//   // Work Records
//   final List<WorkRecordModel> _workRecords = [];
//   // Travel Preferences
//   String? _selectedTravelPurpose;
//   String? _selectedVisaTypeRequired;
//   String? _selectedAccommodationPreference;
//   final TextEditingController _travelDurationController =
//       TextEditingController();
//   final TextEditingController _numberOfTravelersController =
//       TextEditingController();
//   bool _requiresTravelInsurance = false;
//   bool _requiresHotelBooking = false;
//   bool _requiresFlightBooking = false;
//   // Education Preferences
//   String? _selectedPreferredStudyMode;
//   String? _selectedBatchPreference;
//   String? _selectedHighestQualification;

//   String? _selectedHeightQualification;
//   final TextEditingController _yearOfPassingController =
//       TextEditingController();
//   final TextEditingController _percentageController = TextEditingController();

//   // Migration Preferences
//   String? _selectedTargetVisaType;
//   bool _hasRelativesAbroad = false;
//   bool _requiresJobAssistance = false;
//   final TextEditingController _relativeCountryController =
//       TextEditingController();
//   final TextEditingController _relativeRelationController =
//       TextEditingController();
//   final TextEditingController _preferredSettlementCityController =
//       TextEditingController();

//   final TextEditingController _leadDateController = TextEditingController();
//   // Vehicle Preferences
//   String? _selectedVehicleType;
//   final TextEditingController _selectedBrandPreference =
//       TextEditingController();
//   String? _selectedFuelType;
//   String? _selectedTransmission;
//   String? _selectedInsuranceType;
//   final TextEditingController _modelPreferenceController =
//       TextEditingController();
//   final TextEditingController _downPaymentController = TextEditingController();

//   // Property Preferences
//   String? _selectedPropertyType;
//   String? _selectedPropertyUse;
//   String? _selectedFurnishingPreference;
//   bool _requiresHomeLoan = false;
//   bool _requiresLegalAssistance = false;
//   final TextEditingController _loanAmountRealEstateController =
//       TextEditingController();
//   final TextEditingController _possessionTimelineController =
//       TextEditingController();

//   // Group Details
//   String? _selectedGroupType;
//   final TextEditingController _totalPeoplesController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _tabController = TabController(length: 8, vsync: this);
//     _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
//     _preferredDateController.text = DateFormat("yyyy-MM-dd")
//         .format(DateTime.now().add(const Duration(days: 30)));
//     _passportExpiryController.text = DateFormat("dd/MM/yyyy")
//         .format(DateTime.now().add(const Duration(days: 365 * 5)));
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await officersController.fetchOfficersList();
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _leadDateController.dispose();
//     _mobileOptionalController.dispose();
//     _addressController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _countryController.dispose();
//     _pincodeController.dispose();
//     _dobController.dispose();
//     _noteController.dispose();
//     _feedbackController.dispose();
//     _budgetController.dispose();
//     _preferredLocationController.dispose();
//     _preferredDateController.dispose();
//     _sourceCampaignController.dispose();
//     _loanAmountController.dispose();
//     _expectedSalaryController.dispose();
//     _fieldOfStudyController.dispose();
//     _skillsController.dispose();
//     _professionController.dispose();
//     _experienceController.dispose();
//     _annualIncomeController.dispose();
//     _panCardController.dispose();
//     _gstController.dispose();
//     _creditScoreController.dispose();
//     _birthPlaceController.dispose();
//     _emailPasswordController.dispose();
//     _emergencyContactController.dispose();
//     _passportNumberController.dispose();
//     _passportExpiryController.dispose();
//     _religionController.dispose();
//     _jobGapController.dispose();
//     _firstJobDateController.dispose();
//     _travelDurationController.dispose();
//     _numberOfTravelersController.dispose();
//     _yearOfPassingController.dispose();
//     _percentageController.dispose();
//     _relativeCountryController.dispose();
//     _relativeRelationController.dispose();
//     _preferredSettlementCityController.dispose();
//     _modelPreferenceController.dispose();
//     _downPaymentController.dispose();
//     _loanAmountRealEstateController.dispose();
//     _possessionTimelineController.dispose();
//     _totalPeoplesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1600,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Header Section
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.leaderboard_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: 'Add New Lead',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: 'Capture lead details for follow up',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Tab Bar
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade50,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade200),
//                       ),
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       isScrollable: true,
//                       labelColor: AppColors.primaryColor,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: AppColors.primaryColor,
//                       tabs: const [
//                         Tab(
//                             text: 'Primary Data',
//                             icon: Icon(Icons.person, size: 16)),
//                         Tab(
//                             text: 'Professional',
//                             icon: Icon(Icons.business_center, size: 16)),
//                         Tab(
//                             text: 'Documents',
//                             icon: Icon(Icons.folder, size: 16)),
//                         Tab(
//                             text: 'Education',
//                             icon: Icon(Icons.school, size: 16)),
//                         Tab(text: 'Travel', icon: Icon(Icons.flight, size: 16)),
//                         Tab(
//                             text: 'Migration',
//                             icon: Icon(Icons.public, size: 16)),
//                         Tab(
//                             text: 'Real Estate',
//                             icon: Icon(Icons.home, size: 16)),
//                         Tab(
//                             text: 'Other',
//                             icon: Icon(Icons.more_horiz, size: 16)),
//                       ],
//                     ),
//                   ),
//                   // Form Content
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Main Form
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: TabBarView(
//                                         controller: _tabController,
//                                         children: [
//                                           // Tab 1: Primary Data
//                                           _buildPrimaryDataTab(context),
//                                           // Tab 2: Professional Details
//                                           _buildProfessionalTab(context),
//                                           // Tab 3: Documents & Records
//                                           _buildDocumentsTab(context),
//                                           // Tab 4: Education Details
//                                           _buildEducationTab(context),
//                                           // Tab 5: Travel Preferences
//                                           _buildTravelTab(context),
//                                           // Tab 6: Migration Details
//                                           _buildMigrationTab(context),
//                                           // Tab 7: Real Estate & Vehicle
//                                           _buildRealEstateTab(context),
//                                           // Tab 8: Other Details
//                                           _buildOtherTab(context),
//                                         ],
//                                       ),
//                                     ),
//                                     // Form Buttons
//                                     Padding(
//                                       padding: const EdgeInsets.all(16),
//                                       child: Row(
//                                         children: [
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: CustomActionButton(
//                                               text: 'Cancel',
//                                               icon: Icons.close_rounded,
//                                               textColor: Colors.grey,
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               borderColor: Colors.grey.shade300,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             flex: 2,
//                                             child: CustomActionButton(
//                                               text: 'Save Lead',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: () async {
//                                                 if (_formKey.currentState!
//                                                     .validate()) {
//                                                   showLoaderDialog(context);
//                                                   await _saveLeadData();
//                                                 }
//                                                 Navigator.pop(context);
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 24),
//                             // Side Panel
//                             if (maxWidth > 1000)
//                               Container(
//                                 width: MediaQuery.of(context).size.width * .2,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: [
//                                       AppColors.violetPrimaryColor
//                                           .withOpacity(0.08),
//                                       AppColors.blueSecondaryColor
//                                           .withOpacity(0.04),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                       color: AppColors.violetPrimaryColor
//                                           .withOpacity(0.15)),
//                                 ),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(24),
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(16),
//                                               decoration: BoxDecoration(
//                                                 color: AppColors
//                                                     .violetPrimaryColor
//                                                     .withOpacity(0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Icon(
//                                                 Icons.person_add_alt_1_rounded,
//                                                 size: 40,
//                                                 color: AppColors
//                                                     .violetPrimaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             const FittedBox(
//                                               fit: BoxFit.scaleDown,
//                                               child: CustomText(
//                                                 text:
//                                                     'Communication Preferences',
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             const CustomText(
//                                               text:
//                                                   'Fill all required fields to add new lead',
//                                               fontSize: 13,
//                                               color: Colors.grey,
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(24),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   padding:
//                                                       const EdgeInsets.all(8),
//                                                   decoration: BoxDecoration(
//                                                     color: AppColors
//                                                         .violetPrimaryColor
//                                                         .withOpacity(0.1),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                   child: Icon(
//                                                     Icons
//                                                         .notifications_active_rounded,
//                                                     size: 20,
//                                                     color: AppColors
//                                                         .violetPrimaryColor,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 12),
//                                                 const Expanded(
//                                                   child: CustomText(
//                                                     maxline: true,
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     text:
//                                                         'Communication Preferences',
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                     color:
//                                                         AppColors.primaryColor,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 20),
//                                             Column(
//                                               children: [
//                                                 EnhancedSwitchTile(
//                                                   label:
//                                                       'On Call Communication',
//                                                   icon: Icons.call,
//                                                   value: _onCallCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _onCallCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label: 'Phone Communication',
//                                                   icon: Icons.phone_rounded,
//                                                   value: _phoneCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _phoneCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label: 'Email Communication',
//                                                   icon: Icons.email_rounded,
//                                                   value: _emailCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _emailCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label:
//                                                       'WhatsApp Communication',
//                                                   icon: Icons.chat_rounded,
//                                                   value: _whatsappCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _whatsappCommunication =
//                                                               val),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Primary Data Tab
//   Widget _buildPrimaryDataTab(BuildContext context) {
//     return SingleChildScrollView(
//       controller: _scrollController,
//       padding: const EdgeInsets.all(24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableWidth = constraints.maxWidth;
//           int columnsCount = availableWidth > 1000
//               ? 3
//               : availableWidth > 600
//                   ? 2
//                   : 1;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                 title: 'Personal Information',
//                 icon: Icons.person_outline_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Full Name *',
//                     controller: _nameController,
//                     isRequired: true,
//                   ),
//                   CustomPhoneField(
//                     showCountryCode: true,
//                     label: 'Mobile Number *',
//                     controller: _mobileController,
//                     selectedCountry: _selectedPhoneCtry,
//                     onCountryChanged: (val) =>
//                         setState(() => _selectedPhoneCtry = val),
//                     isRequired: true,
//                   ),
//                   CustomTextFormField(
//                     label: 'Email',
//                     controller: _emailController,
//                     isEmail: true,
//                   ),
//                   CustomPhoneField(
//                     label: 'Alternate Phone',
//                     controller: _mobileOptionalController,
//                     selectedCountry: _selectedAltPhoneCtry,
//                     onCountryChanged: (val) =>
//                         setState(() => _selectedAltPhoneCtry = val),
//                   ),
//                   CustomPhoneField(
//                     label: 'Whatsapp Number',
//                     controller: _waMobileController,
//                     selectedCountry: _selectedWAPhoneCtry,
//                     onCountryChanged: (val) =>
//                         setState(() => _selectedWAPhoneCtry = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Gender',
//                     value: _selectedGender,
//                     items: const ['Male', 'Female', 'Other'],
//                     onChanged: (val) => setState(() => _selectedGender = val),
//                   ),
//                   CustomDateField(
//                     label: 'Date of Birth',
//                     controller: _dobController,
//                     endDate: DateTime.now(),
//                     onChanged: (formattedDate) {
//                       _dobController.text = formattedDate;
//                     },
//                   ),
//                   CustomDropdownField(
//                     label: 'Marital Status',
//                     value: _selectedMaritalStatus,
//                     items: const ['Single', 'Married'],
//                     onChanged: (val) =>
//                         setState(() => _selectedMaritalStatus = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Religion',
//                     value: _religionController.text,
//                     items: const [
//                       'Hinduism',
//                       'Islam',
//                       'Christianity',
//                       'Sikhism',
//                       'Buddhism',
//                       'Jainism',
//                       'Other'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _religionController.text = val ?? ''),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Location Details',
//                 icon: Icons.location_on_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Address',
//                     controller: _addressController,
//                   ),
//                   CustomTextFormField(
//                     label: 'City',
//                     controller: _cityController,
//                   ),
//                   CustomTextFormField(
//                     label: 'State',
//                     controller: _stateController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Country',
//                     controller: _countryController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Pincode',
//                     controller: _pincodeController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomDropdownField(
//                     label: 'Birth Country',
//                     value: _selectedBirthCountry,
//                     items: configController.configData.value.country
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         ['India', 'USA', 'UK', 'Canada', 'Australia'],
//                     onChanged: (val) =>
//                         setState(() => _selectedBirthCountry = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Birth Place',
//                     controller: _birthPlaceController,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Lead Information',
//                 icon: Icons.leaderboard_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Service Type',
//                     isRequired: true,
//                     value: _selectedService,
//                     items: const [
//                       'LEAD',
//                       'TRAVEL',
//                       'MIGRATION',
//                       'EDUCATION',
//                       'REAL_ESTATE',
//                       'VEHICLE'
//                     ],
//                     onChanged: (val) => setState(() => _selectedService = val),
//                   ),
//                   CustomCheckDropdown(
//                     label: "Interested In",
//                     items: const [
//                       'TRAVEL',
//                       'MIGRATION',
//                       'EDUCATION',
//                       'VISA',
//                       'REAL_ESTATE',
//                       'VEHICLE'
//                     ],
//                     values: _selectedInterestedIn,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedInterestedIn = value.cast<String>();
//                       });
//                     },
//                   ),
//                   CustomDropdownField(
//                     label: 'Lead Source',
//                     value: _selectedLeadSource,
//                     items: configController.configData.value.leadSource
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         ['Website', 'Referral', 'Walk-in', 'Social Media'],
//                     onChanged: (val) =>
//                         setState(() => _selectedLeadSource = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Source Campaign',
//                     controller: _sourceCampaignController,
//                   ),
//                   CustomDropdownField(
//                     label: 'Status',
//                     value: _selectedStatus,
//                     items: const [
//                       'NEW',
//                       'CONTACTED',
//                       'QUALIFIED',
//                       'PROPOSAL',
//                       'NEGOTIATION',
//                       'WON',
//                       'LOST'
//                     ],
//                     onChanged: (val) => setState(() => _selectedStatus = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Branch',
//                     value: _selectedBranch,
//                     items: const [
//                       'Bangalore HQ',
//                       'Delhi Office',
//                       'Mumbai Office',
//                       'Chennai Office'
//                     ],
//                     onChanged: (val) => setState(() => _selectedBranch = val),
//                   ),
//                   CustomOfficerDropDown(
//                     label: 'Assigned Officer',
//                     value: _selectedOfficer,
//                     items: officersController.officersList
//                         .map((e) => e.name ?? "")
//                         .toList(),
//                     onChanged: (value) {
//                       _selectedOfficer = value?.split(",").last ?? "";
//                     },
//                     isSplit: true,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Emergency Contact',
//                 icon: Icons.emergency_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Emergency Contact',
//                     controller: _emergencyContactController,
//                     hintText: 'Name - Phone Number',
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Additional Information',
//                 icon: Icons.note_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: 1,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Notes',
//                     controller: _noteController,
//                     maxLines: 3,
//                     hintText: 'e.g., Client asked about Europe trip packages.',
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     label: 'Feedback',
//                     controller: _feedbackController,
//                     maxLines: 2,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Professional Details Tab
//   Widget _buildProfessionalTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableWidth = constraints.maxWidth;
//           int columnsCount = availableWidth > 1000
//               ? 3
//               : availableWidth > 600
//                   ? 2
//                   : 1;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                 title: 'Professional Information',
//                 icon: Icons.business_center_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Profession',
//                     controller: _professionController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Expected Salary',
//                     controller: _expectedSalaryController,
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee_rounded,
//                   ),
//                   CustomTextFormField(
//                     label: 'Annual Income',
//                     controller: _annualIncomeController,
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee_rounded,
//                   ),
//                   CustomDropdownField(
//                     label: 'Employment Status',
//                     value: _selectedEmploymentStatus,
//                     items: const [
//                       'Employed',
//                       'Unemployed',
//                       'Self-Employed',
//                       'Student',
//                       'Retired'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedEmploymentStatus = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Experience (years)',
//                     controller: _experienceController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Job Gap (months)',
//                     controller: _jobGapController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomDateField(
//                     label: 'First Job Date',
//                     controller: _firstJobDateController,
//                     onChanged: (formattedDate) {
//                       _firstJobDateController.text = formattedDate;
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Skills & Specialization',
//                 icon: Icons.engineering_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomCheckDropdown(
//                     label: "Skills",
//                     items: const [
//                       'JavaScript',
//                       'Node.js',
//                       'Flutter',
//                       'React',
//                       'Python',
//                       'Java',
//                       'C++'
//                     ],
//                     values: _selectedSkills,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedSkills = value.cast<String>();
//                       });
//                     },
//                   ),
//                   CustomCheckDropdown(
//                     label: "Specialized In",
//                     items: const [
//                       'Full Stack Development',
//                       'Frontend',
//                       'Backend',
//                       'Mobile Development',
//                       'DevOps'
//                     ],
//                     values: _selectedSpecializedIn,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedSpecializedIn = value.cast<String>();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Financial Information',
//                 icon: Icons.monetization_on_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'PAN Card Number',
//                     controller: _panCardController,
//                   ),
//                   CustomTextFormField(
//                     label: 'GST Number',
//                     controller: _gstController,
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Has Existing Loans',
//                     icon: Icons.money_rounded,
//                     value: _hasExistingLoans,
//                     onChanged: (val) => setState(() => _hasExistingLoans = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Credit Score',
//                     controller: _creditScoreController,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Countries Interested',
//                 icon: Icons.public_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomCheckDropdown(
//                     label: "Country Interested",
//                     items: configController.configData.value.country
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         [
//                           'Canada',
//                           'Australia',
//                           'USA',
//                           'UK',
//                           'Germany',
//                           'France'
//                         ],
//                     values: _selectedCountriesInterested,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedCountriesInterested = value.cast<String>();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Documents & Records Tab
//   Widget _buildDocumentsTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle(
//             title: 'Passport Information',
//             icon: Icons.book_online_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Passport Number',
//                     controller: _passportNumberController,
//                   ),
//                   CustomDateField(
//                     label: 'Passport Expiry Date',
//                     controller: _passportExpiryController,
//                     initialDate: DateTime.now(),
//                     onChanged: (formattedDate) {
//                       _passportExpiryController.text = formattedDate;
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Academic Records',
//             icon: Icons.school_rounded,
//           ),
//           const SizedBox(height: 16),
//           ..._academicRecords.asMap().entries.map((entry) {
//             int index = entry.key;
//             AcademicRecordModel record = entry.value;
//             return _buildAcademicRecordCard(index, record);
//           }).toList(),
//           CustomActionButton(
//             text: 'Add Academic Record',
//             icon: Icons.add,
//             onPressed: () {
//               setState(() {
//                 _academicRecords.add(AcademicRecordModel());
//               });
//             },
//             backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//             textColor: AppColors.primaryColor,
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Work Records',
//             icon: Icons.work_rounded,
//           ),
//           const SizedBox(height: 16),
//           ..._workRecords.asMap().entries.map((entry) {
//             int index = entry.key;
//             WorkRecordModel record = entry.value;
//             return _buildWorkRecordCard(index, record);
//           }).toList(),
//           CustomActionButton(
//             text: 'Add Work Record',
//             icon: Icons.add,
//             onPressed: () {
//               setState(() {
//                 _workRecords.add(WorkRecordModel());
//               });
//             },
//             backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//             textColor: AppColors.primaryColor,
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Travel Records',
//             icon: Icons.flight_takeoff_rounded,
//           ),
//           const SizedBox(height: 16),
//           ..._travelRecords.asMap().entries.map((entry) {
//             int index = entry.key;
//             TravelRecordModel record = entry.value;
//             return _buildTravelRecordCard(index, record);
//           }).toList(),
//           CustomActionButton(
//             text: 'Add Travel Record',
//             icon: Icons.add,
//             onPressed: () {
//               setState(() {
//                 _travelRecords.add(TravelRecordModel());
//               });
//             },
//             backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//             textColor: AppColors.primaryColor,
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Exam Records',
//             icon: Icons.assignment_rounded,
//           ),
//           const SizedBox(height: 16),
//           ..._examRecords.asMap().entries.map((entry) {
//             int index = entry.key;
//             ExamRecordModel record = entry.value;
//             return _buildExamRecordCard(index, record);
//           }).toList(),
//           CustomActionButton(
//             text: 'Add Exam Record',
//             icon: Icons.add,
//             onPressed: () {
//               setState(() {
//                 _examRecords.add(ExamRecordModel());
//               });
//             },
//             backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//             textColor: AppColors.primaryColor,
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }

//   // Education Tab
//   Widget _buildEducationTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableWidth = constraints.maxWidth;
//           int columnsCount = availableWidth > 1000
//               ? 3
//               : availableWidth > 600
//                   ? 2
//                   : 1;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                 title: 'Educational Background',
//                 icon: Icons.school_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Highest Qualification',
//                     controller: _fieldOfStudyController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Qualification',
//                     controller: TextEditingController(),
//                   ),
//                   CustomDropdownField(
//                     label: 'Field of Study',
//                     value: _selectedHeightQualification,
//                     items: const [
//                       'Computer Science',
//                       'Engineering',
//                       'Medicine',
//                       'Business',
//                       'Arts',
//                       'Science'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedHeightQualification = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Year of Passing',
//                     controller: _yearOfPassingController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Percentage/CGPA',
//                     controller: _percentageController,
//                   ),
//                   CustomDropdownField(
//                     label: 'Preferred Study Mode',
//                     value: _selectedPreferredStudyMode,
//                     items: const ['Online', 'Offline', 'Hybrid'],
//                     onChanged: (val) =>
//                         setState(() => _selectedPreferredStudyMode = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Batch Preference',
//                     value: _selectedBatchPreference,
//                     items: const ['Morning', 'Afternoon', 'Evening', 'Weekend'],
//                     onChanged: (val) =>
//                         setState(() => _selectedBatchPreference = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Courses Interested',
//                 icon: Icons.menu_book_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomCheckDropdown(
//                     label: "Courses Interested",
//                     items: const [
//                       'Cloud Computing',
//                       'Data Analytics',
//                       'AI/ML',
//                       'Cybersecurity',
//                       'Web Development'
//                     ],
//                     values: _selectedCoursesInterested,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedCoursesInterested = value.cast<String>();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Travel Tab
//   Widget _buildTravelTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableWidth = constraints.maxWidth;
//           int columnsCount = availableWidth > 1000
//               ? 3
//               : availableWidth > 600
//                   ? 2
//                   : 1;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                 title: 'Travel Preferences',
//                 icon: Icons.flight_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Travel Purpose',
//                     value: _selectedTravelPurpose,
//                     items: const [
//                       'Holiday',
//                       'Business',
//                       'Education',
//                       'Medical',
//                       'Family Visit'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedTravelPurpose = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Visa Type Required',
//                     value: _selectedVisaTypeRequired,
//                     items: const [
//                       'Tourist',
//                       'Business',
//                       'Student',
//                       'Work',
//                       'Transit'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedVisaTypeRequired = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Number of Travelers',
//                     controller: _numberOfTravelersController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Travel Duration (days)',
//                     controller: _travelDurationController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomDropdownField(
//                     label: 'Accommodation Preference',
//                     value: _selectedAccommodationPreference,
//                     items: const [
//                       'Hotel',
//                       'Apartment',
//                       'Hostel',
//                       'Resort',
//                       'Homestay'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedAccommodationPreference = val),
//                   ),
//                   CustomCheckDropdown(
//                     label: "Visited Countries",
//                     items: configController.configData.value.country
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         ['UAE', 'Thailand', 'Singapore', 'Malaysia', 'USA'],
//                     values: _selectedVisitedCountries,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedVisitedCountries = value.cast<String>();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SectionTitle(
//                 title: 'Travel Services',
//                 icon: Icons.confirmation_number_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   EnhancedSwitchTile(
//                     label: 'Requires Travel Insurance',
//                     icon: Icons.security_rounded,
//                     value: _requiresTravelInsurance,
//                     onChanged: (val) =>
//                         setState(() => _requiresTravelInsurance = val),
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Requires Hotel Booking',
//                     icon: Icons.hotel_rounded,
//                     value: _requiresHotelBooking,
//                     onChanged: (val) =>
//                         setState(() => _requiresHotelBooking = val),
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Requires Flight Booking',
//                     icon: Icons.flight_takeoff_rounded,
//                     value: _requiresFlightBooking,
//                     onChanged: (val) =>
//                         setState(() => _requiresFlightBooking = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Migration Tab
//   Widget _buildMigrationTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final availableWidth = constraints.maxWidth;
//           int columnsCount = availableWidth > 1000
//               ? 3
//               : availableWidth > 600
//                   ? 2
//                   : 1;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                 title: 'Migration Preferences',
//                 icon: Icons.public_rounded,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Target Visa Type',
//                     value: _selectedTargetVisaType,
//                     items: const [
//                       'Work Visa',
//                       'Student Visa',
//                       'Permanent Residency',
//                       'Business Visa',
//                       'Family Visa'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedTargetVisaType = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Preferred Settlement City',
//                     controller: _preferredSettlementCityController,
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Has Relatives Abroad',
//                     icon: Icons.family_restroom_rounded,
//                     value: _hasRelativesAbroad,
//                     onChanged: (val) =>
//                         setState(() => _hasRelativesAbroad = val),
//                   ),
//                   if (_hasRelativesAbroad) ...[
//                     CustomTextFormField(
//                       label: 'Relative Country',
//                       controller: _relativeCountryController,
//                     ),
//                     CustomTextFormField(
//                       label: 'Relative Relation',
//                       controller: _relativeRelationController,
//                     ),
//                   ],
//                   EnhancedSwitchTile(
//                     label: 'Requires Job Assistance',
//                     icon: Icons.work_rounded,
//                     value: _requiresJobAssistance,
//                     onChanged: (val) =>
//                         setState(() => _requiresJobAssistance = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Real Estate & Vehicle Tab
//   Widget _buildRealEstateTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle(
//             title: 'Vehicle Preferences',
//             icon: Icons.directions_car_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Vehicle Type',
//                     value: _selectedVehicleType,
//                     items: const ['Car', 'Bike', 'Scooter', 'SUV', 'Truck'],
//                     onChanged: (val) =>
//                         setState(() => _selectedVehicleType = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Brand Preference',
//                     controller: _selectedBrandPreference,
//                   ),
//                   CustomTextFormField(
//                     label: 'Model Preference',
//                     controller: _modelPreferenceController,
//                   ),
//                   CustomDropdownField(
//                     label: 'Fuel Type',
//                     value: _selectedFuelType,
//                     items: const [
//                       'Petrol',
//                       'Diesel',
//                       'Electric',
//                       'Hybrid',
//                       'CNG'
//                     ],
//                     onChanged: (val) => setState(() => _selectedFuelType = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Transmission',
//                     value: _selectedTransmission,
//                     items: const ['Automatic', 'Manual'],
//                     onChanged: (val) =>
//                         setState(() => _selectedTransmission = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Insurance Type',
//                     value: _selectedInsuranceType,
//                     items: const [
//                       'Comprehensive',
//                       'Third Party',
//                       'Zero Depreciation'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedInsuranceType = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Down Payment Available',
//                     controller: _downPaymentController,
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee_rounded,
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Loan Required',
//                     icon: Icons.money_rounded,
//                     value: _loanRequired,
//                     onChanged: (val) => setState(() => _loanRequired = val),
//                   ),
//                   if (_loanRequired)
//                     CustomTextFormField(
//                       label: 'Loan Amount Required',
//                       controller: _loanAmountController,
//                       keyboardType: TextInputType.number,
//                       prefixIcon: Icons.currency_rupee_rounded,
//                     ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Real Estate Preferences',
//             icon: Icons.home_work_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Property Type',
//                     value: _selectedPropertyType,
//                     items: const [
//                       'Apartment',
//                       'Villa',
//                       'Plot',
//                       'Commercial',
//                       'Farm House'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedPropertyType = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Property Use',
//                     value: _selectedPropertyUse,
//                     items: const [
//                       'Residential',
//                       'Commercial',
//                       'Investment',
//                       'Rental'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedPropertyUse = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Furnishing Preference',
//                     value: _selectedFurnishingPreference,
//                     items: const [
//                       'Fully Furnished',
//                       'Semi-Furnished',
//                       'Unfurnished'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedFurnishingPreference = val),
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Requires Home Loan',
//                     icon: Icons.home_rounded,
//                     value: _requiresHomeLoan,
//                     onChanged: (val) => setState(() => _requiresHomeLoan = val),
//                   ),
//                   if (_requiresHomeLoan)
//                     CustomTextFormField(
//                       label: 'Loan Amount Required',
//                       controller: _loanAmountRealEstateController,
//                       keyboardType: TextInputType.number,
//                       prefixIcon: Icons.currency_rupee_rounded,
//                     ),
//                   CustomDateField(
//                     label: 'Possession Timeline',
//                     controller: _possessionTimelineController,
//                     initialDate: DateTime.now(),
//                     onChanged: (formattedDate) {
//                       _possessionTimelineController.text = formattedDate;
//                     },
//                   ),
//                   EnhancedSwitchTile(
//                     label: 'Requires Legal Assistance',
//                     icon: Icons.gavel_rounded,
//                     value: _requiresLegalAssistance,
//                     onChanged: (val) =>
//                         setState(() => _requiresLegalAssistance = val),
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }

//   // Other Tab
//   Widget _buildOtherTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle(
//             title: 'Budget & Preferences',
//             icon: Icons.attach_money_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Budget',
//                     controller: _budgetController,
//                     keyboardType: TextInputType.number,
//                     prefixIcon: Icons.currency_rupee_rounded,
//                   ),
//                   CustomTextFormField(
//                     label: 'Preferred Location',
//                     controller: _preferredLocationController,
//                     hintText: 'e.g., Europe, USA, Australia',
//                   ),
//                   CustomDateField(
//                     label: 'Preferred Date',
//                     controller: _preferredDateController,
//                     initialDate: DateTime.now(),
//                     onChanged: (formattedDate) {
//                       _preferredDateController.text = formattedDate;
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Group Details',
//             icon: Icons.group_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Total Peoples',
//                     controller: _totalPeoplesController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomDropdownField(
//                     label: 'Group Type',
//                     value: _selectedGroupType,
//                     items: const [
//                       'Family',
//                       'Friends',
//                       'Couple',
//                       'Solo',
//                       'Corporate'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedGroupType = val),
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           const SectionTitle(
//             title: 'Login Credentials',
//             icon: Icons.security_rounded,
//           ),
//           const SizedBox(height: 16),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final availableWidth = constraints.maxWidth;
//               int columnsCount = availableWidth > 1000
//                   ? 3
//                   : availableWidth > 600
//                       ? 2
//                       : 1;

//               return ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Email Password',
//                     controller: _emailPasswordController,
//                     obscureText: true,
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }

//   // Helper Widgets for Records
//   Widget _buildAcademicRecordCard(int index, AcademicRecordModel record) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Academic Record ${index + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       _academicRecords.removeAt(index);
//                     });
//                   },
//                   iconSize: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final availableWidth = constraints.maxWidth;
//                 int columnsCount = availableWidth > 800
//                     ? 3
//                     : availableWidth > 500
//                         ? 2
//                         : 1;

//                 return ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     CustomTextFormField(
//                       label: 'Qualification',
//                       // controller:
//                       //     TextEditingController(text: record.qualification),
//                       onChanged: (value) {
//                         _academicRecords[index].qualification = value;
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Institution',
//                       // controller:
//                       //     TextEditingController(text: record.institution),
//                       onChanged: (value) {
//                         _academicRecords[index].institution = value;
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Year of Passing',
//                       // controller: TextEditingController(
//                       //     text: record.yearOfPassing?.toString()),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         _academicRecords[index].yearOfPassing =
//                             int.tryParse(value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Percentage',
//                       // controller: TextEditingController(
//                       //     text: record.percentage?.toString()),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         _academicRecords[index].percentage =
//                             double.tryParse(value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Board',
//                       // controller: TextEditingController(text: record.board),
//                       onChanged: (value) {
//                         _academicRecords[index].board = value;
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Description',
//                       controller:
//                           TextEditingController(text: record.description),
//                       maxLines: 2,
//                       onChanged: (value) {
//                         _academicRecords[index].description = value;
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkRecordCard(int index, WorkRecordModel record) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Work Record ${index + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       _workRecords.removeAt(index);
//                     });
//                   },
//                   iconSize: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final availableWidth = constraints.maxWidth;
//                 int columnsCount = availableWidth > 800
//                     ? 3
//                     : availableWidth > 500
//                         ? 2
//                         : 1;

//                 return ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     CustomTextFormField(
//                       label: 'Company',
//                       controller: TextEditingController(text: record.company),
//                       onChanged: (value) {
//                         _workRecords[index] = record.copyWith(company: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Position',
//                       controller: TextEditingController(text: record.position),
//                       onChanged: (value) {
//                         _workRecords[index] = record.copyWith(position: value);
//                       },
//                     ),
//                     CustomDateField(
//                       label: 'Start Date',
//                       controller: TextEditingController(text: record.startDate),
//                       onChanged: (value) {
//                         _workRecords[index] = record.copyWith(startDate: value);
//                       },
//                     ),
//                     CustomDateField(
//                       label: 'End Date',
//                       controller: TextEditingController(text: record.endDate),
//                       onChanged: (value) {
//                         _workRecords[index] = record.copyWith(endDate: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Description',
//                       controller:
//                           TextEditingController(text: record.description),
//                       maxLines: 2,
//                       onChanged: (value) {
//                         _workRecords[index] =
//                             record.copyWith(description: value);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTravelRecordCard(int index, TravelRecordModel record) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Travel Record ${index + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       _travelRecords.removeAt(index);
//                     });
//                   },
//                   iconSize: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final availableWidth = constraints.maxWidth;
//                 int columnsCount = availableWidth > 800
//                     ? 3
//                     : availableWidth > 500
//                         ? 2
//                         : 1;

//                 return ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     CustomTextFormField(
//                       label: 'Country',
//                       controller: TextEditingController(text: record.country),
//                       onChanged: (value) {
//                         _travelRecords[index] = record.copyWith(country: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Purpose',
//                       controller: TextEditingController(text: record.purpose),
//                       onChanged: (value) {
//                         _travelRecords[index] = record.copyWith(purpose: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Duration',
//                       controller: TextEditingController(text: record.duration),
//                       onChanged: (value) {
//                         _travelRecords[index] =
//                             record.copyWith(duration: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Year',
//                       controller:
//                           TextEditingController(text: record.year?.toString()),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         _travelRecords[index] =
//                             record.copyWith(year: int.tryParse(value));
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Description',
//                       controller:
//                           TextEditingController(text: record.description),
//                       maxLines: 2,
//                       onChanged: (value) {
//                         _travelRecords[index] =
//                             record.copyWith(description: value);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExamRecordCard(int index, ExamRecordModel record) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Exam Record ${index + 1}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       _examRecords.removeAt(index);
//                     });
//                   },
//                   iconSize: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final availableWidth = constraints.maxWidth;
//                 int columnsCount = availableWidth > 800
//                     ? 3
//                     : availableWidth > 500
//                         ? 2
//                         : 1;

//                 return ResponsiveGrid(
//                   columns: columnsCount,
//                   children: [
//                     CustomTextFormField(
//                       label: 'Exam Name',
//                       controller: TextEditingController(text: record.examName),
//                       onChanged: (value) {
//                         _examRecords[index] = record.copyWith(examName: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Score',
//                       controller:
//                           TextEditingController(text: record.score?.toString()),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         _examRecords[index] =
//                             record.copyWith(score: double.tryParse(value));
//                       },
//                     ),
//                     CustomDateField(
//                       label: 'Test Date',
//                       controller: TextEditingController(text: record.testDate),
//                       onChanged: (value) {
//                         _examRecords[index] = record.copyWith(testDate: value);
//                       },
//                     ),
//                     CustomDateField(
//                       label: 'Validity',
//                       controller: TextEditingController(text: record.validity),
//                       onChanged: (value) {
//                         _examRecords[index] = record.copyWith(validity: value);
//                       },
//                     ),
//                     CustomTextFormField(
//                       label: 'Description',
//                       controller:
//                           TextEditingController(text: record.description),
//                       maxLines: 2,
//                       onChanged: (value) {
//                         _examRecords[index] =
//                             record.copyWith(description: value);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _saveLeadData() async {
//     await Get.find<LeadController>().createLead(
//       context,
//       LeadModel(
//         // Primary Data
//         name: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         phone: _mobileController.text.trim(),
//         countryCode: _selectedPhoneCtry ?? '+91',
//         alternatePhone: _mobileOptionalController.text.trim().isNotEmpty
//             ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
//                 .trim()
//             : "",
//         whatsapp: _waMobileController.text.trim().isNotEmpty
//             ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}".trim()
//             : "",
//         gender: _selectedGender ?? "",
//         dob: _dobController.text.trim(),
//         maritalStatus: _selectedMaritalStatus ?? '',
//         serviceType: _selectedService ?? 'LEAD',
//         address: _addressController.text.trim(),
//         city: _cityController.text.trim(),
//         state: _stateController.text.trim(),
//         country: _countryController.text.trim(),
//         pincode: _pincodeController.text.trim(),
//         leadSource: _selectedLeadSource ?? "",
//         sourceCampaign: _sourceCampaignController.text.trim(),
//         status: _selectedStatus ?? "NEW",
//         branch: _selectedBranch ?? "",
//         note: _noteController.text.trim(),
//         interestedIn: _selectedInterestedIn,
//         feedback: _feedbackController.text.trim(),
//         // Professional Details
//         countryInterested: _selectedCountriesInterested,
//         expectedSalary: _expectedSalaryController.text.trim().isNotEmpty
//             ? int.tryParse(_expectedSalaryController.text.trim())
//             : null,
//         qualification: _fieldOfStudyController.text.trim(),
//         experience: _experienceController.text.trim().isNotEmpty
//             ? int.tryParse(_experienceController.text.trim())
//             : null,
//         skills: _selectedSkills,
//         profession: _professionController.text.trim(),
//         specializedIn: _selectedSpecializedIn,
//         employmentStatus: _selectedEmploymentStatus,
//         annualIncome: _annualIncomeController.text.trim().isNotEmpty
//             ? int.tryParse(_annualIncomeController.text.trim())
//             : null,
//         panCardNumber: _panCardController.text.trim(),
//         gstNumber: _gstController.text.trim(),
//         hasExistingLoans: _hasExistingLoans,
//         creditScore: _creditScoreController.text.trim().isNotEmpty
//             ? int.tryParse(_creditScoreController.text.trim())
//             : null,
//         firstJobDate: _firstJobDateController.text.trim(),
//         // Personal Details
//         birthCountry: _selectedBirthCountry,
//         birthPlace: _birthPlaceController.text.trim(),
//         emailPassword: _emailPasswordController.text.trim(),
//         emergencyContact: _emergencyContactController.text.trim(),
//         passportNumber: _passportNumberController.text.trim(),
//         passportExpiryDate: _passportExpiryController.text.trim(),
//         religion: _religionController.text.trim(),
//         jobGapMonths: _jobGapController.text.trim().isNotEmpty
//             ? int.tryParse(_jobGapController.text.trim())
//             : null,
//         // Records
//         academicRecords: _academicRecords,
//         examRecords: _examRecords,
//         travelRecords: _travelRecords,
//         workRecords: _workRecords,
//         // Travel Preferences
//         travelPurpose: _selectedTravelPurpose,
//         numberOfTravelers: _numberOfTravelersController.text.trim().isNotEmpty
//             ? int.tryParse(_numberOfTravelersController.text.trim())
//             : null,
//         accommodationPreference: _selectedAccommodationPreference,
//         visitedCountries: _selectedVisitedCountries,
//         visaTypeRequired: _selectedVisaTypeRequired,
//         travelDuration: _travelDurationController.text.trim().isNotEmpty
//             ? int.tryParse(_travelDurationController.text.trim())
//             : null,
//         requiresTravelInsurance: _requiresTravelInsurance,
//         requiresHotelBooking: _requiresHotelBooking,
//         requiresFlightBooking: _requiresFlightBooking,

//         // Education Preferences
//         preferredStudyMode: _selectedPreferredStudyMode,
//         batchPreference: _selectedBatchPreference,
//         highestQualification: _fieldOfStudyController.text.trim(),
//         yearOfPassing: _yearOfPassingController.text.trim().isNotEmpty
//             ? int.tryParse(_yearOfPassingController.text.trim())
//             : null,
//         fieldOfStudy: _selectedHeightQualification,
//         // percentageOrCgpa: _percentageController.text.trim(),
//         coursesInterested: _selectedCoursesInterested,

//         // Migration Preferences
//         targetVisaType: _selectedTargetVisaType,
//         hasRelativesAbroad: _hasRelativesAbroad,
//         relativeCountry: _relativeCountryController.text.trim(),
//         relativeRelation: _relativeRelationController.text.trim(),
//         requiresJobAssistance: _requiresJobAssistance,
//         preferredSettlementCity: _preferredSettlementCityController.text.trim(),

//         // Vehicle Preferences
//         vehicleType: _selectedVehicleType,
//         // brandPreference: _brandPreferenceController.text.trim(),
//         modelPreference: _modelPreferenceController.text.trim(),
//         fuelType: _selectedFuelType,
//         transmission: _selectedTransmission,
//         downPaymentAvailable: _downPaymentController.text.trim().isNotEmpty
//             ? int.tryParse(_downPaymentController.text.trim())
//             : null,
//         insuranceType: _selectedInsuranceType,

//         // Property Preferences
//         propertyType: _selectedPropertyType,
//         propertyUse: _selectedPropertyUse,
//         requiresHomeLoan: _requiresHomeLoan,
//         loanAmountRequiredRealEstate:
//             _loanAmountRealEstateController.text.trim().isNotEmpty
//                 ? int.tryParse(_loanAmountRealEstateController.text.trim())
//                 : null,
//         possessionTimeline: _possessionTimelineController.text.trim(),
//         furnishingPreference: _selectedFurnishingPreference,
//         requiresLegalAssistance: _requiresLegalAssistance,

//         // Other Details
//         loanRequired: _loanRequired,
//         loanAmountRequired: _loanAmountController.text.trim().isNotEmpty
//             ? int.tryParse(_loanAmountController.text.trim())
//             : null,
//         onCallCommunication: _onCallCommunication,
//         phoneCommunication: _phoneCommunication,
//         emailCommunication: _emailCommunication,
//         whatsappCommunication: _whatsappCommunication,
//         officerId: _selectedOfficer ?? "",
//         // productInterested: productsList,
//         budget: _budgetController.text.trim().isNotEmpty
//             ? int.tryParse(_budgetController.text.trim())
//             : null,
//         preferredLocation: _preferredLocationController.text.trim(),
//         preferredDate: _preferredDateController.text.trim(),
//         totalPeoples: _totalPeoplesController.text.trim(),
//         groupType: _selectedGroupType,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import '../../../controller/lead/lead_controller.dart';
// import '../../../model/lead/lead_model.dart';
// import '../../../model/lead/product_intreseted_model.dart';

// class AddLeadScreen extends StatefulWidget {
//   const AddLeadScreen({super.key});
//   @override
//   State<AddLeadScreen> createState() => _AddLeadScreenState();
// }

// class _AddLeadScreenState extends State<AddLeadScreen> {
//   final leadController = Get.find<LeadController>();
//   final configController = Get.find<ConfigController>();
//   final officersController = Get.find<OfficersController>();
//   final _formKey = GlobalKey<FormState>();
//   final ScrollController _scrollController = ScrollController();
//   // Form controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _waMobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _leadDateController = TextEditingController();
//   final TextEditingController _mobileOptionalController =
//       TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();
//   final TextEditingController _feedbackController = TextEditingController();
//   final TextEditingController _budgetController = TextEditingController();
//   final TextEditingController _preferredLocationController =
//       TextEditingController();
//   final TextEditingController _preferredDateController =
//       TextEditingController();
//   final TextEditingController _sourceCampaignController =
//       TextEditingController();

//   // Form values
//   String? _selectedService = 'LEAD'; // Updated to match JSON
//   String? _selectedGender;
//   String? _selectedMaritalStatus;
//   String? _selectedPhoneCtry = "+91";
//   String? _selectedAltPhoneCtry = "+91";
//   String? _selectedWAPhoneCtry = "+91";
//   String? _selectedLeadSource;
//   String? _selectedStatus = "NEW"; // Default status
//   String? _selectedBranch;
//   String? _selectedOfficer;
//   String? _selectedQualification;
//   List<String> _selectedInterestedIn = [];

//   // Communication preferences
//   bool _onCallCommunication = false;
//   bool _phoneCommunication = true;
//   bool _emailCommunication = false;
//   bool _whatsappCommunication = false;

//   // Loan related
//   bool _loanRequired = false;
//   final TextEditingController _loanAmountController = TextEditingController();

//   // Product interested list
//   List<ProductInterestedModel> _productsInterested = [];

//   @override
//   void initState() {
//     super.initState();
//     _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
//     _preferredDateController.text = DateFormat("yyyy-MM-dd")
//         .format(DateTime.now().add(const Duration(days: 30)));

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await officersController.fetchOfficersList();
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _leadDateController.dispose();
//     _mobileOptionalController.dispose();
//     _addressController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _countryController.dispose();
//     _pincodeController.dispose();
//     _dobController.dispose();
//     _noteController.dispose();
//     _feedbackController.dispose();
//     _budgetController.dispose();
//     _preferredLocationController.dispose();
//     _preferredDateController.dispose();
//     _sourceCampaignController.dispose();
//     _loanAmountController.dispose();
//     super.dispose();
//   }

//   void _addProductInterested() {
//     setState(() {
//       _productsInterested.add(ProductInterestedModel(
//         productId: "",
//         productName: "",
//         offers: [],
//       ));
//     });
//   }

//   void _removeProductInterested(int index) {
//     setState(() {
//       _productsInterested.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           double dialogWidth = maxWidth;
//           if (maxWidth > 1400) {
//             dialogWidth = maxWidth * 0.72;
//           } else if (maxWidth > 1000) {
//             dialogWidth = maxWidth * 0.9;
//           } else if (maxWidth > 600) {
//             dialogWidth = maxWidth * 0.95;
//           }

//           return Center(
//             child: Container(
//               width: dialogWidth,
//               height: maxHeight * 0.95,
//               constraints: const BoxConstraints(
//                 minWidth: 320,
//                 maxWidth: 1600,
//                 minHeight: 500,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.15),
//                     spreadRadius: 0,
//                     blurRadius: 40,
//                     offset: const Offset(0, 20),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Header Section
//                   Container(
//                     height: 80,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(0.9),
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.leaderboard_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: 'Add New Lead',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: 'Capture lead details for follow up',
//                                 fontSize: 13,
//                                 color: Colors.white70,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         IconButton(
//                           icon: const Icon(Icons.close_rounded,
//                               color: Colors.white, size: 24),
//                           onPressed: () => Navigator.of(context).pop(),
//                           tooltip: 'Close',
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Form Content
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Main Form
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border:
//                                       Border.all(color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Scrollbar(
//                                         controller: _scrollController,
//                                         thumbVisibility: true,
//                                         child: SingleChildScrollView(
//                                           controller: _scrollController,
//                                           padding: const EdgeInsets.all(24),
//                                           child: LayoutBuilder(
//                                             builder: (context, constraints) {
//                                               final availableWidth =
//                                                   constraints.maxWidth;
//                                               int columnsCount =
//                                                   availableWidth > 1000
//                                                       ? 3
//                                                       : availableWidth > 600
//                                                           ? 2
//                                                           : 1;

//                                               return Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const SectionTitle(
//                                                     title: 'Primary Details',
//                                                     icon: Icons
//                                                         .person_outline_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label: 'Full Name *',
//                                                         controller:
//                                                             _nameController,
//                                                         isRequired: true,
//                                                       ),
//                                                       CustomPhoneField(
//                                                         showCountryCode: true,
//                                                         label:
//                                                             'Mobile Number *',
//                                                         controller:
//                                                             _mobileController,
//                                                         selectedCountry:
//                                                             _selectedPhoneCtry,
//                                                         onCountryChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedPhoneCtry =
//                                                                     val),
//                                                         isRequired: true,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Email',
//                                                         controller:
//                                                             _emailController,
//                                                         isEmail: true,
//                                                       ),
//                                                       CustomPhoneField(
//                                                         label:
//                                                             'Alternate Phone',
//                                                         controller:
//                                                             _mobileOptionalController,
//                                                         selectedCountry:
//                                                             _selectedAltPhoneCtry,
//                                                         onCountryChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedAltPhoneCtry =
//                                                                     val),
//                                                       ),
//                                                       CustomPhoneField(
//                                                         label:
//                                                             'Whatsapp Number',
//                                                         controller:
//                                                             _waMobileController,
//                                                         selectedCountry:
//                                                             _selectedWAPhoneCtry,
//                                                         onCountryChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedWAPhoneCtry =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Service Type',
//                                                         isRequired: true,
//                                                         value: _selectedService,
//                                                         items: const [
//                                                           'LEAD',
//                                                           'TRAVEL',
//                                                           'MIGRATION',
//                                                           'EDUCATION'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedService =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                     title: 'Personal Details',
//                                                     icon: Icons
//                                                         .person_outline_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomDropdownField(
//                                                         label: 'Gender',
//                                                         value: _selectedGender,
//                                                         items: const [
//                                                           'Male',
//                                                           'Female',
//                                                           'Other'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedGender =
//                                                                     val),
//                                                       ),
//                                                       CustomDateField(
//                                                         label: 'Date of Birth',
//                                                         controller:
//                                                             _dobController,
//                                                         endDate: DateTime.now(),
//                                                         onChanged:
//                                                             (formattedDate) {
//                                                           _dobController.text =
//                                                               formattedDate;
//                                                         },
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Marital Status',
//                                                         value:
//                                                             _selectedMaritalStatus,
//                                                         items: const [
//                                                           'Single',
//                                                           'Married'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedMaritalStatus =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                     title: 'Location Details',
//                                                     icon: Icons
//                                                         .location_on_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label: 'Address',
//                                                         controller:
//                                                             _addressController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'City',
//                                                         controller:
//                                                             _cityController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'State',
//                                                         controller:
//                                                             _stateController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Country',
//                                                         controller:
//                                                             _countryController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Pincode',
//                                                         controller:
//                                                             _pincodeController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                     title: 'Lead Information',
//                                                     icon: Icons
//                                                         .leaderboard_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomDropdownField(
//                                                         label: 'Lead Source',
//                                                         value:
//                                                             _selectedLeadSource,
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .leadSource
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [
//                                                               'Website',
//                                                               'Referral',
//                                                               'Walk-in',
//                                                               'Social Media'
//                                                             ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedLeadSource =
//                                                                     val),
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Source Campaign',
//                                                         controller:
//                                                             _sourceCampaignController,
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Status',
//                                                         value: _selectedStatus,
//                                                         items: const [
//                                                           'NEW',
//                                                           'CONTACTED',
//                                                           'QUALIFIED',
//                                                           'PROPOSAL',
//                                                           'NEGOTIATION',
//                                                           'WON',
//                                                           'LOST'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedStatus =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Branch',
//                                                         value: _selectedBranch,
//                                                         items: const [
//                                                           'Bangalore HQ',
//                                                           'Delhi Office',
//                                                           'Mumbai Office',
//                                                           'Chennai Office'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedBranch =
//                                                                     val),
//                                                       ),
//                                                       CustomCheckDropdown(
//                                                         label: "Interested In",
//                                                         items: const [
//                                                           'TRAVEL',
//                                                           'MIGRATION',
//                                                           'EDUCATION',
//                                                           'VISA'
//                                                         ],
//                                                         values:
//                                                             _selectedInterestedIn,
//                                                         onChanged: (value) {
//                                                           setState(() {
//                                                             _selectedInterestedIn =
//                                                                 value.cast<
//                                                                     String>();
//                                                           });
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                     title:
//                                                         'Preferences & Budget',
//                                                     icon: Icons
//                                                         .attach_money_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label: 'Budget',
//                                                         controller:
//                                                             _budgetController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                         prefixIcon: Icons
//                                                             .currency_rupee_rounded,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Preferred Location',
//                                                         controller:
//                                                             _preferredLocationController,
//                                                         hintText:
//                                                             'e.g., Europe, USA, Australia',
//                                                       ),
//                                                       CustomDateField(
//                                                         label: 'Preferred Date',
//                                                         controller:
//                                                             _preferredDateController,
//                                                         initialDate:
//                                                             DateTime.now(),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   // Loan Section
//                                                   const SectionTitle(
//                                                     title: 'Loan Information',
//                                                     icon: Icons.money_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       EnhancedSwitchTile(
//                                                         label: 'Loan Required',
//                                                         icon:
//                                                             Icons.money_rounded,
//                                                         value: _loanRequired,
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _loanRequired =
//                                                                     val),
//                                                       ),
//                                                       if (_loanRequired)
//                                                         CustomTextFormField(
//                                                           label:
//                                                               'Loan Amount Required',
//                                                           controller:
//                                                               _loanAmountController,
//                                                           keyboardType:
//                                                               TextInputType
//                                                                   .number,
//                                                           prefixIcon: Icons
//                                                               .currency_rupee_rounded,
//                                                         ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   // Products Interested Section
//                                                   const SectionTitle(
//                                                     title:
//                                                         'Products Interested',
//                                                     icon: Icons
//                                                         .shopping_bag_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ..._productsInterested
//                                                       .asMap()
//                                                       .entries
//                                                       .map((entry) {
//                                                     int index = entry.key;
//                                                     ProductInterestedModel
//                                                         product = entry.value;
//                                                     return Card(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               bottom: 12),
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(12),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 Text(
//                                                                   'Product ${index + 1}',
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold),
//                                                                 ),
//                                                                 IconButton(
//                                                                   icon: const Icon(
//                                                                       Icons
//                                                                           .delete,
//                                                                       color: Colors
//                                                                           .red),
//                                                                   onPressed: () =>
//                                                                       _removeProductInterested(
//                                                                           index),
//                                                                   iconSize: 20,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 8),
//                                                             CustomTextFormField(
//                                                               label:
//                                                                   'Product Name',
//                                                               controller:
//                                                                   TextEditingController(
//                                                                       text: product
//                                                                           .productName),
//                                                               onChanged:
//                                                                   (value) {
//                                                                 setState(() {
//                                                                   _productsInterested[
//                                                                           index] =
//                                                                       product.copyWith(
//                                                                           productName:
//                                                                               value);
//                                                                 });
//                                                               },
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 8),
//                                                             CustomTextFormField(
//                                                               label:
//                                                                   'Product ID',
//                                                               controller:
//                                                                   TextEditingController(
//                                                                       text: product
//                                                                           .productId),
//                                                               onChanged:
//                                                                   (value) {
//                                                                 setState(() {
//                                                                   _productsInterested[
//                                                                           index] =
//                                                                       product.copyWith(
//                                                                           productId:
//                                                                               value);
//                                                                 });
//                                                               },
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                                   CustomActionButton(
//                                                     text: 'Add Product',
//                                                     icon: Icons.add,
//                                                     onPressed:
//                                                         _addProductInterested,
//                                                     // backgroundColor: AppColors
//                                                     //     .primaryColor
//                                                     //     .withOpacity(0.1),
//                                                     textColor:
//                                                         AppColors.primaryColor,
//                                                   ),
//                                                   const SizedBox(height: 20),
//                                                   const SectionTitle(
//                                                     title:
//                                                         'Additional Information',
//                                                     icon: Icons.note_rounded,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: 1,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label: 'Notes',
//                                                         controller:
//                                                             _noteController,
//                                                         maxLines: 3,
//                                                         hintText:
//                                                             'e.g., Client asked about Europe trip packages.',
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       CustomTextFormField(
//                                                         label: 'Feedback',
//                                                         controller:
//                                                             _feedbackController,
//                                                         maxLines: 2,
//                                                       ),
//                                                       CustomOfficerDropDown(
//                                                         label:
//                                                             'Assigned Officer',
//                                                         value: _selectedOfficer,
//                                                         items:
//                                                             officersController
//                                                                 .officersList
//                                                                 .map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList(),
//                                                         onChanged: (value) {
//                                                           _selectedOfficer =
//                                                               value
//                                                                       ?.split(
//                                                                           ",")
//                                                                       .last ??
//                                                                   "";
//                                                         },
//                                                         isSplit: true,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   // Communication Preferences (for small screens)
//                                                   if (maxWidth <= 1000) ...[
//                                                     const SizedBox(height: 32),
//                                                     SectionTitle(
//                                                       title:
//                                                           'Communication Preference',
//                                                       icon: Icons.call,
//                                                     ),
//                                                     const SizedBox(height: 16),
//                                                     ResponsiveGrid(
//                                                       columns: columnsCount,
//                                                       children: [
//                                                         EnhancedSwitchTile(
//                                                           label:
//                                                               'Phone Communication',
//                                                           icon: Icons
//                                                               .phone_rounded,
//                                                           value:
//                                                               _phoneCommunication,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _phoneCommunication =
//                                                                       val),
//                                                         ),
//                                                         EnhancedSwitchTile(
//                                                           label:
//                                                               'Email Communication',
//                                                           icon: Icons
//                                                               .email_rounded,
//                                                           value:
//                                                               _emailCommunication,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _emailCommunication =
//                                                                       val),
//                                                         ),
//                                                         EnhancedSwitchTile(
//                                                           label:
//                                                               'WhatsApp Communication',
//                                                           icon: Icons
//                                                               .chat_rounded,
//                                                           value:
//                                                               _whatsappCommunication,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _whatsappCommunication =
//                                                                       val),
//                                                         ),
//                                                         EnhancedSwitchTile(
//                                                           label:
//                                                               'On Call Communication',
//                                                           icon: Icons.call,
//                                                           value:
//                                                               _onCallCommunication,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _onCallCommunication =
//                                                                       val),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                   const SizedBox(height: 32),
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // Form Buttons
//                                     Padding(
//                                       padding: const EdgeInsets.all(16),
//                                       child: Row(
//                                         children: [
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: CustomActionButton(
//                                               text: 'Cancel',
//                                               icon: Icons.close_rounded,
//                                               textColor: Colors.grey,
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               borderColor: Colors.grey.shade300,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             flex: 2,
//                                             child: CustomActionButton(
//                                               text: 'Save Lead',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: () async {
//                                                 if (_formKey.currentState!
//                                                     .validate()) {
//                                                   showLoaderDialog(context);
//                                                   // Convert products list to required format
//                                                   // List<Map<String, dynamic>>
//                                                   //     productsList =
//                                                   //     _productsInterested
//                                                   //         .where((product) =>
//                                                   //             (product.productId
//                                                   //                     ?.isNotEmpty ??
//                                                   //                 false) ||
//                                                   //             (product.productName
//                                                   //                     ?.isNotEmpty ??
//                                                   //                 false))
//                                                   //         .map((product) => {
//                                                   //               'product_id':
//                                                   //                   product
//                                                   //                       .productId,
//                                                   //               'product_name':
//                                                   //                   product
//                                                   //                       .productName,
//                                                   //               'offers': product
//                                                   //                   .offers
//                                                   //                   ?.map((offer) =>
//                                                   //                       offer
//                                                   //                           .toJson())
//                                                   //                   .toList(),
//                                                   //             })
//                                                   //         .toList();

//                                                   await Get.find<
//                                                           LeadController>()
//                                                       .createLead(
//                                                     context,
//                                                     LeadModel(
//                                                       name: _nameController.text
//                                                           .trim(),
//                                                       email: _emailController
//                                                           .text
//                                                           .trim(),
//                                                       phone: _mobileController
//                                                           .text
//                                                           .trim(),
//                                                       countryCode:
//                                                           _selectedPhoneCtry ??
//                                                               '+91',
//                                                       alternatePhone:
//                                                           _mobileOptionalController
//                                                                   .text
//                                                                   .trim()
//                                                                   .isNotEmpty
//                                                               ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
//                                                                   .trim()
//                                                               : "",
//                                                       whatsapp: _waMobileController
//                                                               .text
//                                                               .trim()
//                                                               .isNotEmpty
//                                                           ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}"
//                                                               .trim()
//                                                           : "",
//                                                       gender:
//                                                           _selectedGender ?? "",
//                                                       dob: _dobController.text
//                                                           .trim(),
//                                                       maritalStatus:
//                                                           _selectedMaritalStatus ??
//                                                               '',
//                                                       serviceType:
//                                                           _selectedService ??
//                                                               'LEAD',
//                                                       address:
//                                                           _addressController
//                                                               .text
//                                                               .trim(),
//                                                       city: _cityController.text
//                                                           .trim(),
//                                                       state: _stateController
//                                                           .text
//                                                           .trim(),
//                                                       country:
//                                                           _countryController
//                                                               .text
//                                                               .trim(),
//                                                       pincode:
//                                                           _pincodeController
//                                                               .text
//                                                               .trim(),
//                                                       leadSource:
//                                                           _selectedLeadSource ??
//                                                               "",
//                                                       sourceCampaign:
//                                                           _sourceCampaignController
//                                                               .text
//                                                               .trim(),
//                                                       status: _selectedStatus ??
//                                                           "NEW",
//                                                       branch:
//                                                           _selectedBranch ?? "",
//                                                       note: _noteController.text
//                                                           .trim(),
//                                                       interestedIn:
//                                                           _selectedInterestedIn,
//                                                       feedback:
//                                                           _feedbackController
//                                                               .text
//                                                               .trim(),
//                                                       loanRequired:
//                                                           _loanRequired,
//                                                       loanAmountRequired:
//                                                           _loanAmountController
//                                                                   .text
//                                                                   .trim()
//                                                                   .isNotEmpty
//                                                               ? int.tryParse(
//                                                                   _loanAmountController
//                                                                       .text
//                                                                       .trim())
//                                                               : null,
//                                                       onCallCommunication:
//                                                           _onCallCommunication,
//                                                       phoneCommunication:
//                                                           _phoneCommunication,
//                                                       emailCommunication:
//                                                           _emailCommunication,
//                                                       whatsappCommunication:
//                                                           _whatsappCommunication,
//                                                       officerId:
//                                                           _selectedOfficer ??
//                                                               "",
//                                                       productInterested:
//                                                           _productsInterested,
//                                                       budget: _budgetController
//                                                               .text
//                                                               .trim()
//                                                               .isNotEmpty
//                                                           ? int.tryParse(
//                                                               _budgetController
//                                                                   .text
//                                                                   .trim())
//                                                           : null,
//                                                       preferredLocation:
//                                                           _preferredLocationController
//                                                               .text
//                                                               .trim(),
//                                                       preferredDate:
//                                                           _preferredDateController
//                                                               .text
//                                                               .trim(),
//                                                     ),
//                                                   );
//                                                 }
//                                                 Navigator.pop(context);
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 24),
//                             // Side Panel (visible only on large screens)
//                             if (maxWidth > 1000)
//                               Container(
//                                 width: MediaQuery.of(context).size.width * .2,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: [
//                                       AppColors.violetPrimaryColor
//                                           .withOpacity(0.08),
//                                       AppColors.blueSecondaryColor
//                                           .withOpacity(0.04),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                       color: AppColors.violetPrimaryColor
//                                           .withOpacity(0.15)),
//                                 ),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(24),
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(16),
//                                               decoration: BoxDecoration(
//                                                 color: AppColors
//                                                     .violetPrimaryColor
//                                                     .withOpacity(0.1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               child: Icon(
//                                                 Icons.person_add_alt_1_rounded,
//                                                 size: 40,
//                                                 color: AppColors
//                                                     .violetPrimaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             const FittedBox(
//                                               fit: BoxFit.scaleDown,
//                                               child: CustomText(
//                                                 text:
//                                                     'Communication Preferences',
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             const CustomText(
//                                               text:
//                                                   'Fill all required fields to add new lead',
//                                               fontSize: 13,
//                                               color: Colors.grey,
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(24),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   padding:
//                                                       const EdgeInsets.all(8),
//                                                   decoration: BoxDecoration(
//                                                     color: AppColors
//                                                         .violetPrimaryColor
//                                                         .withOpacity(0.1),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                   child: Icon(
//                                                     Icons
//                                                         .notifications_active_rounded,
//                                                     size: 20,
//                                                     color: AppColors
//                                                         .violetPrimaryColor,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 12),
//                                                 const Expanded(
//                                                   child: CustomText(
//                                                     maxline: true,
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     text:
//                                                         'Communication Preferences',
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                     color:
//                                                         AppColors.primaryColor,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 20),
//                                             Column(
//                                               children: [
//                                                 EnhancedSwitchTile(
//                                                   label:
//                                                       'On Call Communication',
//                                                   icon: Icons.call,
//                                                   value: _onCallCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _onCallCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label: 'Phone Communication',
//                                                   icon: Icons.phone_rounded,
//                                                   value: _phoneCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _phoneCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label: 'Email Communication',
//                                                   icon: Icons.email_rounded,
//                                                   value: _emailCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _emailCommunication =
//                                                               val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label:
//                                                       'WhatsApp Communication',
//                                                   icon: Icons.chat_rounded,
//                                                   value: _whatsappCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _whatsappCommunication =
//                                                               val),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
