// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/lead/lead_controller.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/model/lead/lead_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// import '../../../../model/lead/academic_record_model.dart';
// import '../../../../model/lead/document_record_model.dart';
// import '../../../../model/lead/exam_record_model.dart';
// import '../../../../model/lead/travel_record_model.dart' show TravelRecordModel;
// import '../../../../model/lead/work_record_model.dart';

// class DetailedAddEditLeadScreen extends StatefulWidget {
//   final LeadModel? lead;
//   final bool isEditMode;

//   const DetailedAddEditLeadScreen(
//       {super.key, this.lead, required this.isEditMode});

//   @override
//   State<DetailedAddEditLeadScreen> createState() =>
//       _DetailedAddEditLeadScreenState();
// }

// class _DetailedAddEditLeadScreenState extends State<DetailedAddEditLeadScreen>
//     with SingleTickerProviderStateMixin {
//   final configController = Get.find<ConfigController>();
//   final officersController = Get.find<OfficersController>();
//   final leadController = Get.find<LeadController>();
//   final _formKey = GlobalKey<FormState>();
//   final ScrollController _scrollController = ScrollController();

//   // Tab Controller
//   late TabController _tabController;

//   // Form controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
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
//   final TextEditingController _budgetController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();
//   final TextEditingController _preferredLocationController =
//       TextEditingController();
//   final TextEditingController _loanAmountController = TextEditingController();
//   final TextEditingController _numberOfTravelersController =
//       TextEditingController();
//   final TextEditingController _travelDurationController =
//       TextEditingController();
//   final TextEditingController _downPaymentController = TextEditingController();
//   final TextEditingController _totalPeoplesController = TextEditingController();

//   // Professional Information Controllers
//   final TextEditingController _expectedSalaryController =
//       TextEditingController();
//   final TextEditingController _qualificationController =
//       TextEditingController();
//   final TextEditingController _experienceController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();
//   final TextEditingController _annualIncomeController = TextEditingController();
//   final TextEditingController _panCardController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _creditScoreController = TextEditingController();

//   // Personal Details Controllers
//   final TextEditingController _birthCountryController = TextEditingController();
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

//   // Education Specific Controllers
//   final TextEditingController _yearOfPassingController =
//       TextEditingController();
//   final TextEditingController _fieldOfStudyController = TextEditingController();
//   final TextEditingController _percentageController = TextEditingController();

//   // Migration Specific Controllers
//   final TextEditingController _preferredSettlementCityController =
//       TextEditingController();
//   final TextEditingController _relativeCountryController =
//       TextEditingController();
//   final TextEditingController _relativeRelationController =
//       TextEditingController();

//   // Form values
//   String? _selectedService = 'TRAVEL';
//   String? _selectedGender;
//   String? _selectedMaritalStatus;
//   String? _selectedPhoneCtry = "+91";
//   String? _selectedAltPhoneCtry = "+91";
//   String? _selectedWAPhoneCtry = "+91";
//   String? _selectedLeadSource;
//   String? _selectedSourceCampaign;
//   String? _selectedStatus = 'NEW';
//   String? _selectedAgent;
//   String? _selectedProfession;
//   String? _selectedEmploymentStatus;

//   // Multi-select
//   List<String> selectedCountries = [];
//   List<String>? _selectedProductInterest;
//   List<String>? _selectedSpecialized;
//   List<String>? _selectedJobInterests;
//   List<String>? _selectedSkills;
//   List<String>? _selectedCoursesInterested;
//   List<String>? _selectedVisitedCountries;

//   // Preferences
//   bool _phoneCommunication = true;
//   bool _emailCommunication = false;
//   bool _whatsappCommunication = false;
//   bool _onCallCommunication = false;
//   bool _requiresLoan = false;
//   bool _hasExistingLoans = false;
//   bool _requiresTravelInsurance = false;
//   bool _requiresHotelBooking = false;
//   bool _requiresFlightBooking = false;
//   bool _hasRelativesAbroad = false;
//   bool _requiresJobAssistance = false;

//   // Service Specific Fields
//   // Travel
//   String? _selectedTravelPurpose;
//   String? _selectedAccommodationPreference;
//   String? _selectedVisaType;

//   // Education
//   String? _selectedStudyMode;
//   String? _selectedBatch;
//   String? _selectedHighestQualification;

//   // Vehicle
//   String? _selectedVehicleType;
//   String? _selectedBrandPreference;
//   String? _selectedModelPreference;
//   String? _selectedFuelType;
//   String? _selectedTransmission;
//   String? _selectedInsuranceType;

//   // Real Estate
//   String? _selectedPropertyType;
//   String? _selectedPropertyUse;
//   String? _selectedPossessionTimeline;
//   String? _selectedFurnishingPreference;
//   String? _selectedGroupType;
//   bool _requiresLegalAssistance = false;

//   // Migration
//   String? _selectedTargetVisaType;

//   DateTime? _preferredDate;
//   DateTime? _nextFollowUpDate;
//   DateTime? _lastContactDate;
//   DateTime? _nextSchedule;
//   int _selectedPriority = 3;

//   // Records Lists
//   List<AcademicRecordModel> _academicRecords = [];
//   List<ExamRecordModel> _examRecords = [];
//   List<TravelRecordModel> _travelRecords = [];
//   List<WorkRecordModel> _workRecords = [];
//   List<DocumentRecordModel> _documents = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _initializeForm();
//     _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await officersController.fetchOfficersList();
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//   }

//   void _initializeForm() {
//     if (widget.isEditMode && widget.lead != null) {
//       final lead = widget.lead!;

//       // Basic Information
//       _nameController.text = lead.name ?? '';
//       _lastNameController.text = lead.lastName ?? '';
//       _emailController.text = lead.email ?? '';
//       _mobileController.text = lead.phone ?? '';

//       // Contact Information
//       if (lead.whatsapp != null && lead.whatsapp!.isNotEmpty) {
//         final whatsappParts = lead.whatsapp!.split(' ');
//         if (whatsappParts.length > 1) {
//           _selectedWAPhoneCtry = whatsappParts.first;
//           _waMobileController.text = whatsappParts.sublist(1).join(' ');
//         }
//       }
//       if (lead.alternatePhone != null && lead.alternatePhone!.isNotEmpty) {
//         final altPhoneParts = lead.alternatePhone!.split(' ');
//         if (altPhoneParts.length > 1) {
//           _selectedAltPhoneCtry = altPhoneParts.first;
//           _mobileOptionalController.text = altPhoneParts.sublist(1).join(' ');
//         }
//       }

//       // Personal Details
//       _selectedGender = lead.gender;
//       _selectedMaritalStatus = lead.maritalStatus;
//       _dobController.text = lead.dob ?? '';

//       // Address
//       _addressController.text = lead.address ?? '';
//       _cityController.text = lead.city ?? '';
//       _stateController.text = lead.state ?? '';
//       _countryController.text = lead.country ?? '';
//       _pincodeController.text = lead.pincode ?? '';

//       // Lead Details
//       _selectedLeadSource = lead.leadSource;
//       _selectedSourceCampaign = lead.sourceCampaign;
//       _selectedStatus = lead.status;
//       selectedCountries = lead.countryInterested ?? [];
//       _selectedProductInterest = lead.productInterest;
//       _selectedAgent = lead.assignedTo;
//       _budgetController.text = lead.budget?.toString() ?? '';
//       _preferredLocationController.text = lead.preferredLocation ?? '';
//       _notesController.text = lead.note ?? '';
//       _selectedService = lead.serviceType;

//       // Preferences
//       _phoneCommunication = lead.phoneCommunication ?? true;
//       _emailCommunication = lead.emailCommunication ?? false;
//       _whatsappCommunication = lead.whatsappCommunication ?? false;
//       _onCallCommunication = lead.onCallCommunication ?? false;
//       _requiresLoan = lead.requiresHomeLoan ?? false;
//       _loanAmountController.text = lead.loanAmountRequired?.toString() ?? '';

//       // Professional Information
//       _selectedJobInterests = lead.jobInterests;
//       _expectedSalaryController.text = lead.expectedSalary?.toString() ?? '';
//       _qualificationController.text = lead.qualification ?? '';
//       _experienceController.text = lead.experience?.toString() ?? '';
//       _selectedSkills = lead.skills;
//       _selectedProfession = lead.profession;
//       _selectedEmploymentStatus = lead.employmentStatus;
//       _annualIncomeController.text = lead.annualIncome?.toString() ?? '';
//       _panCardController.text = lead.panCardNumber ?? '';
//       _gstController.text = lead.gstNumber ?? '';
//       _hasExistingLoans = lead.hasExistingLoans ?? false;
//       _creditScoreController.text = lead.creditScore?.toString() ?? '';

//       // Personal Details
//       _birthCountryController.text = lead.birthCountry ?? '';
//       _birthPlaceController.text = lead.birthPlace ?? '';
//       _emailPasswordController.text = lead.emailPassword ?? '';
//       _emergencyContactController.text = lead.emergencyContact ?? '';
//       _passportNumberController.text = lead.passportNumber ?? '';
//       _passportExpiryController.text = lead.passportExpiryDate ?? '';
//       _religionController.text = lead.religion ?? '';
//       _jobGapController.text = lead.jobGapMonths?.toString() ?? '';
//       _firstJobDateController.text = lead.firstJobDate != null
//           ? DateFormat('dd/MM/yyyy').format(lead.firstJobDate!)
//           : '';

//       // Service Specific Initialization
//       _initializeServiceSpecificFields(lead);

//       // Records
//       _academicRecords = lead.academicRecords ?? [];
//       _examRecords = lead.examRecords ?? [];
//       _travelRecords = lead.travelRecords ?? [];
//       _workRecords = lead.workRecords ?? [];
//       _documents = lead.documents ?? [];

//       // Dates
//       _nextFollowUpDate = lead.nextFollowUpDate;
//       _lastContactDate = lead.lastContactDate;
//       _nextSchedule = lead.nextSchedule;
//     }
//   }

//   void _initializeServiceSpecificFields(LeadModel lead) {
//     switch (_selectedService) {
//       case 'TRAVEL':
//         _selectedTravelPurpose = lead.travelPurpose;
//         _selectedAccommodationPreference = lead.accommodationPreference;
//         _selectedVisaType = lead.visaTypeRequired;
//         _numberOfTravelersController.text =
//             lead.numberOfTravelers?.toString() ?? '';
//         _travelDurationController.text = lead.travelDuration?.toString() ?? '';
//         _requiresTravelInsurance = lead.requiresTravelInsurance ?? false;
//         _requiresHotelBooking = lead.requiresHotelBooking ?? false;
//         _requiresFlightBooking = lead.requiresFlightBooking ?? false;
//         _selectedVisitedCountries = lead.visitedCountries;
//         break;
//       case 'EDUCATION':
//         _selectedStudyMode = lead.preferredStudyMode;
//         _selectedBatch = lead.batchPreference;
//         _selectedHighestQualification = lead.highestQualification;
//         _yearOfPassingController.text = lead.yearOfPassing?.toString() ?? '';
//         _fieldOfStudyController.text = lead.fieldOfStudy ?? '';
//         _percentageController.text = lead.percentageOrCGPA?.toString() ?? '';
//         _selectedCoursesInterested = lead.coursesInterested;
//         break;
//       case 'VEHICLE':
//         _selectedVehicleType = lead.vehicleType;
//         _selectedBrandPreference = lead.brandPreference;
//         _selectedModelPreference = lead.modelPreference;
//         _selectedFuelType = lead.fuelType;
//         _selectedTransmission = lead.transmission;
//         _selectedInsuranceType = lead.insuranceType;
//         _downPaymentController.text =
//             lead.downPaymentAvailable?.toString() ?? '';
//         break;
//       case 'REAL_ESTATE':
//         _selectedPropertyType = lead.propertyType;
//         _selectedPropertyUse = lead.propertyUse;
//         _selectedPossessionTimeline = lead.possessionTimeline;
//         _selectedFurnishingPreference = lead.furnishingPreference;
//         _selectedGroupType = lead.groupType;
//         _totalPeoplesController.text = lead.totalPeoples ?? '';
//         _requiresLegalAssistance = lead.requiresLegalAssistance ?? false;
//         break;
//       case 'MIGRATION':
//         _selectedTargetVisaType = lead.targetVisaType;
//         _hasRelativesAbroad = lead.hasRelativesAbroad ?? false;
//         _relativeCountryController.text = lead.relativeCountry ?? '';
//         _relativeRelationController.text = lead.relativeRelation ?? '';
//         _requiresJobAssistance = lead.requiresJobAssistance ?? false;
//         _preferredSettlementCityController.text =
//             lead.preferredSettlementCity ?? '';
//         break;
//     }
//   }

//   void _saveLead() async {
//     if (_formKey.currentState!.validate()) {
//       showLoaderDialog(context);

//       final lead = LeadModel(
//         sId: widget.lead?.sId,
//         // Core Information
//         name: _nameController.text.trim(),
//         lastName: _lastNameController.text.trim(),
//         email: _emailController.text.trim(),
//         phone: _mobileController.text.trim(),
//         countryCode: _selectedPhoneCtry ?? '',
//         alternatePhone: _mobileOptionalController.text.trim().isNotEmpty
//             ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
//                 .trim()
//             : "",
//         whatsapp: _waMobileController.text.trim().isNotEmpty
//             ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}".trim()
//             : "",

//         // Personal Details
//         gender: _selectedGender,
//         dob: _dobController.text.trim(),
//         maritalStatus: _selectedMaritalStatus,

//         // Address
//         address: _addressController.text.trim(),
//         city: _cityController.text.trim(),
//         state: _stateController.text.trim(),
//         country: _countryController.text.trim(),
//         pincode: _pincodeController.text.trim(),

//         // Lead Management
//         leadSource: _selectedLeadSource,
//         sourceCampaign: _selectedSourceCampaign,
//         status: _selectedStatus,
//         serviceType: _selectedService,
//         assignedTo: _selectedAgent,
//         branch: "AFFINIX",

//         // Preferences & Interests
//         countryInterested: selectedCountries,
//         productInterest: _selectedProductInterest,
//         budget: double.tryParse(_budgetController.text.trim()),
//         preferredLocation: _preferredLocationController.text.trim(),
//         preferredDate: _preferredDate,
//         note: _notesController.text.trim(),

//         // Communication Preferences
//         phoneCommunication: _phoneCommunication,
//         emailCommunication: _emailCommunication,
//         whatsappCommunication: _whatsappCommunication,
//         onCallCommunication: _onCallCommunication,

//         // Loan Information
//         requiresHomeLoan: _requiresLoan,
//         loanAmountRequired: double.tryParse(_loanAmountController.text.trim()),
//         createdAt: widget.lead?.createdAt ?? DateTime.now(),
//         updatedAt: DateTime.now(),

//         // Professional Information
//         jobInterests: _selectedJobInterests,
//         expectedSalary: int.tryParse(_expectedSalaryController.text.trim()),
//         qualification: _qualificationController.text.trim(),
//         experience: int.tryParse(_experienceController.text.trim()),
//         skills: _selectedSkills,
//         profession: _selectedProfession,
//         employmentStatus: _selectedEmploymentStatus,
//         annualIncome: double.tryParse(_annualIncomeController.text.trim()),
//         panCardNumber: _panCardController.text.trim(),
//         gstNumber: _gstController.text.trim(),
//         hasExistingLoans: _hasExistingLoans,
//         creditScore: int.tryParse(_creditScoreController.text.trim()),

//         // Personal Details
//         birthCountry: _birthCountryController.text.trim(),
//         birthPlace: _birthPlaceController.text.trim(),
//         emailPassword: _emailPasswordController.text.trim(),
//         emergencyContact: _emergencyContactController.text.trim(),
//         passportNumber: _passportNumberController.text.trim(),
//         passportExpiryDate: _passportExpiryController.text.trim(),
//         religion: _religionController.text.trim(),
//         jobGapMonths: int.tryParse(_jobGapController.text.trim()),
//         firstJobDate: _firstJobDateController.text.trim().isNotEmpty
//             ? DateFormat('dd/MM/yyyy')
//                 .parse(_firstJobDateController.text.trim())
//             : null,

//         // Records
//         academicRecords: _academicRecords,
//         examRecords: _examRecords,
//         travelRecords: _travelRecords,
//         workRecords: _workRecords,
//         documents: _documents,

//         // Dates
//         nextFollowUpDate: _nextFollowUpDate,
//         lastContactDate: _lastContactDate,
//         nextSchedule: _nextSchedule,

//         // Service Specific Fields
//         travelPurpose:
//             _selectedService == 'TRAVEL' ? _selectedTravelPurpose : null,
//         accommodationPreference: _selectedService == 'TRAVEL'
//             ? _selectedAccommodationPreference
//             : null,
//         visaTypeRequired:
//             _selectedService == 'TRAVEL' ? _selectedVisaType : null,
//         numberOfTravelers: _selectedService == 'TRAVEL'
//             ? int.tryParse(_numberOfTravelersController.text.trim())
//             : null,
//         travelDuration: _selectedService == 'TRAVEL'
//             ? int.tryParse(_travelDurationController.text.trim())
//             : null,
//         requiresTravelInsurance:
//             _selectedService == 'TRAVEL' ? _requiresTravelInsurance : null,
//         requiresHotelBooking:
//             _selectedService == 'TRAVEL' ? _requiresHotelBooking : null,
//         requiresFlightBooking:
//             _selectedService == 'TRAVEL' ? _requiresFlightBooking : null,
//         visitedCountries:
//             _selectedService == 'TRAVEL' ? _selectedVisitedCountries : null,

//         preferredStudyMode:
//             _selectedService == 'EDUCATION' ? _selectedStudyMode : null,
//         batchPreference:
//             _selectedService == 'EDUCATION' ? _selectedBatch : null,
//         highestQualification: _selectedService == 'EDUCATION'
//             ? _selectedHighestQualification
//             : null,
//         yearOfPassing: _selectedService == 'EDUCATION'
//             ? int.tryParse(_yearOfPassingController.text.trim())
//             : null,
//         fieldOfStudy: _selectedService == 'EDUCATION'
//             ? _fieldOfStudyController.text.trim()
//             : null,
//         percentageOrCGPA: _selectedService == 'EDUCATION'
//             ? double.tryParse(_percentageController.text.trim())
//             : null,
//         coursesInterested:
//             _selectedService == 'EDUCATION' ? _selectedCoursesInterested : null,

//         vehicleType:
//             _selectedService == 'VEHICLE' ? _selectedVehicleType : null,
//         brandPreference:
//             _selectedService == 'VEHICLE' ? _selectedBrandPreference : null,
//         modelPreference:
//             _selectedService == 'VEHICLE' ? _selectedModelPreference : null,
//         fuelType: _selectedService == 'VEHICLE' ? _selectedFuelType : null,
//         transmission:
//             _selectedService == 'VEHICLE' ? _selectedTransmission : null,
//         insuranceType:
//             _selectedService == 'VEHICLE' ? _selectedInsuranceType : null,
//         downPaymentAvailable: _selectedService == 'VEHICLE'
//             ? double.tryParse(_downPaymentController.text.trim())
//             : null,

//         propertyType:
//             _selectedService == 'REAL_ESTATE' ? _selectedPropertyType : null,
//         propertyUse:
//             _selectedService == 'REAL_ESTATE' ? _selectedPropertyUse : null,
//         possessionTimeline: _selectedService == 'REAL_ESTATE'
//             ? _selectedPossessionTimeline
//             : null,
//         furnishingPreference: _selectedService == 'REAL_ESTATE'
//             ? _selectedFurnishingPreference
//             : null,
//         groupType:
//             _selectedService == 'REAL_ESTATE' ? _selectedGroupType : null,
//         totalPeoples: _selectedService == 'REAL_ESTATE'
//             ? _totalPeoplesController.text.trim()
//             : null,
//         requiresLegalAssistance:
//             _selectedService == 'REAL_ESTATE' ? _requiresLegalAssistance : null,

//         targetVisaType:
//             _selectedService == 'MIGRATION' ? _selectedTargetVisaType : null,
//         hasRelativesAbroad:
//             _selectedService == 'MIGRATION' ? _hasRelativesAbroad : null,
//         relativeCountry: _selectedService == 'MIGRATION'
//             ? _relativeCountryController.text.trim()
//             : null,
//         relativeRelation: _selectedService == 'MIGRATION'
//             ? _relativeRelationController.text.trim()
//             : null,
//         requiresJobAssistance:
//             _selectedService == 'MIGRATION' ? _requiresJobAssistance : null,
//         preferredSettlementCity: _selectedService == 'MIGRATION'
//             ? _preferredSettlementCityController.text.trim()
//             : null,
//       );

//       if (widget.isEditMode) {
//         // await leadController.updateLead(context, lead);
//       } else {
//         await leadController.createLead(context, lead);
//       }

//       if (mounted) {
//         Navigator.of(context).pop(); // Close loader
//         Navigator.of(context).pop(); // Close dialog
//       }
//     }
//   }

//   Widget _buildBasicInformationTab() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth;
//         int columnsCount = availableWidth > 1000
//             ? 3
//             : availableWidth > 600
//                 ? 2
//                 : 1;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Service Type & Lead Source
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomDropdownField(
//                       label: 'Service Type *',
//                       value: _selectedService,
//                       items: const [
//                         'TRAVEL',
//                         'EDUCATION',
//                         'VEHICLE',
//                         'REAL_ESTATE',
//                         'MIGRATION'
//                       ],
//                       onChanged: (value) =>
//                           setState(() => _selectedService = value),
//                       isRequired: true,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: CustomDropdownField(
//                       label: 'Lead Source *',
//                       value: _selectedLeadSource,
//                       items: configController.configData.value.leadSource
//                               ?.map((e) => e.name ?? "")
//                               .toList() ??
//                           [],
//                       onChanged: (value) =>
//                           setState(() => _selectedLeadSource = value),
//                       isRequired: true,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Source Campaign & Status
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomDropdownField(
//                       label: 'Source Campaign',
//                       value: _selectedSourceCampaign,
//                       items: const [
//                         'WEBSITE',
//                         'SOCIAL_MEDIA',
//                         'REFERRAL',
//                         'DIRECT',
//                         'OTHER'
//                       ],
//                       onChanged: (value) =>
//                           setState(() => _selectedSourceCampaign = value),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: CustomDropdownField(
//                       label: 'Status *',
//                       value: _selectedStatus,
//                       items: const [
//                         'NEW',
//                         'CONTACTED',
//                         'QUALIFIED',
//                         'PROPOSAL_SENT',
//                         'NEGOTIATION',
//                         'WON',
//                         'LOST'
//                       ],
//                       onChanged: (value) =>
//                           setState(() => _selectedStatus = value),
//                       isRequired: true,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               const SectionTitle(
//                   title: 'Primary Details', icon: Icons.person_outline_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'First Name *',
//                     controller: _nameController,
//                     isRequired: true,
//                   ),
//                   CustomTextFormField(
//                     label: 'Last Name',
//                     controller: _lastNameController,
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
//                     label: 'Email ID *',
//                     controller: _emailController,
//                     isEmail: true,
//                     isRequired: true,
//                   ),
//                   CustomPhoneField(
//                     label: 'Whatsapp Number',
//                     controller: _waMobileController,
//                     selectedCountry: _selectedWAPhoneCtry,
//                     onCountryChanged: (val) =>
//                         setState(() => _selectedWAPhoneCtry = val),
//                   ),
//                   CustomPhoneField(
//                     label: 'Alternate Mobile',
//                     controller: _mobileOptionalController,
//                     selectedCountry: _selectedAltPhoneCtry,
//                     onCountryChanged: (val) =>
//                         setState(() => _selectedAltPhoneCtry = val),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               const SectionTitle(
//                   title: 'Personal Details', icon: Icons.person_pin_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomDropdownField(
//                     label: 'Gender',
//                     value: _selectedGender,
//                     items: const ['Male', 'Female', 'Other'],
//                     onChanged: (val) => setState(() => _selectedGender = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Marital Status',
//                     value: _selectedMaritalStatus,
//                     items: const ['Single', 'Married', 'Divorced', 'Widowed'],
//                     onChanged: (val) =>
//                         setState(() => _selectedMaritalStatus = val),
//                   ),
//                   CustomDateField(
//                     label: 'Date of Birth',
//                     controller: _dobController,
//                     endDate:
//                         DateTime.now().subtract(const Duration(days: 365 * 18)),
//                     onChanged: (formattedDate) =>
//                         _dobController.text = formattedDate,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               const SectionTitle(
//                   title: 'Address Information',
//                   icon: Icons.location_on_rounded),
//               const SizedBox(height: 16),
//               CustomTextFormField(
//                 label: 'Address',
//                 controller: _addressController,
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
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
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Service Specific Fields
//               _buildServiceSpecificFields(),
//               const SizedBox(height: 24),

//               // Additional Notes
//               const SectionTitle(
//                   title: 'Additional Information', icon: Icons.note_rounded),
//               const SizedBox(height: 16),
//               CustomTextFormField(
//                 label: 'Notes',
//                 controller: _notesController,
//                 maxLines: 4,
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfessionalDetailsTab() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth;
//         int columnsCount = availableWidth > 1000
//             ? 3
//             : availableWidth > 600
//                 ? 2
//                 : 1;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                   title: 'Professional Information', icon: Icons.work_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomCheckDropdown(
//                     label: 'Job Interests',
//                     items: const [
//                       'IT',
//                       'Healthcare',
//                       'Engineering',
//                       'Finance',
//                       'Education',
//                       'Hospitality'
//                     ],
//                     values: _selectedJobInterests ?? [],
//                     onChanged: (value) => setState(
//                         () => _selectedJobInterests = value.cast<String>()),
//                   ),
//                   CustomTextFormField(
//                     label: 'Expected Salary',
//                     controller: _expectedSalaryController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Qualification',
//                     controller: _qualificationController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Experience (years)',
//                     controller: _experienceController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomCheckDropdown(
//                     label: 'Skills',
//                     items: const [
//                       'Communication',
//                       'Technical',
//                       'Management',
//                       'Sales',
//                       'Marketing'
//                     ],
//                     values: _selectedSkills ?? [],
//                     onChanged: (value) =>
//                         setState(() => _selectedSkills = value.cast<String>()),
//                   ),
//                   CustomDropdownField(
//                     label: 'Profession',
//                     value: _selectedProfession,
//                     items: const [
//                       'Doctor',
//                       'Engineer',
//                       'Teacher',
//                       'Business',
//                       'Student',
//                       'Other'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedProfession = val),
//                   ),
//                   CustomDropdownField(
//                     label: 'Employment Status',
//                     value: _selectedEmploymentStatus,
//                     items: const [
//                       'SALARIED',
//                       'SELF_EMPLOYED',
//                       'BUSINESS',
//                       'STUDENT',
//                       'UNEMPLOYED'
//                     ],
//                     onChanged: (val) =>
//                         setState(() => _selectedEmploymentStatus = val),
//                   ),
//                   CustomTextFormField(
//                     label: 'Annual Income',
//                     controller: _annualIncomeController,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               const SectionTitle(
//                   title: 'Financial Information',
//                   icon: Icons.attach_money_rounded),
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
//                     icon: Icons.credit_card_rounded,
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
//               const SizedBox(height: 24),
//               const SectionTitle(
//                   title: 'Additional Personal Details',
//                   icon: Icons.person_add_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomTextFormField(
//                     label: 'Birth Country',
//                     controller: _birthCountryController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Birth Place',
//                     controller: _birthPlaceController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Email Password',
//                     controller: _emailPasswordController,
//                     obscureText: true,
//                   ),
//                   CustomTextFormField(
//                     label: 'Emergency Contact',
//                     controller: _emergencyContactController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Passport Number',
//                     controller: _passportNumberController,
//                   ),
//                   CustomDateField(
//                     label: 'Passport Expiry Date',
//                     controller: _passportExpiryController,
//                     onChanged: (formattedDate) =>
//                         _passportExpiryController.text = formattedDate,
//                   ),
//                   CustomTextFormField(
//                     label: 'Religion',
//                     controller: _religionController,
//                   ),
//                   CustomTextFormField(
//                     label: 'Job Gap (months)',
//                     controller: _jobGapController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomDateField(
//                     label: 'First Job Date',
//                     controller: _firstJobDateController,
//                     onChanged: (formattedDate) =>
//                         _firstJobDateController.text = formattedDate,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPreferencesTab() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth;
//         int columnsCount = availableWidth > 1000
//             ? 3
//             : availableWidth > 600
//                 ? 2
//                 : 1;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SectionTitle(
//                   title: 'Lead Preferences', icon: Icons.interests_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomCheckDropdown(
//                     label: 'Countries Interested',
//                     items: configController.configData.value.country
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         [],
//                     values: selectedCountries,
//                     onChanged: (value) => setState(
//                         () => selectedCountries = value.cast<String>()),
//                   ),
//                   CustomCheckDropdown(
//                     label: 'Product Interest',
//                     items: configController.configData.value.specialized
//                             ?.map((e) => e.name ?? "")
//                             .toList() ??
//                         [],
//                     values: _selectedProductInterest ?? [],
//                     onChanged: (value) => setState(
//                         () => _selectedProductInterest = value.cast<String>()),
//                   ),
//                   CustomTextFormField(
//                     label: 'Budget',
//                     controller: _budgetController,
//                     keyboardType: TextInputType.number,
//                   ),
//                   CustomTextFormField(
//                     label: 'Preferred Location',
//                     controller: _preferredLocationController,
//                   ),
//                   CustomDateField(
//                     label: 'Preferred Date',
//                     controller: TextEditingController(
//                       text: _preferredDate != null
//                           ? DateFormat('dd/MM/yyyy').format(_preferredDate!)
//                           : '',
//                     ),
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         setState(() {
//                           _preferredDate =
//                               DateFormat('dd/MM/yyyy').parse(value);
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               const SectionTitle(
//                   title: 'Loan Requirements', icon: Icons.attach_money_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   EnhancedSwitchTile(
//                     label: 'Requires Loan',
//                     icon: Icons.money_rounded,
//                     value: _requiresLoan,
//                     onChanged: (val) => setState(() => _requiresLoan = val),
//                   ),
//                   if (_requiresLoan)
//                     CustomTextFormField(
//                       label: 'Loan Amount Required',
//                       controller: _loanAmountController,
//                       keyboardType: TextInputType.number,
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               const SectionTitle(
//                   title: 'Assignment', icon: Icons.assignment_rounded),
//               const SizedBox(height: 16),
//               ResponsiveGrid(
//                 columns: columnsCount,
//                 children: [
//                   CustomOfficerDropDown(
//                     label: 'Assigned To',
//                     value: _selectedAgent,
//                     items: officersController.officersList
//                         .map((e) => e.name ?? "")
//                         .toList(),
//                     onChanged: (p0) => setState(
//                         () => _selectedAgent = p0?.split(",").last ?? ""),
//                     isSplit: true,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Priority *',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       DropdownButtonFormField<int>(
//                         value: _selectedPriority,
//                         items: [1, 2, 3, 4, 5].map((priority) {
//                           return DropdownMenuItem<int>(
//                             value: priority,
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.flag,
//                                   color: AppColors.getPriorityColor(priority),
//                                   size: 16,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text('Priority $priority'),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (value) =>
//                             setState(() => _selectedPriority = value!),
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                   CustomDateField(
//                     label: 'Next Follow-up Date',
//                     controller: TextEditingController(
//                       text: _nextFollowUpDate != null
//                           ? DateFormat('dd/MM/yyyy').format(_nextFollowUpDate!)
//                           : '',
//                     ),
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         setState(() {
//                           _nextFollowUpDate =
//                               DateFormat('dd/MM/yyyy').parse(value);
//                         });
//                       }
//                     },
//                   ),
//                   CustomDateField(
//                     label: 'Next Schedule',
//                     controller: TextEditingController(
//                       text: _nextSchedule != null
//                           ? DateFormat('dd/MM/yyyy').format(_nextSchedule!)
//                           : '',
//                     ),
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         setState(() {
//                           _nextSchedule = DateFormat('dd/MM/yyyy').parse(value);
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Keep your existing service specific field builders (_buildTravelFields, _buildEducationFields, etc.)
//   // They remain the same as in your original code...

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     // Dispose all controllers...
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
//                           child: Icon(
//                             widget.isEditMode
//                                 ? Icons.edit_rounded
//                                 : Icons.leaderboard_rounded,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text: widget.isEditMode
//                                     ? 'Edit Lead'
//                                     : 'Add New Lead',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               CustomText(
//                                 text: widget.isEditMode
//                                     ? 'Update lead information and preferences'
//                                     : 'Capture lead details for follow up',
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
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade50,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       labelColor: AppColors.primaryColor,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: AppColors.primaryColor,
//                       indicatorWeight: 3,
//                       tabs: const [
//                         Tab(
//                           icon: Icon(Icons.person_outline, size: 20),
//                           text: 'Basic Info',
//                         ),
//                         Tab(
//                           icon: Icon(Icons.work_outline, size: 20),
//                           text: 'Professional',
//                         ),
//                         Tab(
//                           icon: Icon(Icons.settings, size: 20),
//                           text: 'Preferences',
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
//                             // Main Form with Tabs
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
//                                           _buildBasicInformationTab(),
//                                           _buildProfessionalDetailsTab(),
//                                           _buildPreferencesTab(),
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
//                                               text: widget.isEditMode
//                                                   ? 'Update Lead'
//                                                   : 'Save Lead',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: _saveLead,
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
//                                                 widget.isEditMode
//                                                     ? Icons.edit_rounded
//                                                     : Icons
//                                                         .person_add_alt_1_rounded,
//                                                 size: 40,
//                                                 color: AppColors
//                                                     .violetPrimaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 12),
//                                             FittedBox(
//                                               fit: BoxFit.scaleDown,
//                                               child: CustomText(
//                                                 text:
//                                                     'Communication Preferences',
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             CustomText(
//                                               text: widget.isEditMode
//                                                   ? 'Update communication preferences'
//                                                   : 'Choose how to communicate with this lead',
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
//                                                       Icons
//                                                           .notifications_active_rounded,
//                                                       size: 20,
//                                                       color: AppColors
//                                                           .violetPrimaryColor),
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
//                                                   label:
//                                                       'On call Communication',
//                                                   icon: Icons.call,
//                                                   value: _onCallCommunication,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _onCallCommunication =
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

//   Widget _buildServiceSpecificFields() {
//     switch (_selectedService) {
//       case 'TRAVEL':
//         return _buildTravelFields();
//       case 'EDUCATION':
//         return _buildEducationFields();
//       case 'VEHICLE':
//         return _buildVehicleFields();
//       case 'REAL_ESTATE':
//         return _buildRealEstateFields();
//       case 'MIGRATION':
//         return _buildMigrationFields();
//       default:
//         return const SizedBox();
//     }
//   }

//   Widget _buildTravelFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//             title: 'Travel Details', icon: Icons.flight_takeoff_rounded),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             CustomDropdownField(
//               label: 'Travel Purpose',
//               value: _selectedTravelPurpose,
//               items: const [
//                 'BUSINESS',
//                 'HONEYMOON',
//                 'FAMILY',
//                 'FRIENDS',
//                 'SOLO'
//               ],
//               onChanged: (val) => setState(() => _selectedTravelPurpose = val),
//             ),
//             CustomTextFormField(
//               label: 'Number of Travelers',
//               controller: _numberOfTravelersController,
//               keyboardType: TextInputType.number,
//             ),
//             CustomDropdownField(
//               label: 'Accommodation Preference',
//               value: _selectedAccommodationPreference,
//               items: const ['BUDGET', 'STANDARD', 'LUXURY'],
//               onChanged: (val) =>
//                   setState(() => _selectedAccommodationPreference = val),
//             ),
//             CustomTextFormField(
//               label: 'Travel Duration (days)',
//               controller: _travelDurationController,
//               keyboardType: TextInputType.number,
//             ),
//             CustomDropdownField(
//               label: 'Visa Type Required',
//               value: _selectedVisaType,
//               items: const ['TOURIST', 'BUSINESS', 'STUDENT', 'WORK'],
//               onChanged: (val) => setState(() => _selectedVisaType = val),
//             ),
//             CustomCheckDropdown(
//               label: 'Visited Countries',
//               items: configController.configData.value.country
//                       ?.map((e) => e.name ?? "")
//                       .toList() ??
//                   [],
//               values: _selectedVisitedCountries ?? [],
//               onChanged: (value) => setState(
//                   () => _selectedVisitedCountries = value.cast<String>()),
//             ),
//             EnhancedSwitchTile(
//               label: 'Requires Travel Insurance',
//               icon: Icons.security_rounded,
//               value: _requiresTravelInsurance,
//               onChanged: (val) =>
//                   setState(() => _requiresTravelInsurance = val),
//             ),
//             EnhancedSwitchTile(
//               label: 'Requires Hotel Booking',
//               icon: Icons.hotel_rounded,
//               value: _requiresHotelBooking,
//               onChanged: (val) => setState(() => _requiresHotelBooking = val),
//             ),
//             EnhancedSwitchTile(
//               label: 'Requires Flight Booking',
//               icon: Icons.flight_rounded,
//               value: _requiresFlightBooking,
//               onChanged: (val) => setState(() => _requiresFlightBooking = val),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildEducationFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//             title: 'Education Details', icon: Icons.school_rounded),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             CustomDropdownField(
//               label: 'Preferred Study Mode',
//               value: _selectedStudyMode,
//               items: const ['ONLINE', 'OFFLINE', 'HYBRID'],
//               onChanged: (val) => setState(() => _selectedStudyMode = val),
//             ),
//             CustomDropdownField(
//               label: 'Batch Preference',
//               value: _selectedBatch,
//               items: const ['MORNING', 'AFTERNOON', 'EVENING', 'WEEKEND'],
//               onChanged: (val) => setState(() => _selectedBatch = val),
//             ),
//             CustomDropdownField(
//               label: 'Highest Qualification',
//               value: _selectedHighestQualification,
//               items: configController.configData.value.programType
//                       ?.map((e) => e.name ?? "")
//                       .toList() ??
//                   [],
//               onChanged: (val) =>
//                   setState(() => _selectedHighestQualification = val),
//             ),
//             CustomTextFormField(
//               label: 'Year of Passing',
//               controller: _yearOfPassingController,
//               keyboardType: TextInputType.number,
//             ),
//             CustomTextFormField(
//               label: 'Field of Study',
//               controller: _fieldOfStudyController,
//             ),
//             CustomTextFormField(
//               label: 'Percentage/CGPA',
//               controller: _percentageController,
//               keyboardType: TextInputType.number,
//             ),
//             CustomCheckDropdown(
//               label: 'Courses Interested',
//               items: const [
//                 'Engineering',
//                 'Medicine',
//                 'Business',
//                 'Arts',
//                 'Science',
//                 'Technology'
//               ],
//               values: _selectedCoursesInterested ?? [],
//               onChanged: (value) => setState(
//                   () => _selectedCoursesInterested = value.cast<String>()),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildVehicleFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//             title: 'Vehicle Details', icon: Icons.directions_car_rounded),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             CustomDropdownField(
//               label: 'Vehicle Type',
//               value: _selectedVehicleType,
//               items: const ['NEW', 'USED'],
//               onChanged: (val) => setState(() => _selectedVehicleType = val),
//             ),
//             CustomTextFormField(
//               label: 'Brand Preference',
//               controller: TextEditingController(text: _selectedBrandPreference),
//               // onChanged: (val) =>
//               //     setState(() => _selectedBrandPreference = val),
//             ),
//             CustomTextFormField(
//               label: 'Model Preference',
//               controller: TextEditingController(text: _selectedModelPreference),
//               // onChanged: (val) =>
//               //     setState(() => _selectedModelPreference = val),
//             ),
//             CustomDropdownField(
//               label: 'Fuel Type',
//               value: _selectedFuelType,
//               items: const ['PETROL', 'DIESEL', 'ELECTRIC', 'CNG'],
//               onChanged: (val) => setState(() => _selectedFuelType = val),
//             ),
//             CustomDropdownField(
//               label: 'Transmission',
//               value: _selectedTransmission,
//               items: const ['MANUAL', 'AUTOMATIC'],
//               onChanged: (val) => setState(() => _selectedTransmission = val),
//             ),
//             CustomDropdownField(
//               label: 'Insurance Type',
//               value: _selectedInsuranceType,
//               items: const ['COMPREHENSIVE', 'THIRD_PARTY'],
//               onChanged: (val) => setState(() => _selectedInsuranceType = val),
//             ),
//             CustomTextFormField(
//               label: 'Down Payment Available',
//               controller: _downPaymentController,
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildRealEstateFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//             title: 'Real Estate Details', icon: Icons.home_work_rounded),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             CustomDropdownField(
//               label: 'Property Type',
//               value: _selectedPropertyType,
//               items: const ['RESIDENTIAL', 'COMMERCIAL', 'PLOT', 'INDUSTRIAL'],
//               onChanged: (val) => setState(() => _selectedPropertyType = val),
//             ),
//             CustomDropdownField(
//               label: 'Property Use',
//               value: _selectedPropertyUse,
//               items: const ['SELF_USE', 'INVESTMENT', 'RENTAL'],
//               onChanged: (val) => setState(() => _selectedPropertyUse = val),
//             ),
//             CustomDropdownField(
//               label: 'Possession Timeline',
//               value: _selectedPossessionTimeline,
//               items: const ['IMMEDIATE', '3_MONTHS', '6_MONTHS', '1_YEAR'],
//               onChanged: (val) =>
//                   setState(() => _selectedPossessionTimeline = val),
//             ),
//             CustomDropdownField(
//               label: 'Furnishing Preference',
//               value: _selectedFurnishingPreference,
//               items: const ['FULLY_FURNISHED', 'SEMI_FURNISHED', 'UNFURNISHED'],
//               onChanged: (val) =>
//                   setState(() => _selectedFurnishingPreference = val),
//             ),
//             CustomDropdownField(
//               label: 'Group Type',
//               value: _selectedGroupType,
//               items: const ['COUPLE', 'MARRIED_COUPLE', 'BOYS', 'GIRLS'],
//               onChanged: (val) => setState(() => _selectedGroupType = val),
//             ),
//             CustomTextFormField(
//               label: 'Total People',
//               controller: _totalPeoplesController,
//             ),
//             EnhancedSwitchTile(
//               label: 'Requires Legal Assistance',
//               icon: Icons.gavel_rounded,
//               value: _requiresLegalAssistance,
//               onChanged: (val) =>
//                   setState(() => _requiresLegalAssistance = val),
//             ),
//             EnhancedSwitchTile(
//               label: 'Requires Home Loan',
//               icon: Icons.money_rounded,
//               value: _requiresLoan,
//               onChanged: (val) => setState(() => _requiresLoan = val),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMigrationFields() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//             title: 'Migration Details', icon: Icons.public_rounded),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             CustomDropdownField(
//               label: 'Target Visa Type',
//               value: _selectedTargetVisaType,
//               items: const [
//                 'STUDENT',
//                 'WORK',
//                 'BUSINESS',
//                 'TOURIST',
//                 'PERMANENT'
//               ],
//               onChanged: (val) => setState(() => _selectedTargetVisaType = val),
//             ),
//             CustomTextFormField(
//               label: 'Preferred Settlement City',
//               controller: _preferredSettlementCityController,
//             ),
//             EnhancedSwitchTile(
//               label: 'Has Relatives Abroad',
//               icon: Icons.family_restroom_rounded,
//               value: _hasRelativesAbroad,
//               onChanged: (val) => setState(() => _hasRelativesAbroad = val),
//             ),
//             if (_hasRelativesAbroad) ...[
//               CustomTextFormField(
//                 label: 'Relative Country',
//                 controller: _relativeCountryController,
//               ),
//               CustomTextFormField(
//                 label: 'Relative Relation',
//                 controller: _relativeRelationController,
//               ),
//             ],
//             EnhancedSwitchTile(
//               label: 'Requires Job Assistance',
//               icon: Icons.work_rounded,
//               value: _requiresJobAssistance,
//               onChanged: (val) => setState(() => _requiresJobAssistance = val),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // //profile_deatil apage
// // // view/lead/add_edit_lead_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';

// // import '../../../../controller/config/config_controller.dart';
// // import '../../../../controller/lead/lead_controller.dart';
// // import '../../../../controller/officers_controller/officers_controller.dart';
// // import '../../../widgets/widgets.dart';
// // import '../lead_data_display.dart';

// // class AddEditLead extends StatefulWidget {
// //   final Lead? lead;
// //   final bool isEditMode;

// //   const AddEditLead({super.key, this.lead, required this.isEditMode});

// //   @override
// //   State<AddEditLead> createState() => _AddEditLeadState();
// // }

// // class _AddEditLeadState extends State<AddEditLead> {
// //   final _formKey = GlobalKey<FormState>();
// //   final leadController = Get.find<LeadController>();
// //   final officersController = Get.find<OfficersController>();
// //   final configController = Get.find<ConfigController>();

// //   // Controllers for all fields
// //   final _fullNameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _companyController = TextEditingController();
// //   final _designationController = TextEditingController();
// //   final _productInterestController = TextEditingController();
// //   final _serviceRequiredController = TextEditingController();
// //   final _budgetController = TextEditingController();
// //   final _preferredLocationController = TextEditingController();
// //   final _notesController = TextEditingController();
// //   final _addressController = TextEditingController();
// //   final _cityController = TextEditingController();
// //   final _stateController = TextEditingController();
// //   final _countryController = TextEditingController();
// //   final _pincodeController = TextEditingController();
// //   final _alternatePhoneController = TextEditingController();
// //   final _whatsappController = TextEditingController();
// //   final _dobController = TextEditingController();
// //   final _annualIncomeController = TextEditingController();
// //   final _companyNameController = TextEditingController();
// //   final _workExperienceController = TextEditingController();
// //   final _taxIdController = TextEditingController();
// //   final _existingLoanAmountController = TextEditingController();
// //   final _institutionNameController = TextEditingController();
// //   final _yearOfPassingController = TextEditingController();
// //   final _percentageController = TextEditingController();
// //   final _fieldOfStudyController = TextEditingController();
// //   final _currentSalaryController = TextEditingController();
// //   final _expectedSalaryController = TextEditingController();
// //   final _technicalSkillsController = TextEditingController();
// //   final _softSkillsController = TextEditingController();
// //   final _passportNumberController = TextEditingController();
// //   final _languageTestScoreController = TextEditingController();
// //   final _relativeCountryController = TextEditingController();
// //   final _relativeRelationController = TextEditingController();
// //   final _preferredSettlementController = TextEditingController();
// //   final _loanAmountRequiredController = TextEditingController();
// //   final _downPaymentController = TextEditingController();
// //   final _brandPreferenceController = TextEditingController();
// //   final _modelPreferenceController = TextEditingController();

// //   // Dropdown values
// //   String? _selectedBusinessType;
// //   String? _selectedLeadSource;
// //   String? _selectedStatus;
// //   String? _selectedGender;
// //   String? _selectedMaritalStatus;
// //   String? _selectedProfession;
// //   String? _selectedAgent;
// //   String? _selectedEmploymentStatus;
// //   String? _selectedCreditScore;
// //   String? _selectedHighestQualification;
// //   String? _selectedCurrentIndustry;
// //   String? _selectedCurrentJobRole;
// //   String? _selectedDesiredJobRole;
// //   String? _selectedTravelPurpose;
// //   String? _selectedCurrentVisaStatus;
// //   String? _selectedTargetVisaType;
// //   String? _selectedLanguageTest;
// //   String? _selectedPropertyType;
// //   String? _selectedPropertyUse;
// //   String? _selectedPossessionTimeline;
// //   String? _selectedFurnishingPreference;
// //   String? _selectedVehicleType;
// //   String? _selectedFuelType;
// //   String? _selectedTransmission;
// //   String? _selectedInsuranceType;
// //   String? _selectedPreferredLanguage;
// //   String? _selectedTimezone;

// //   int _selectedPriority = 3;
// //   DateTime? _preferredDate;
// //   DateTime? _passportExpiry;

// //   // Boolean values
// //   bool _phoneCommunication = true;
// //   bool _emailCommunication = false;
// //   bool _whatsappCommunication = false;
// //   bool _onCallCommunication = false;
// //   bool _hasExistingLoans = false;
// //   bool _requiresTravelInsurance = false;
// //   bool _requiresHotelBooking = false;
// //   bool _requiresFlightBooking = false;
// //   bool _hasRelativesAbroad = false;
// //   bool _requiresJobAssistance = false;
// //   bool _requiresHomeLoan = false;
// //   bool _requiresLegalAssistance = false;
// //   bool _requiresFinancing = false;

// //   // Multi-select values
// //   List<String> _selectedCountries = [];
// //   List<String> _selectedSpecializations = [];
// //   List<String> _selectedVisitedCountries = [];
// //   List<String> _selectedSpokenLanguages = [];
// //   List<String> _selectedTechnicalSkills = [];
// //   List<String> _selectedSoftSkills = [];

// //   // Custom fields
// //   Map<String, dynamic> _customFields = {};

// //   final _scrollController = ScrollController();
// //   final _pageViewController = PageController();
// //   int _currentPage = 0;

// //   final List<String> _pageTitles = [
// //     'Basic Information',
// //     'Personal & Professional',
// //     'Financial Details',
// //     'Business Specific',
// //     'Preferences & Notes'
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeForm();
// //   }

// //   void _initializeForm() {
// //     if (widget.isEditMode && widget.lead != null) {
// //       final lead = widget.lead!;
// //       // Initialize all controllers with lead data
// //       _fullNameController.text = lead.fullName;
// //       _emailController.text = lead.email;
// //       _phoneController.text = lead.phone;
// //       _companyController.text = lead.company ?? '';
// //       _designationController.text = lead.designation ?? '';
// //       // ... initialize all other controllers
// //     } else {
// //       _selectedBusinessType = 'TRAVEL';
// //       _selectedLeadSource = 'WEBSITE';
// //       _selectedStatus = 'NEW';
// //     }
// //   }

// //   void _saveLead() {
// //     if (_formKey.currentState!.validate()) {
// //       final lead = Lead(
// //         id: widget.lead?.id,
// //         businessType: _selectedBusinessType!,
// //         leadSource: _selectedLeadSource!,
// //         status: _selectedStatus!,
// //         fullName: _fullNameController.text.trim(),
// //         email: _emailController.text.trim(),
// //         phone: _phoneController.text.trim(),
// //         company: _getTextOrNull(_companyController),
// //         designation: _getTextOrNull(_designationController),
// //         // ... set all other fields
// //         createdAt: widget.lead?.createdAt ?? DateTime.now(),
// //         updatedAt: DateTime.now(),
// //         createdBy: widget.lead?.createdBy,
// //       );

// //       if (widget.isEditMode) {
// //         // leadController.updateLead(lead);
// //       } else {
// //         // leadController.addLead(lead);
// //       }
// //       Get.back();
// //     }
// //   }

// //   String? _getTextOrNull(TextEditingController controller) {
// //     return controller.text.trim().isEmpty ? null : controller.text.trim();
// //   }

// //   double? _getDoubleOrNull(TextEditingController controller) {
// //     return controller.text.trim().isEmpty
// //         ? null
// //         : double.tryParse(controller.text.trim());
// //   }

// //   int? _getIntOrNull(TextEditingController controller) {
// //     return controller.text.trim().isEmpty
// //         ? null
// //         : int.tryParse(controller.text.trim());
// //   }

// //   Widget _buildProgressIndicator() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
// //       decoration: BoxDecoration(
// //         color: Colors.blue.shade50,
// //         border: Border(bottom: BorderSide(color: Colors.blue.shade100)),
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               for (int i = 0; i < _pageTitles.length; i++) ...[
// //                 Expanded(
// //                   child: Column(
// //                     children: [
// //                       Container(
// //                         height: 8,
// //                         decoration: BoxDecoration(
// //                           color: i <= _currentPage
// //                               ? Colors.blue
// //                               : Colors.grey.shade300,
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         _pageTitles[i],
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           fontWeight: i == _currentPage
// //                               ? FontWeight.bold
// //                               : FontWeight.normal,
// //                           color: i <= _currentPage ? Colors.blue : Colors.grey,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 if (i < _pageTitles.length - 1)
// //                   Container(
// //                     width: 20,
// //                     height: 1,
// //                     color: Colors.grey.shade300,
// //                     margin: const EdgeInsets.symmetric(horizontal: 4),
// //                   ),
// //               ],
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPageView() {
// //     return Expanded(
// //       child: PageView(
// //         controller: _pageViewController,
// //         onPageChanged: (page) => setState(() => _currentPage = page),
// //         children: [
// //           _buildBasicInfoPage(),
// //           _buildPersonalProfessionalPage(),
// //           _buildFinancialPage(),
// //           _buildBusinessSpecificPage(),
// //           _buildPreferencesNotesPage(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildBasicInfoPage() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Column(
// //         children: [
// //           // Business Type & Lead Source
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: CustomDropdownField(
// //                   label: 'Business Type *',
// //                   value: _selectedBusinessType,
// //                   items: BusinessTypeConfig.businessTypes,
// //                   onChanged: (value) =>
// //                       setState(() => _selectedBusinessType = value),
// //                   isRequired: true,
// //                 ),
// //               ),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: CustomDropdownField(
// //                   label: 'Lead Source *',
// //                   value: _selectedLeadSource,
// //                   items: BusinessTypeConfig.leadSources,
// //                   onChanged: (value) =>
// //                       setState(() => _selectedLeadSource = value),
// //                   isRequired: true,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 24),

// //           // Basic Information
// //           const SectionTitle(
// //               title: 'Basic Information', icon: Icons.person_outline),
// //           const SizedBox(height: 16),
// //           ResponsiveGrid(
// //             columns: 2,
// //             children: [
// //               CustomTextFormField(
// //                 label: 'Full Name *',
// //                 controller: _fullNameController,
// //                 isRequired: true,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Email *',
// //                 controller: _emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 isRequired: true,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Phone *',
// //                 controller: _phoneController,
// //                 keyboardType: TextInputType.phone,
// //                 isRequired: true,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Alternate Phone',
// //                 controller: _alternatePhoneController,
// //                 keyboardType: TextInputType.phone,
// //               ),
// //               CustomTextFormField(
// //                 label: 'WhatsApp Number',
// //                 controller: _whatsappController,
// //                 keyboardType: TextInputType.phone,
// //               ),
// //               CustomDateField(
// //                 label: 'Date of Birth',
// //                 controller: _dobController,
// //               ),
// //               CustomDropdownField(
// //                 label: 'Gender',
// //                 value: _selectedGender,
// //                 items: const ['Male', 'Female', 'Other'],
// //                 onChanged: (value) => setState(() => _selectedGender = value),
// //               ),
// //               CustomDropdownField(
// //                 label: 'Marital Status',
// //                 value: _selectedMaritalStatus,
// //                 items: const ['Single', 'Married', 'Divorced', 'Widowed'],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedMaritalStatus = value),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPersonalProfessionalPage() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Column(
// //         children: [
// //           // Education Details
// //           const SectionTitle(title: 'Education Details', icon: Icons.school),
// //           const SizedBox(height: 16),
// //           ResponsiveGrid(
// //             columns: 2,
// //             children: [
// //               CustomDropdownField(
// //                 label: 'Highest Qualification',
// //                 value: _selectedHighestQualification,
// //                 items: const [
// //                   'High School',
// //                   'Diploma',
// //                   'Bachelor',
// //                   'Master',
// //                   'PhD'
// //                 ],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedHighestQualification = value),
// //               ),
// //               CustomTextFormField(
// //                 label: 'Institution Name',
// //                 controller: _institutionNameController,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Year of Passing',
// //                 controller: _yearOfPassingController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Percentage/CGPA',
// //                 controller: _percentageController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Field of Study',
// //                 controller: _fieldOfStudyController,
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 24),

// //           // Career Details
// //           const SectionTitle(title: 'Career Details', icon: Icons.work),
// //           const SizedBox(height: 16),
// //           ResponsiveGrid(
// //             columns: 2,
// //             children: [
// //               CustomDropdownField(
// //                 label: 'Current Industry',
// //                 value: _selectedCurrentIndustry,
// //                 items: const [
// //                   'IT',
// //                   'Finance',
// //                   'Healthcare',
// //                   'Education',
// //                   'Manufacturing'
// //                 ],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedCurrentIndustry = value),
// //               ),
// //               CustomDropdownField(
// //                 label: 'Current Job Role',
// //                 value: _selectedCurrentJobRole,
// //                 items: const [
// //                   'Developer',
// //                   'Manager',
// //                   'Analyst',
// //                   'Consultant',
// //                   'Executive'
// //                 ],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedCurrentJobRole = value),
// //               ),
// //               CustomDropdownField(
// //                 label: 'Desired Job Role',
// //                 value: _selectedDesiredJobRole,
// //                 items: const [
// //                   'Developer',
// //                   'Manager',
// //                   'Analyst',
// //                   'Consultant',
// //                   'Executive'
// //                 ],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedDesiredJobRole = value),
// //               ),
// //               CustomTextFormField(
// //                 label: 'Current Salary',
// //                 controller: _currentSalaryController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Expected Salary',
// //                 controller: _expectedSalaryController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Technical Skills',
// //                 controller: _technicalSkillsController,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Soft Skills',
// //                 controller: _softSkillsController,
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFinancialPage() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Column(
// //         children: [
// //           const SectionTitle(
// //               title: 'Financial Information', icon: Icons.attach_money),
// //           const SizedBox(height: 16),
// //           ResponsiveGrid(
// //             columns: 2,
// //             children: [
// //               CustomDropdownField(
// //                 label: 'Employment Status',
// //                 value: _selectedEmploymentStatus,
// //                 items: const [
// //                   'SALARIED',
// //                   'SELF_EMPLOYED',
// //                   'BUSINESS',
// //                   'STUDENT',
// //                   'UNEMPLOYED'
// //                 ],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedEmploymentStatus = value),
// //               ),
// //               CustomTextFormField(
// //                 label: 'Annual Income',
// //                 controller: _annualIncomeController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Income Source',
// //                 controller: _companyNameController,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Company Name',
// //                 controller: _companyNameController,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Work Experience (years)',
// //                 controller: _workExperienceController,
// //                 keyboardType: TextInputType.number,
// //               ),
// //               CustomTextFormField(
// //                 label: 'Tax Identification Number',
// //                 controller: _taxIdController,
// //               ),
// //               CustomDropdownField(
// //                 label: 'Credit Score',
// //                 value: _selectedCreditScore,
// //                 items: const ['EXCELLENT', 'GOOD', 'FAIR', 'POOR'],
// //                 onChanged: (value) =>
// //                     setState(() => _selectedCreditScore = value),
// //               ),
// //               EnhancedSwitchTile(
// //                 label: 'Has Existing Loans',
// //                 value: _hasExistingLoans,
// //                 onChanged: (value) => setState(() => _hasExistingLoans = value),
// //               ),
// //               if (_hasExistingLoans)
// //                 CustomTextFormField(
// //                   label: 'Existing Loan Amount',
// //                   controller: _existingLoanAmountController,
// //                   keyboardType: TextInputType.number,
// //                 ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildBusinessSpecificPage() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Column(
// //         children: [
// //           // Travel Specific Section
// //           if (_selectedBusinessType == 'TRAVEL') ...[
// //             const SectionTitle(title: 'Travel Details', icon: Icons.flight),
// //             const SizedBox(height: 16),
// //             ResponsiveGrid(
// //               columns: 2,
// //               children: [
// //                 CustomTextFormField(
// //                   label: 'Passport Number',
// //                   controller: _passportNumberController,
// //                 ),
// //                 CustomDateField(
// //                   label: 'Passport Expiry',
// //                   controller: TextEditingController(
// //                     text: _passportExpiry != null
// //                         ? DateFormat('dd/MM/yyyy').format(_passportExpiry!)
// //                         : '',
// //                   ),
// //                   onChanged: (value) {
// //                     if (value.isNotEmpty) {
// //                       setState(() {
// //                         _passportExpiry = DateFormat('dd/MM/yyyy').parse(value);
// //                       });
// //                     }
// //                   },
// //                 ),
// //                 CustomDropdownField(
// //                   label: 'Travel Purpose',
// //                   value: _selectedTravelPurpose,
// //                   items: const ['TOURISM', 'BUSINESS', 'EDUCATION', 'MEDICAL'],
// //                   onChanged: (value) =>
// //                       setState(() => _selectedTravelPurpose = value),
// //                 ),
// //                 CustomTextFormField(
// //                   label: 'Travel Group Size',
// //                   controller: TextEditingController(),
// //                   keyboardType: TextInputType.number,
// //                 ),
// //                 EnhancedSwitchTile(
// //                   label: 'Requires Travel Insurance',
// //                   value: _requiresTravelInsurance,
// //                   onChanged: (value) =>
// //                       setState(() => _requiresTravelInsurance = value),
// //                 ),
// //                 EnhancedSwitchTile(
// //                   label: 'Requires Hotel Booking',
// //                   value: _requiresHotelBooking,
// //                   onChanged: (value) =>
// //                       setState(() => _requiresHotelBooking = value),
// //                 ),
// //                 EnhancedSwitchTile(
// //                   label: 'Requires Flight Booking',
// //                   value: _requiresFlightBooking,
// //                   onChanged: (value) =>
// //                       setState(() => _requiresFlightBooking = value),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 24),
// //           ],

// //           // Migration Specific Section
// //           if (_selectedBusinessType == 'MIGRATION') ...[
// //             const SectionTitle(title: 'Migration Details', icon: Icons.flag),
// //             const SizedBox(height: 16),
// //             ResponsiveGrid(
// //               columns: 2,
// //               children: [
// //                 CustomDropdownField(
// //                   label: 'Current Visa Status',
// //                   value: _selectedCurrentVisaStatus,
// //                   items: const ['Tourist', 'Student', 'Work', 'Permanent'],
// //                   onChanged: (value) =>
// //                       setState(() => _selectedCurrentVisaStatus = value),
// //                 ),
// //                 CustomDropdownField(
// //                   label: 'Target Visa Type',
// //                   value: _selectedTargetVisaType,
// //                   items: const ['Student', 'Work', 'Business', 'Family'],
// //                   onChanged: (value) =>
// //                       setState(() => _selectedTargetVisaType = value),
// //                 ),
// //                 CustomDropdownField(
// //                   label: 'Language Test Taken',
// //                   value: _selectedLanguageTest,
// //                   items: const ['IELTS', 'TOEFL', 'PTE'],
// //                   onChanged: (value) =>
// //                       setState(() => _selectedLanguageTest = value),
// //                 ),
// //                 CustomTextFormField(
// //                   label: 'Language Test Score',
// //                   controller: _languageTestScoreController,
// //                   keyboardType: TextInputType.number,
// //                 ),
// //                 EnhancedSwitchTile(
// //                   label: 'Has Relatives Abroad',
// //                   value: _hasRelativesAbroad,
// //                   onChanged: (value) =>
// //                       setState(() => _hasRelativesAbroad = value),
// //                 ),
// //                 if (_hasRelativesAbroad) ...[
// //                   CustomTextFormField(
// //                     label: 'Relative Country',
// //                     controller: _relativeCountryController,
// //                   ),
// //                   CustomTextFormField(
// //                     label: 'Relative Relation',
// //                     controller: _relativeRelationController,
// //                   ),
// //                 ],
// //                 EnhancedSwitchTile(
// //                   label: 'Requires Job Assistance',
// //                   value: _requiresJobAssistance,
// //                   onChanged: (value) =>
// //                       setState(() => _requiresJobAssistance = value),
// //                 ),
// //                 CustomTextFormField(
// //                   label: 'Preferred Settlement City',
// //                   controller: _preferredSettlementController,
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 24),
// //           ],

// //           // Add similar sections for other business types...
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPreferencesNotesPage() {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(24),
// //       child: Column(
// //         children: [
// //           // Communication Preferences
// //           const SectionTitle(
// //               title: 'Communication Preferences', icon: Icons.notifications),
// //           const SizedBox(height: 16),
// //           ResponsiveGrid(
// //             columns: 2,
// //             children: [
// //               EnhancedSwitchTile(
// //                 label: 'Phone Communication',
// //                 value: _phoneCommunication,
// //                 onChanged: (value) =>
// //                     setState(() => _phoneCommunication = value),
// //               ),
// //               EnhancedSwitchTile(
// //                 label: 'Email Communication',
// //                 value: _emailCommunication,
// //                 onChanged: (value) =>
// //                     setState(() => _emailCommunication = value),
// //               ),
// //               EnhancedSwitchTile(
// //                 label: 'WhatsApp Communication',
// //                 value: _whatsappCommunication,
// //                 onChanged: (value) =>
// //                     setState(() => _whatsappCommunication = value),
// //               ),
// //               EnhancedSwitchTile(
// //                 label: 'On Call Communication',
// //                 value: _onCallCommunication,
// //                 onChanged: (value) =>
// //                     setState(() => _onCallCommunication = value),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 24),

// //           // Notes
// //           const SectionTitle(title: 'Additional Notes', icon: Icons.notes),
// //           const SizedBox(height: 16),
// //           CustomTextFormField(
// //             label: 'Notes',
// //             controller: _notesController,
// //             maxLines: 4,
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildNavigationButtons() {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         border: Border(top: BorderSide(color: Colors.grey.shade300)),
// //       ),
// //       child: Row(
// //         children: [
// //           if (_currentPage > 0)
// //             Expanded(
// //               child: CustomActionButton(
// //                 text: 'Previous',
// //                 icon: Icons.arrow_back,
// //                 onPressed: () => _pageViewController.previousPage(
// //                   duration: const Duration(milliseconds: 300),
// //                   curve: Curves.easeInOut,
// //                 ),
// //                 borderColor: Colors.grey.shade300,
// //               ),
// //             ),
// //           if (_currentPage > 0) const SizedBox(width: 16),
// //           Expanded(
// //             flex: _currentPage == _pageTitles.length - 1 ? 2 : 1,
// //             child: CustomActionButton(
// //               text: _currentPage == _pageTitles.length - 1
// //                   ? (widget.isEditMode ? 'Update Lead' : 'Create Lead')
// //                   : 'Next',
// //               icon: _currentPage == _pageTitles.length - 1
// //                   ? Icons.save
// //                   : Icons.arrow_forward,
// //               isFilled: true,
// //               gradient: const LinearGradient(
// //                 colors: [Colors.blue, Colors.lightBlue],
// //               ),
// //               onPressed: () {
// //                 if (_currentPage < _pageTitles.length - 1) {
// //                   _pageViewController.nextPage(
// //                     duration: const Duration(milliseconds: 300),
// //                     curve: Curves.easeInOut,
// //                   );
// //                 } else {
// //                   _saveLead();
// //                 }
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       backgroundColor: Colors.transparent,
// //       insetPadding: const EdgeInsets.all(16),
// //       child: ConstrainedBox(
// //         constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(20),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.1),
// //                 blurRadius: 20,
// //                 spreadRadius: 0,
// //               ),
// //             ],
// //           ),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               children: [
// //                 // Header
// //                 Container(
// //                   padding: const EdgeInsets.all(24),
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                       colors: [
// //                         Colors.blue.shade700,
// //                         Colors.lightBlue.shade400,
// //                       ],
// //                     ),
// //                     borderRadius: const BorderRadius.only(
// //                       topLeft: Radius.circular(20),
// //                       topRight: Radius.circular(20),
// //                     ),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withOpacity(0.2),
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         child: Icon(
// //                           widget.isEditMode ? Icons.edit : Icons.person_add,
// //                           color: Colors.white,
// //                           size: 28,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               widget.isEditMode ? 'Edit Lead' : 'Add New Lead',
// //                               style: const TextStyle(
// //                                 fontSize: 24,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 4),
// //                             Text(
// //                               'Step ${_currentPage + 1} of ${_pageTitles.length}: ${_pageTitles[_currentPage]}',
// //                               style: TextStyle(
// //                                 fontSize: 14,
// //                                 color: Colors.white.withOpacity(0.9),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       IconButton(
// //                         icon: const Icon(Icons.close,
// //                             color: Colors.white, size: 24),
// //                         onPressed: () => Get.back(),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Progress Indicator
// //                 _buildProgressIndicator(),

// //                 // Page View
// //                 _buildPageView(),

// //                 // Navigation Buttons
// //                 _buildNavigationButtons(),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _pageViewController.dispose();
// //     _scrollController.dispose();
// //     // Dispose all controllers
// //     super.dispose();
// //   }
// // }
