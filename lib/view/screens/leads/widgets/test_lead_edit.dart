import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

class AddEditLeadScreen extends StatefulWidget {
  final LeadModel? lead;
  final bool isEditMode;

  const AddEditLeadScreen({super.key, this.lead, required this.isEditMode});

  @override
  State<AddEditLeadScreen> createState() => _AddEditLeadScreenState();
}

class _AddEditLeadScreenState extends State<AddEditLeadScreen> {
  final configController = Get.find<ConfigController>();
  final officersController = Get.find<OfficersController>();
  final leadController = Get.find<LeadController>();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _waMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _leadDateController = TextEditingController();
  final TextEditingController _mobileOptionalController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _preferredLocationController =
      TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _numberOfTravelersController =
      TextEditingController();
  final TextEditingController _travelDurationController =
      TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _totalPeoplesController = TextEditingController();
  // Form values
  String? _selectedService = 'TRAVEL';
  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedPhoneCtry = "+91";
  String? _selectedAltPhoneCtry = "+91";
  String? _selectedWAPhoneCtry = "+91";
  String? _selectedLeadSource;
  String? _selectedSourceCampaign;
  String? _selectedStatus = 'NEW';
  String? _selectedAgent;
  String? _selectedProfession;

  // Multi-select
  List<String> selectedCountries = [];
  List<String>? _selectedProductInterest;
  List<String>? _selectedSpecialized;

  // Preferences
  bool _phoneCommunication = true;
  bool _emailCommunication = false;
  bool _whatsappCommunication = false;
  bool _onCallCommunication = false;
  bool _requiresLoan = false;

  // Service Specific Fields
  // Travel
  String? _selectedTravelPurpose;
  String? _selectedAccommodationPreference;
  String? _selectedVisaType;

  // Education
  String? _selectedStudyMode;
  String? _selectedBatch;
  String? _selectedHighestQualification;

  // Vehicle
  String? _selectedVehicleType;
  String? _selectedBrandPreference;
  String? _selectedModelPreference;
  String? _selectedFuelType;
  String? _selectedTransmission;
  String? _selectedInsuranceType;

  // Real Estate
  String? _selectedPropertyType;
  String? _selectedPropertyUse;
  String? _selectedPossessionTimeline;
  String? _selectedFurnishingPreference;
  String? _selectedGroupType;
  bool _requiresLegalAssistance = false;

  DateTime? _preferredDate;
  int _selectedPriority = 3;

  @override
  void initState() {
    super.initState();
    _initializeForm();
    _leadDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await officersController.fetchOfficersList();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  void _initializeForm() {
    if (widget.isEditMode && widget.lead != null) {
      final lead = widget.lead!;

      // Basic Information
      _nameController.text = lead.name ?? '';
      _lastNameController.text = lead.lastName ?? '';
      _emailController.text = lead.email ?? '';
      _mobileController.text = lead.phone ?? '';
      // Contact Information
      if (lead.whatsapp != null && lead.whatsapp!.isNotEmpty) {
        final whatsappParts = lead.whatsapp!.split(' ');
        if (whatsappParts.length > 1) {
          _selectedWAPhoneCtry = whatsappParts.first;
          _waMobileController.text = whatsappParts.sublist(1).join(' ');
        }
      }
      if (lead.alternatePhone != null && lead.alternatePhone!.isNotEmpty) {
        final altPhoneParts = lead.alternatePhone!.split(' ');
        if (altPhoneParts.length > 1) {
          _selectedAltPhoneCtry = altPhoneParts.first;
          _mobileOptionalController.text = altPhoneParts.sublist(1).join(' ');
        }
      }

      // Personal Details
      _selectedGender = lead.gender;
      _selectedMaritalStatus = lead.maritalStatus;
      _dobController.text = lead.dob ?? '';

      // Address
      _addressController.text = lead.address ?? '';
      _cityController.text = lead.city ?? '';
      _stateController.text = lead.state ?? '';
      _countryController.text = lead.country ?? '';
      _pincodeController.text = lead.pincode ?? '';

      // Lead Details
      _selectedLeadSource = lead.leadSource;
      _selectedSourceCampaign = lead.sourceCampaign;
      _selectedStatus = lead.status;
      selectedCountries = lead.countryInterested ?? [];
      _selectedProductInterest = lead.productInterest;
      _selectedAgent = lead.assignedTo;
      _budgetController.text = lead.budget?.toString() ?? '';
      _preferredLocationController.text = lead.preferredLocation ?? '';
      _notesController.text = lead.note ?? '';
      _selectedService = lead.serviceType;

      // Preferences
      _phoneCommunication = lead.phoneCommunication ?? true;
      _emailCommunication = lead.emailCommunication ?? false;
      _whatsappCommunication = lead.whatsappCommunication ?? false;
      _onCallCommunication = lead.onCallCommunication ?? false;
      _requiresLoan = lead.requiresHomeLoan ?? false;
      _loanAmountController.text = lead.loanAmountRequired?.toString() ?? '';

      // Service Specific Initialization
      _initializeServiceSpecificFields(lead);
    }
  }

  void _initializeServiceSpecificFields(LeadModel lead) {
    switch (_selectedService) {
      case 'TRAVEL':
        _selectedTravelPurpose = lead.travelPurpose;
        _selectedAccommodationPreference = lead.accommodationPreference;
        _selectedVisaType = lead.visaTypeRequired;
        _numberOfTravelersController.text =
            lead.numberOfTravelers?.toString() ?? '';
        _travelDurationController.text = lead.travelDuration?.toString() ?? '';
        break;
      case 'EDUCATION':
        _selectedStudyMode = lead.preferredStudyMode;
        _selectedBatch = lead.batchPreference;
        _selectedHighestQualification = lead.highestQualification;
        break;
      case 'VEHICLE':
        _selectedVehicleType = lead.vehicleType;
        _selectedBrandPreference = lead.brandPreference;
        _selectedModelPreference = lead.modelPreference;
        _selectedFuelType = lead.fuelType;
        _selectedTransmission = lead.transmission;
        _selectedInsuranceType = lead.insuranceType;
        _downPaymentController.text =
            lead.downPaymentAvailable?.toString() ?? '';
        break;
      case 'REAL_ESTATE':
        _selectedPropertyType = lead.propertyType;
        _selectedPropertyUse = lead.propertyUse;
        _selectedPossessionTimeline = lead.possessionTimeline;
        _selectedFurnishingPreference = lead.furnishingPreference;
        _selectedGroupType = lead.groupType;
        _totalPeoplesController.text = lead.totalPeoples ?? '';
        _requiresLegalAssistance = lead.requiresLegalAssistance ?? false;
        break;
    }
  }

  void _saveLead() async {
    if (_formKey.currentState!.validate()) {
      showLoaderDialog(context);

      final lead = LeadModel(
        sId: widget.lead?.sId,
        // Core Information
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _mobileController.text.trim(),
        countryCode: _selectedPhoneCtry ?? '',
        alternatePhone: _mobileOptionalController.text.trim().isNotEmpty
            ? "$_selectedAltPhoneCtry ${_mobileOptionalController.text.trim()}"
                .trim()
            : "",
        whatsapp: _waMobileController.text.trim().isNotEmpty
            ? "$_selectedWAPhoneCtry ${_waMobileController.text.trim()}".trim()
            : "",

        // Personal Details
        gender: _selectedGender,
        dob: _dobController.text.trim(),
        maritalStatus: _selectedMaritalStatus,

        // Address
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        country: _countryController.text.trim(),
        pincode: _pincodeController.text.trim(),

        // Lead Management
        leadSource: _selectedLeadSource,
        sourceCampaign: _selectedSourceCampaign,
        status: _selectedStatus,
        serviceType: _selectedService,
        assignedTo: _selectedAgent,
        branch: "AFFINIX",

        // Preferences & Interests
        countryInterested: selectedCountries,
        productInterest: _selectedProductInterest,
        budget: double.tryParse(_budgetController.text.trim()),
        preferredLocation: _preferredLocationController.text.trim(),
        preferredDate: _preferredDate,
        note: _notesController.text.trim(),

        // Communication Preferences
        phoneCommunication: _phoneCommunication,
        emailCommunication: _emailCommunication,
        whatsappCommunication: _whatsappCommunication,
        onCallCommunication: _onCallCommunication,

        // Loan Information
        requiresHomeLoan: _requiresLoan,
        loanAmountRequired: double.tryParse(_loanAmountController.text.trim()),
        createdAt: widget.lead?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),

        travelPurpose:
            _selectedService == 'TRAVEL' ? _selectedTravelPurpose : null,
        accommodationPreference: _selectedService == 'TRAVEL'
            ? _selectedAccommodationPreference
            : null,
        visaTypeRequired:
            _selectedService == 'TRAVEL' ? _selectedVisaType : null,
        numberOfTravelers: _selectedService == 'TRAVEL'
            ? int.tryParse(_numberOfTravelersController.text.trim())
            : null,
        travelDuration: _selectedService == 'TRAVEL'
            ? int.tryParse(_travelDurationController.text.trim())
            : null,

        preferredStudyMode:
            _selectedService == 'EDUCATION' ? _selectedStudyMode : null,
        batchPreference:
            _selectedService == 'EDUCATION' ? _selectedBatch : null,
        highestQualification: _selectedService == 'EDUCATION'
            ? _selectedHighestQualification
            : null,

        vehicleType:
            _selectedService == 'VEHICLE' ? _selectedVehicleType : null,
        brandPreference:
            _selectedService == 'VEHICLE' ? _selectedBrandPreference : null,
        modelPreference:
            _selectedService == 'VEHICLE' ? _selectedModelPreference : null,
        fuelType: _selectedService == 'VEHICLE' ? _selectedFuelType : null,
        transmission:
            _selectedService == 'VEHICLE' ? _selectedTransmission : null,
        insuranceType:
            _selectedService == 'VEHICLE' ? _selectedInsuranceType : null,
        downPaymentAvailable: _selectedService == 'VEHICLE'
            ? double.tryParse(_downPaymentController.text.trim())
            : null,

        propertyType:
            _selectedService == 'REAL_ESTATE' ? _selectedPropertyType : null,
        propertyUse:
            _selectedService == 'REAL_ESTATE' ? _selectedPropertyUse : null,
        possessionTimeline: _selectedService == 'REAL_ESTATE'
            ? _selectedPossessionTimeline
            : null,
        furnishingPreference: _selectedService == 'REAL_ESTATE'
            ? _selectedFurnishingPreference
            : null,
        groupType:
            _selectedService == 'REAL_ESTATE' ? _selectedGroupType : null,
        totalPeoples: _selectedService == 'REAL_ESTATE'
            ? _totalPeoplesController.text.trim()
            : null,
        requiresLegalAssistance:
            _selectedService == 'REAL_ESTATE' ? _requiresLegalAssistance : null,
      );

      if (widget.isEditMode) {
        // await leadController.updateLead(context, lead);
      } else {
        await leadController.createLead(context, lead);
      }

      if (mounted) {
        Navigator.of(context).pop(); // Close loader
        Navigator.of(context).pop(); // Close dialog
      }
    }
  }

  Widget _buildServiceSpecificFields() {
    switch (_selectedService) {
      case 'TRAVEL':
        return _buildTravelFields();
      case 'EDUCATION':
        return _buildEducationFields();
      case 'VEHICLE':
        return _buildVehicleFields();
      case 'REAL_ESTATE':
        return _buildRealEstateFields();
      case 'MIGRATION':
        return const SizedBox(); // No specific fields for Migration yet
      default:
        return const SizedBox();
    }
  }

  Widget _buildTravelFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
            title: 'Travel Details', icon: Icons.flight_takeoff_rounded),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 2,
          children: [
            CustomDropdownField(
              label: 'Travel Purpose',
              value: _selectedTravelPurpose,
              items: const [
                'BUSINESS',
                'HONEYMOON',
                'FAMILY',
                'FRIENDS',
                'SOLO'
              ],
              onChanged: (val) => setState(() => _selectedTravelPurpose = val),
            ),
            CustomTextFormField(
              label: 'Number of Travelers',
              controller: _numberOfTravelersController,
              keyboardType: TextInputType.number,
            ),
            CustomDropdownField(
              label: 'Accommodation Preference',
              value: _selectedAccommodationPreference,
              items: const ['BUDGET', 'STANDARD', 'LUXURY'],
              onChanged: (val) =>
                  setState(() => _selectedAccommodationPreference = val),
            ),
            CustomTextFormField(
              label: 'Travel Duration (days)',
              controller: _travelDurationController,
              keyboardType: TextInputType.number,
            ),
            CustomDropdownField(
              label: 'Visa Type Required',
              value: _selectedVisaType,
              items: const ['TOURIST', 'BUSINESS', 'STUDENT', 'WORK'],
              onChanged: (val) => setState(() => _selectedVisaType = val),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEducationFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
            title: 'Education Details', icon: Icons.school_rounded),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 2,
          children: [
            CustomDropdownField(
              label: 'Preferred Study Mode',
              value: _selectedStudyMode,
              items: const ['ONLINE', 'OFFLINE', 'HYBRID'],
              onChanged: (val) => setState(() => _selectedStudyMode = val),
            ),
            CustomDropdownField(
              label: 'Batch Preference',
              value: _selectedBatch,
              items: const ['MORNING', 'AFTERNOON', 'EVENING', 'WEEKEND'],
              onChanged: (val) => setState(() => _selectedBatch = val),
            ),
            CustomDropdownField(
              label: 'Highest Qualification',
              value: _selectedHighestQualification,
              items: configController.configData.value.programType
                      ?.map((e) => e.name ?? "")
                      .toList() ??
                  [],
              onChanged: (val) =>
                  setState(() => _selectedHighestQualification = val),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
            title: 'Vehicle Details', icon: Icons.directions_car_rounded),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 2,
          children: [
            CustomDropdownField(
              label: 'Vehicle Type',
              value: _selectedVehicleType,
              items: const ['NEW', 'USED'],
              onChanged: (val) => setState(() => _selectedVehicleType = val),
            ),
            CustomTextFormField(
              label: 'Brand Preference',
              controller: TextEditingController(text: _selectedBrandPreference),
              // onChanged: (val) => setState(() => _selectedBrandPreference = val),
            ),
            CustomTextFormField(
              label: 'Model Preference',
              controller: TextEditingController(text: _selectedModelPreference),
              // onChanged: (val) => setState(() => _selectedModelPreference = val),
            ),
            CustomDropdownField(
              label: 'Fuel Type',
              value: _selectedFuelType,
              items: const ['PETROL', 'DIESEL', 'ELECTRIC', 'CNG'],
              onChanged: (val) => setState(() => _selectedFuelType = val),
            ),
            CustomDropdownField(
              label: 'Transmission',
              value: _selectedTransmission,
              items: const ['MANUAL', 'AUTOMATIC'],
              onChanged: (val) => setState(() => _selectedTransmission = val),
            ),
            CustomDropdownField(
              label: 'Insurance Type',
              value: _selectedInsuranceType,
              items: const ['COMPREHENSIVE', 'THIRD_PARTY'],
              onChanged: (val) => setState(() => _selectedInsuranceType = val),
            ),
            CustomTextFormField(
              label: 'Down Payment Available',
              controller: _downPaymentController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRealEstateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
            title: 'Real Estate Details', icon: Icons.home_work_rounded),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 2,
          children: [
            CustomDropdownField(
              label: 'Property Type',
              value: _selectedPropertyType,
              items: const ['RESIDENTIAL', 'COMMERCIAL', 'PLOT', 'INDUSTRIAL'],
              onChanged: (val) => setState(() => _selectedPropertyType = val),
            ),
            CustomDropdownField(
              label: 'Property Use',
              value: _selectedPropertyUse,
              items: const ['SELF_USE', 'INVESTMENT', 'RENTAL'],
              onChanged: (val) => setState(() => _selectedPropertyUse = val),
            ),
            CustomDropdownField(
              label: 'Possession Timeline',
              value: _selectedPossessionTimeline,
              items: const ['IMMEDIATE', '3_MONTHS', '6_MONTHS', '1_YEAR'],
              onChanged: (val) =>
                  setState(() => _selectedPossessionTimeline = val),
            ),
            CustomDropdownField(
              label: 'Furnishing Preference',
              value: _selectedFurnishingPreference,
              items: const ['FULLY_FURNISHED', 'SEMI_FURNISHED', 'UNFURNISHED'],
              onChanged: (val) =>
                  setState(() => _selectedFurnishingPreference = val),
            ),
            CustomDropdownField(
              label: 'Group Type',
              value: _selectedGroupType,
              items: const ['COUPLE', 'MARRIED_COUPLE', 'BOYS', 'GIRLS'],
              onChanged: (val) => setState(() => _selectedGroupType = val),
            ),
            CustomTextFormField(
              label: 'Total People',
              controller: _totalPeoplesController,
            ),
            EnhancedSwitchTile(
              label: 'Requires Legal Assistance',
              icon: Icons.gavel_rounded,
              value: _requiresLegalAssistance,
              onChanged: (val) =>
                  setState(() => _requiresLegalAssistance = val),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
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
    _budgetController.dispose();
    _notesController.dispose();
    _preferredLocationController.dispose();
    _loanAmountController.dispose();
    _numberOfTravelersController.dispose();
    _travelDurationController.dispose();
    _downPaymentController.dispose();
    _totalPeoplesController.dispose();
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
                          child: Icon(
                            widget.isEditMode
                                ? Icons.edit_rounded
                                : Icons.leaderboard_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: widget.isEditMode
                                    ? 'Edit Lead'
                                    : 'Add New Lead',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: widget.isEditMode
                                    ? 'Update lead information and preferences'
                                    : 'Capture lead details for follow up',
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
                                                  // Service Type & Lead Source
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CustomDropdownField(
                                                          label:
                                                              'Service Type *',
                                                          value:
                                                              _selectedService,
                                                          items: const [
                                                            'TRAVEL',
                                                            'EDUCATION',
                                                            'VEHICLE',
                                                            'REAL_ESTATE',
                                                            'MIGRATION'
                                                          ],
                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  _selectedService =
                                                                      value),
                                                          isRequired: true,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child:
                                                            CustomDropdownField(
                                                          label:
                                                              'Lead Source *',
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
                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  _selectedLeadSource =
                                                                      value),
                                                          isRequired: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),

                                                  // Source Campaign & Status
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CustomDropdownField(
                                                          label:
                                                              'Source Campaign',
                                                          value:
                                                              _selectedSourceCampaign,
                                                          items: const [
                                                            'WEBSITE',
                                                            'SOCIAL_MEDIA',
                                                            'REFERRAL',
                                                            'DIRECT',
                                                            'OTHER'
                                                          ],
                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  _selectedSourceCampaign =
                                                                      value),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child:
                                                            CustomDropdownField(
                                                          label: 'Status *',
                                                          value:
                                                              _selectedStatus,
                                                          items: const [
                                                            'NEW',
                                                            'CONTACTED',
                                                            'QUALIFIED',
                                                            'PROPOSAL_SENT',
                                                            'NEGOTIATION',
                                                            'WON',
                                                            'LOST'
                                                          ],
                                                          onChanged: (value) =>
                                                              setState(() =>
                                                                  _selectedStatus =
                                                                      value),
                                                          isRequired: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  const SectionTitle(
                                                      title: 'Primary Details',
                                                      icon: Icons
                                                          .person_outline_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomTextFormField(
                                                        label: 'First Name *',
                                                        controller:
                                                            _nameController,
                                                        isRequired: true,
                                                      ),
                                                      CustomTextFormField(
                                                        label: 'Last Name',
                                                        controller:
                                                            _lastNameController,
                                                      ),
                                                      CustomPhoneField(
                                                        showCountryCode: true,
                                                        label:
                                                            'Mobile Number *',
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
                                                      CustomTextFormField(
                                                        label: 'Email ID *',
                                                        controller:
                                                            _emailController,
                                                        isEmail: true,
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
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  const SectionTitle(
                                                      title: 'Personal Details',
                                                      icon: Icons
                                                          .person_pin_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
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
                                                          'Married',
                                                          'Divorced',
                                                          'Widowed'
                                                        ],
                                                        onChanged: (val) =>
                                                            setState(() =>
                                                                _selectedMaritalStatus =
                                                                    val),
                                                      ),
                                                      CustomDateField(
                                                        label: 'Date of Birth',
                                                        controller:
                                                            _dobController,
                                                        endDate: DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 365 *
                                                                        18)),
                                                        onChanged:
                                                            (formattedDate) =>
                                                                _dobController
                                                                        .text =
                                                                    formattedDate,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  const SectionTitle(
                                                      title:
                                                          'Address Information',
                                                      icon: Icons
                                                          .location_on_rounded),
                                                  const SizedBox(height: 16),
                                                  CustomTextFormField(
                                                    label: 'Address',
                                                    controller:
                                                        _addressController,
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
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
                                                      CustomTextFormField(
                                                        label: 'Pincode',
                                                        controller:
                                                            _pincodeController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  const SectionTitle(
                                                      title: 'Lead Preferences',
                                                      icon: Icons
                                                          .interests_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      CustomCheckDropdown(
                                                        label:
                                                            'Countries Interested',
                                                        items: configController
                                                                .configData
                                                                .value
                                                                .country
                                                                ?.map((e) =>
                                                                    e.name ??
                                                                    "")
                                                                .toList() ??
                                                            [],
                                                        values:
                                                            selectedCountries,
                                                        onChanged: (value) =>
                                                            setState(() =>
                                                                selectedCountries =
                                                                    value.cast<
                                                                        String>()),
                                                      ),
                                                      CustomCheckDropdown(
                                                        label:
                                                            'Product Interest',
                                                        items: configController
                                                                .configData
                                                                .value
                                                                .specialized
                                                                ?.map((e) =>
                                                                    e.name ??
                                                                    "")
                                                                .toList() ??
                                                            [],
                                                        values:
                                                            _selectedProductInterest ??
                                                                [],
                                                        onChanged: (value) =>
                                                            setState(() =>
                                                                _selectedProductInterest =
                                                                    value.cast<
                                                                        String>()),
                                                      ),
                                                      CustomTextFormField(
                                                        label: 'Budget',
                                                        controller:
                                                            _budgetController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      CustomTextFormField(
                                                        label:
                                                            'Preferred Location',
                                                        controller:
                                                            _preferredLocationController,
                                                      ),
                                                      CustomDateField(
                                                        label: 'Preferred Date',
                                                        controller:
                                                            TextEditingController(
                                                          text: _preferredDate !=
                                                                  null
                                                              ? DateFormat(
                                                                      'dd/MM/yyyy')
                                                                  .format(
                                                                      _preferredDate!)
                                                              : '',
                                                        ),
                                                        onChanged: (value) {
                                                          if (value
                                                              .isNotEmpty) {
                                                            setState(() {
                                                              _preferredDate =
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .parse(
                                                                          value);
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  // Service Specific Fields
                                                  _buildServiceSpecificFields(),
                                                  const SizedBox(height: 24),

                                                  // Loan Requirements
                                                  const SectionTitle(
                                                      title:
                                                          'Loan Requirements',
                                                      icon: Icons
                                                          .attach_money_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
                                                      EnhancedSwitchTile(
                                                        label: 'Requires Loan',
                                                        icon:
                                                            Icons.money_rounded,
                                                        value: _requiresLoan,
                                                        onChanged: (val) =>
                                                            setState(() =>
                                                                _requiresLoan =
                                                                    val),
                                                      ),
                                                      if (_requiresLoan)
                                                        CustomTextFormField(
                                                          label:
                                                              'Loan Amount Required',
                                                          controller:
                                                              _loanAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  // Assignment & Priority
                                                  const SectionTitle(
                                                      title: 'Assignment',
                                                      icon: Icons
                                                          .assignment_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                    columns: columnsCount,
                                                    children: [
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
                                                        onChanged: (p0) =>
                                                            setState(() =>
                                                                _selectedAgent = p0
                                                                        ?.split(
                                                                            ",")
                                                                        .last ??
                                                                    ""),
                                                        isSplit: true,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Priority *',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          DropdownButtonFormField<
                                                              int>(
                                                            value:
                                                                _selectedPriority,
                                                            items: [
                                                              1,
                                                              2,
                                                              3,
                                                              4,
                                                              5
                                                            ].map((priority) {
                                                              return DropdownMenuItem<
                                                                  int>(
                                                                value: priority,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .flag,
                                                                      color: AppColors
                                                                          .getPriorityColor(
                                                                              priority),
                                                                      size: 16,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                        'Priority $priority'),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (value) =>
                                                                setState(() =>
                                                                    _selectedPriority =
                                                                        value!),
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),

                                                  // Communication Preferences (for small screens)
                                                  if (maxWidth <= 1000) ...[
                                                    const SectionTitle(
                                                        title:
                                                            'Communication Preference',
                                                        icon: Icons
                                                            .notifications_active_rounded),
                                                    const SizedBox(height: 16),
                                                    ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        EnhancedSwitchTile(
                                                          label:
                                                              'Phone Communication',
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
                                                          value:
                                                              _emailCommunication,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _emailCommunication =
                                                                      val),
                                                        ),
                                                        EnhancedSwitchTile(
                                                          label:
                                                              'WhatsApp Communication',
                                                          icon: Icons
                                                              .chat_rounded,
                                                          value:
                                                              _whatsappCommunication,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _whatsappCommunication =
                                                                      val),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 24),
                                                  ],

                                                  // Additional Notes
                                                  const SectionTitle(
                                                      title:
                                                          'Additional Information',
                                                      icon: Icons.note_rounded),
                                                  const SizedBox(height: 16),
                                                  CustomTextFormField(
                                                    label: 'Notes',
                                                    controller:
                                                        _notesController,
                                                    maxLines: 4,
                                                  ),
                                                  const SizedBox(height: 32),
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
                                              text: widget.isEditMode
                                                  ? 'Update Lead'
                                                  : 'Save Lead',
                                              icon: Icons.save_rounded,
                                              isFilled: true,
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF7F00FF),
                                                  Color(0xFFE100FF)
                                                ],
                                              ),
                                              onPressed: _saveLead,
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
                                                widget.isEditMode
                                                    ? Icons.edit_rounded
                                                    : Icons
                                                        .person_add_alt_1_rounded,
                                                size: 40,
                                                color: AppColors
                                                    .violetPrimaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: CustomText(
                                                text:
                                                    'Communication Preferences',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            CustomText(
                                              text: widget.isEditMode
                                                  ? 'Update communication preferences'
                                                  : 'Choose how to communicate with this lead',
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
                                                  label: 'Phone Communication',
                                                  icon: Icons.phone_rounded,
                                                  value: _phoneCommunication,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          _phoneCommunication =
                                                              val),
                                                ),
                                                const SizedBox(height: 12),
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
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/lead/lead_controller.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/model/lead/lead_model.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';

// class AddEditLeadScreen extends StatefulWidget {
//   final LeadModel? lead;
//   final bool isEditMode;

//   const AddEditLeadScreen({super.key, this.lead, required this.isEditMode});

//   @override
//   State<AddEditLeadScreen> createState() => _AddEditLeadScreenState();
// }

// class _AddEditLeadScreenState extends State<AddEditLeadScreen> {
//   final configController = Get.find<ConfigController>();
//   final officersController = Get.find<OfficersController>();
//   final leadController = Get.find<LeadController>();
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
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _qualificationController =
//       TextEditingController();
//   final TextEditingController _courseNameController = TextEditingController();
//   final TextEditingController _remarksController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _skillController = TextEditingController();
//   final TextEditingController _companyController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _productInterestController =
//       TextEditingController();
//   final TextEditingController _serviceRequiredController =
//       TextEditingController();
//   final TextEditingController _budgetController = TextEditingController();
//   final TextEditingController _preferredLocationController =
//       TextEditingController();

//   // Form values
//   String? _selectedService = 'MIGRATION';
//   String? _selectedGender;
//   String? _selectedMaritalStatus;
//   String? _selectedPhoneCtry = "+91";
//   String? _selectedAltPhoneCtry = "+91";
//   String? _selectedWAPhoneCtry = "+91";
//   String? _selectedLeadSource;
//   String? _selectedQualification;
//   String? _selectedCourse;
//   String? _selectedAgent;
//   String? _selectedBusinessType = 'TRAVEL';
//   String? _selectedStatus = 'NEW';
//   String? _selectedProfession;

//   // Preferences
//   bool _phoneCommunication = true;
//   bool _sendEmail = false;
//   bool _sendWhatsapp = false;
//   bool _onCallCommunication = false;

//   // Multi-select
//   List<String> selectedCountries = [];
//   List<String>? _selectedSpecialized;

//   int _selectedPriority = 3;
//   DateTime? _preferredDate;

//   @override
//   void initState() {
//     super.initState();
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
//       _emailController.text = lead.email ?? '';
//       _mobileController.text = lead.phone ?? '';
//       // _companyController.text = lead.company ?? '';
//       // _designationController.text = lead.designation ?? '';

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

//       // Professional Details
//       _selectedProfession = lead.profession;
//       _selectedSpecialized = lead.specializedIn;
//       _skillController.text = lead.skills?.join(', ') ?? '';
//       _selectedQualification = lead.qualification;
//       _selectedCourse = lead.qualification;

//       // Location
//       _locationController.text = lead.address ?? '';
//       _cityController.text = lead.city ?? '';
//       _stateController.text = lead.state ?? '';
//       _countryController.text = lead.country ?? '';

//       // Lead Details
//       _selectedLeadSource = lead.leadSource;
//       selectedCountries = lead.countryInterested ?? [];
//       _selectedAgent = lead.assignedTo;
//       _remarksController.text = lead.note ?? '';

//       // Additional fields from first code
//       // _productInterestController.text = lead.productInterest ?? '';
//       // _serviceRequiredController.text = lead.serviceRequired ?? '';
//       // _budgetController.text = lead.budget?.toString() ?? '';
//       // _preferredLocationController.text = lead.preferredLocation ?? '';

//       // Preferences
//       // _phoneCommunication = lead.phoneCommunication ?? true;
//       _sendEmail = lead.onEmailCommunication ?? false;
//       _sendWhatsapp = lead.onWhatsappCommunication ?? false;
//       _onCallCommunication = lead.onCallCommunication ?? false;

//       _selectedStatus = lead.status;
//       // _selectedPriority = lead.priority ?? 3;
//     }
//   }

//   void _saveLead() async {
//     if (_formKey.currentState!.validate()) {
//       showLoaderDialog(context);

//       final lead = LeadModel(
//         // id: widget.lead?.id,
//         countryCode: _selectedPhoneCtry ?? '',
//         name: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         phone: _mobileController.text.trim(),
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
//         address: _locationController.text.trim(),
//         city: _cityController.text.trim(),
//         state: _stateController.text.trim(),
//         country: _countryController.text.trim(),
//         jobInterests: [],
//         countryInterested: selectedCountries,
//         // expectedSalary: double.tryParse(_budgetController.text.trim()) ?? 0,
//         qualification: _selectedCourse ?? "",
//         experience: 0,
//         skills: _skillController.text.trim().isNotEmpty
//             ? [_skillController.text.trim()]
//             : [],
//         profession: _selectedProfession,
//         specializedIn: _selectedSpecialized ?? [],
//         leadSource: _selectedLeadSource ?? "",
//         onCallCommunication: _onCallCommunication,
//         onWhatsappCommunication: _sendWhatsapp,
//         onEmailCommunication: _sendEmail,
//         status: _selectedStatus ?? "NEW",
//         serviceType: _selectedService ?? "",
//         branch: "AFFINIX",
//         note: _remarksController.text.trim(),

//         // Additional fields from first code
//         // company: _companyController.text.trim().isEmpty
//         //     ? null
//         //     : _companyController.text.trim(),
//         // designation: _designationController.text.trim().isEmpty
//         //     ? null
//         //     : _designationController.text.trim(),
//         // productInterest: _productInterestController.text.trim().isEmpty
//         //     ? null
//         //     : _productInterestController.text.trim(),
//         // serviceRequired: _serviceRequiredController.text.trim().isEmpty
//         //     ? null
//         //     : _serviceRequiredController.text.trim(),
//         // budget: double.tryParse(_budgetController.text.trim()),
//         // preferredLocation: _preferredLocationController.text.trim().isEmpty
//         //     ? null
//         //     : _preferredLocationController.text.trim(),
//         // preferredDate: _preferredDate,
//         // businessType: _selectedBusinessType,
//         // priority: _selectedPriority,
//         assignedTo: _selectedAgent,
//         createdAt: widget.lead?.createdAt ?? DateTime.now(),
//         updatedAt: DateTime.now(),
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

//   Color _getPriorityColor(int priority) {
//     switch (priority) {
//       case 1:
//         return Colors.green;
//       case 2:
//         return Colors.blue;
//       case 3:
//         return Colors.orange;
//       case 4:
//         return Colors.red;
//       case 5:
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _leadDateController.dispose();
//     _mobileOptionalController.dispose();
//     _locationController.dispose();
//     _qualificationController.dispose();
//     _courseNameController.dispose();
//     _remarksController.dispose();
//     _dobController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _countryController.dispose();
//     _skillController.dispose();
//     _companyController.dispose();
//     _designationController.dispose();
//     _productInterestController.dispose();
//     _serviceRequiredController.dispose();
//     _budgetController.dispose();
//     _preferredLocationController.dispose();
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
//                                                   // Business Type & Lead Source
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child:
//                                                             CustomDropdownField(
//                                                           label:
//                                                               'Business Type *',
//                                                           value:
//                                                               _selectedBusinessType,
//                                                           items: const [
//                                                             'TRAVEL',
//                                                             'EDUCATION',
//                                                             'IMMIGRATION',
//                                                             'OTHER'
//                                                           ],
//                                                           onChanged: (value) =>
//                                                               setState(() =>
//                                                                   _selectedBusinessType =
//                                                                       value),
//                                                           isRequired: true,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(width: 16),
//                                                       Expanded(
//                                                         child:
//                                                             CustomDropdownField(
//                                                           label:
//                                                               'Lead Source *',
//                                                           value:
//                                                               _selectedLeadSource,
//                                                           items: configController
//                                                                   .configData
//                                                                   .value
//                                                                   .leadSource
//                                                                   ?.map((e) =>
//                                                                       e.name ??
//                                                                       "")
//                                                                   .toList() ??
//                                                               [],
//                                                           onChanged: (value) =>
//                                                               setState(() =>
//                                                                   _selectedLeadSource =
//                                                                       value),
//                                                           isRequired: true,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   const SectionTitle(
//                                                       title: 'Primary Details',
//                                                       icon: Icons
//                                                           .person_outline_rounded),
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
//                                                         label: 'Email ID *',
//                                                         controller:
//                                                             _emailController,
//                                                         isEmail: true,
//                                                         isRequired: true,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Company',
//                                                         controller:
//                                                             _companyController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Designation',
//                                                         controller:
//                                                             _designationController,
//                                                       ),
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
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   const SectionTitle(
//                                                       title:
//                                                           'Professional Details',
//                                                       icon: Icons
//                                                           .work_outline_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomDropdownField(
//                                                         label: 'Job Category',
//                                                         value:
//                                                             _selectedProfession,
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .jobCategory
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedProfession =
//                                                                     val),
//                                                       ),
//                                                       CustomCheckDropdown(
//                                                         label:
//                                                             "Country Interested",
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .country
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [],
//                                                         values:
//                                                             selectedCountries,
//                                                         onChanged: (value) =>
//                                                             setState(() =>
//                                                                 selectedCountries =
//                                                                     value.cast<
//                                                                         String>()),
//                                                       ),
//                                                       CustomCheckDropdown(
//                                                         label: 'Specialized',
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .specialized
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedSpecialized =
//                                                                     val.cast<
//                                                                         String>()),
//                                                         values:
//                                                             _selectedSpecialized ??
//                                                                 [],
//                                                       ),
//                                                       CustomTextFormField(
//                                                         controller:
//                                                             _skillController,
//                                                         label: 'Skills',
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Education',
//                                                         value:
//                                                             _selectedQualification,
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .programType
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [],
//                                                         onChanged: (String?
//                                                                 val) =>
//                                                             setState(() =>
//                                                                 _selectedQualification =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label:
//                                                             'Education Program',
//                                                         value: _selectedCourse,
//                                                         items: configController
//                                                                 .configData
//                                                                 .value
//                                                                 .program
//                                                                 ?.map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList() ??
//                                                             [],
//                                                         onChanged: (String?
//                                                                 val) =>
//                                                             setState(() =>
//                                                                 _selectedCourse =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   const SectionTitle(
//                                                       title: 'Lead Details',
//                                                       icon: Icons
//                                                           .description_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Product/Service Interest',
//                                                         controller:
//                                                             _productInterestController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Service Required',
//                                                         controller:
//                                                             _serviceRequiredController,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label: 'Budget',
//                                                         controller:
//                                                             _budgetController,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                       ),
//                                                       CustomTextFormField(
//                                                         label:
//                                                             'Preferred Location',
//                                                         controller:
//                                                             _preferredLocationController,
//                                                       ),
//                                                       CustomDateField(
//                                                         label: 'Preferred Date',
//                                                         controller:
//                                                             TextEditingController(
//                                                           text: _preferredDate !=
//                                                                   null
//                                                               ? DateFormat(
//                                                                       'dd/MM/yyyy')
//                                                                   .format(
//                                                                       _preferredDate!)
//                                                               : '',
//                                                         ),
//                                                         onChanged: (value) {
//                                                           if (value
//                                                               .isNotEmpty) {
//                                                             setState(() {
//                                                               _preferredDate =
//                                                                   DateFormat(
//                                                                           'dd/MM/yyyy')
//                                                                       .parse(
//                                                                           value);
//                                                             });
//                                                           }
//                                                         },
//                                                       ),
//                                                       CustomOfficerDropDown(
//                                                         label: 'Assigned To',
//                                                         value: _selectedAgent,
//                                                         items:
//                                                             officersController
//                                                                 .officersList
//                                                                 .map((e) =>
//                                                                     e.name ??
//                                                                     "")
//                                                                 .toList(),
//                                                         onChanged: (p0) =>
//                                                             setState(() =>
//                                                                 _selectedAgent = p0
//                                                                         ?.split(
//                                                                             ",")
//                                                                         .last ??
//                                                                     ""),
//                                                         isSplit: true,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   // Status & Priority
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child:
//                                                             CustomDropdownField(
//                                                           label: 'Status *',
//                                                           value:
//                                                               _selectedStatus,
//                                                           items: const [
//                                                             'NEW',
//                                                             'CONTACTED',
//                                                             'QUALIFIED',
//                                                             'PROPOSAL SENT',
//                                                             'NEGOTIATION',
//                                                             'WON',
//                                                             'LOST'
//                                                           ],
//                                                           onChanged: (value) =>
//                                                               setState(() =>
//                                                                   _selectedStatus =
//                                                                       value),
//                                                           isRequired: true,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(width: 16),
//                                                       Expanded(
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             const Text(
//                                                               'Priority *',
//                                                               style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontSize: 14,
//                                                                 color:
//                                                                     Colors.grey,
//                                                               ),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 8),
//                                                             DropdownButtonFormField<
//                                                                 int>(
//                                                               value:
//                                                                   _selectedPriority,
//                                                               items: [
//                                                                 1,
//                                                                 2,
//                                                                 3,
//                                                                 4,
//                                                                 5
//                                                               ].map((priority) {
//                                                                 return DropdownMenuItem<
//                                                                     int>(
//                                                                   value:
//                                                                       priority,
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Icon(
//                                                                         Icons
//                                                                             .flag,
//                                                                         color: _getPriorityColor(
//                                                                             priority),
//                                                                         size:
//                                                                             16,
//                                                                       ),
//                                                                       const SizedBox(
//                                                                           width:
//                                                                               8),
//                                                                       Text(
//                                                                           'Priority $priority'),
//                                                                     ],
//                                                                   ),
//                                                                 );
//                                                               }).toList(),
//                                                               onChanged: (value) =>
//                                                                   setState(() =>
//                                                                       _selectedPriority =
//                                                                           value!),
//                                                               decoration:
//                                                                   const InputDecoration(
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                                 contentPadding:
//                                                                     EdgeInsets.symmetric(
//                                                                         horizontal:
//                                                                             12),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   const SectionTitle(
//                                                       title: 'Personal Details',
//                                                       icon: Icons
//                                                           .person_pin_rounded),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
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
//                                                       CustomDateField(
//                                                         label: 'DOB',
//                                                         controller:
//                                                             _dobController,
//                                                         endDate: DateTime.now()
//                                                             .subtract(
//                                                                 const Duration(
//                                                                     days: 365 *
//                                                                         18)),
//                                                         onChanged:
//                                                             (formattedDate) =>
//                                                                 _dobController
//                                                                         .text =
//                                                                     formattedDate,
//                                                       ),
//                                                       CustomPhoneField(
//                                                         label:
//                                                             'Alternate Mobile',
//                                                         controller:
//                                                             _mobileOptionalController,
//                                                         selectedCountry:
//                                                             _selectedAltPhoneCtry,
//                                                         onCountryChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedAltPhoneCtry =
//                                                                     val),
//                                                       ),
//                                                       CustomDropdownField(
//                                                         label: 'Marital Status',
//                                                         value:
//                                                             _selectedMaritalStatus,
//                                                         items: const [
//                                                           'Single',
//                                                           'Married',
//                                                           'Divorced',
//                                                           'Widowed'
//                                                         ],
//                                                         onChanged: (val) =>
//                                                             setState(() =>
//                                                                 _selectedMaritalStatus =
//                                                                     val),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(height: 24),

//                                                   const SectionTitle(
//                                                       title: 'Location Details',
//                                                       icon: Icons
//                                                           .location_on_rounded),
//                                                   const SizedBox(height: 16),
//                                                   CustomTextFormField(
//                                                     label: 'Address',
//                                                     controller:
//                                                         _locationController,
//                                                     maxLines: 2,
//                                                   ),
//                                                   const SizedBox(height: 16),
//                                                   ResponsiveGrid(
//                                                     columns: columnsCount,
//                                                     children: [
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
//                                                     ],
//                                                   ),

//                                                   // Communication Preferences (for small screens)
//                                                   if (maxWidth <= 1000) ...[
//                                                     const SizedBox(height: 32),
//                                                     const SectionTitle(
//                                                         title:
//                                                             'Communication Preference',
//                                                         icon: Icons
//                                                             .notifications_active_rounded),
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
//                                                           value: _sendEmail,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _sendEmail =
//                                                                       val),
//                                                         ),
//                                                         EnhancedSwitchTile(
//                                                           label:
//                                                               'WhatsApp Communication',
//                                                           icon: Icons
//                                                               .chat_rounded,
//                                                           value: _sendWhatsapp,
//                                                           onChanged: (val) =>
//                                                               setState(() =>
//                                                                   _sendWhatsapp =
//                                                                       val),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],

//                                                   const SizedBox(height: 24),
//                                                   const SectionTitle(
//                                                       title:
//                                                           'Additional Information',
//                                                       icon: Icons.note_rounded),
//                                                   const SizedBox(height: 16),
//                                                   CustomTextFormField(
//                                                     label: 'Remarks',
//                                                     controller:
//                                                         _remarksController,
//                                                     maxLines: 3,
//                                                   ),
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
//                                                   label: 'Send Email Updates',
//                                                   icon: Icons.email_rounded,
//                                                   value: _sendEmail,
//                                                   onChanged: (val) => setState(
//                                                       () => _sendEmail = val),
//                                                 ),
//                                                 const SizedBox(height: 12),
//                                                 EnhancedSwitchTile(
//                                                   label:
//                                                       'WhatsApp Communication',
//                                                   icon: Icons.chat_rounded,
//                                                   value: _sendWhatsapp,
//                                                   onChanged: (val) => setState(
//                                                       () =>
//                                                           _sendWhatsapp = val),
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

// // view/lead/add_edit_lead_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../../controller/config/config_controller.dart';
// import '../../../../controller/lead/lead_controller.dart';
// import '../../../../controller/officers_controller/officers_controller.dart';
// import '../../../widgets/widgets.dart';
// import '../lead_data_display.dart';
// // import '../lead_page_for_erp.dart';

// class AddEditLead extends StatefulWidget {
//   final Lead? lead;
//   final bool isEditMode;

//   const AddEditLead({super.key, this.lead, required this.isEditMode});

//   @override
//   State<AddEditLead> createState() => _AddEditLeadState();
// }

// class _AddEditLeadState extends State<AddEditLead> {
//   final _formKey = GlobalKey<FormState>();
//   final leadController = Get.find<LeadController>();
//   final officersController = Get.find<OfficersController>();
//   final configController = Get.find<ConfigController>();

//   // Basic Information
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _companyController = TextEditingController();
//   final _designationController = TextEditingController();

//   // Lead Details
//   final _productInterestController = TextEditingController();
//   final _serviceRequiredController = TextEditingController();
//   final _budgetController = TextEditingController();
//   final _preferredLocationController = TextEditingController();
//   final _notesController = TextEditingController();

//   // Address
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _pincodeController = TextEditingController();

//   // Additional Fields
//   final _alternatePhoneController = TextEditingController();
//   final _whatsappController = TextEditingController();
//   final _dobController = TextEditingController();
//   final _skillsController = TextEditingController();
//   final _qualificationController = TextEditingController();
//   final _educationProgramController = TextEditingController();

//   // Dropdown Values
//   String? _selectedBusinessType;
//   String? _selectedLeadSource;
//   String? _selectedStatus;
//   String? _selectedGender;
//   String? _selectedMaritalStatus;
//   String? _selectedProfession;
//   String? _selectedAgent;
//   int _selectedPriority = 3;
//   DateTime? _preferredDate;

//   // Communication Preferences
//   bool _phoneCommunication = true;
//   bool _emailCommunication = false;
//   bool _whatsappCommunication = false;
//   bool _onCallCommunication = false;

//   // Custom Fields & Multi-select
//   Map<String, dynamic> _customFields = {};
//   List<String> _selectedCountries = [];
//   List<String> _selectedSpecializations = [];

//   @override
//   void initState() {
//     _initializeForm();
//     super.initState();
//   }

//   void _initializeForm() {
//     if (widget.isEditMode && widget.lead != null) {
//       final lead = widget.lead!;

//       // Basic Information
//       _fullNameController.text = lead.fullName;
//       _emailController.text = lead.email;
//       _phoneController.text = lead.phone;
//       _companyController.text = lead.company ?? '';
//       _designationController.text = lead.designation ?? '';

//       // Lead Details
//       _productInterestController.text = lead.productInterest ?? '';
//       _serviceRequiredController.text = lead.serviceRequired ?? '';
//       _budgetController.text = lead.budget?.toString() ?? '';
//       _preferredLocationController.text = lead.preferredLocation ?? '';
//       _notesController.text = lead.notes ?? '';

//       // Address
//       _addressController.text = lead.address ?? '';
//       _cityController.text = lead.city ?? '';
//       _stateController.text = lead.state ?? '';
//       _countryController.text = lead.country ?? '';
//       _pincodeController.text = lead.pincode ?? '';

//       // // Additional Fields
//       // _alternatePhoneController.text = lead.alternatePhone ?? '';
//       // _whatsappController.text = lead.whatsappNumber ?? '';
//       // _dobController.text = lead.dateOfBirth ?? '';
//       // _skillsController.text = lead.skills ?? '';
//       // _qualificationController.text = lead.qualification ?? '';
//       // _educationProgramController.text = lead.educationProgram ?? '';

//       // // Dropdowns
//       // _selectedBusinessType = lead.businessType;
//       // _selectedLeadSource = lead.leadSource;
//       // _selectedStatus = lead.status;
//       // _selectedGender = lead.gender;
//       // _selectedMaritalStatus = lead.maritalStatus;
//       // _selectedProfession = lead.profession;
//       // _selectedPriority = lead.priority;
//       // _preferredDate = lead.preferredDate;

//       // // Communication Preferences
//       // _phoneCommunication = lead.phoneCommunication;
//       // _emailCommunication = lead.emailCommunication;
//       // _whatsappCommunication = lead.whatsappCommunication;
//       // _onCallCommunication = lead.onCallCommunication;

//       // // Multi-select
//       // _selectedCountries = lead.countriesInterested ?? [];
//       // _selectedSpecializations = lead.specializedIn ?? [];

//       // Custom Fields
//       _customFields = lead.customFields ?? {};
//     } else {
//       _selectedBusinessType = 'TRAVEL';
//       _selectedLeadSource = 'WEBSITE';
//       _selectedStatus = 'NEW';
//       _leadDateController.text =
//           DateFormat("dd/MM/yyyy").format(DateTime.now());
//     }
//   }

//   void _saveLead() {
//     if (_formKey.currentState!.validate()) {
//       final lead = Lead(
//         id: widget.lead?.id,
//         businessType: _selectedBusinessType!,
//         leadSource: _selectedLeadSource!,
//         status: _selectedStatus!,
//         fullName: _fullNameController.text.trim(),
//         email: _emailController.text.trim(),
//         phone: _phoneController.text.trim(),
//         company: _companyController.text.trim().isEmpty
//             ? null
//             : _companyController.text.trim(),
//         designation: _designationController.text.trim().isEmpty
//             ? null
//             : _designationController.text.trim(),
//         productInterest: _productInterestController.text.trim().isEmpty
//             ? null
//             : _productInterestController.text.trim(),
//         serviceRequired: _serviceRequiredController.text.trim().isEmpty
//             ? null
//             : _serviceRequiredController.text.trim(),
//         budget: _budgetController.text.trim().isEmpty
//             ? null
//             : double.tryParse(_budgetController.text.trim()),
//         preferredLocation: _preferredLocationController.text.trim().isEmpty
//             ? null
//             : _preferredLocationController.text.trim(),
//         preferredDate: _preferredDate,
//         address: _addressController.text.trim().isEmpty
//             ? null
//             : _addressController.text.trim(),
//         city: _cityController.text.trim().isEmpty
//             ? null
//             : _cityController.text.trim(),
//         state: _stateController.text.trim().isEmpty
//             ? null
//             : _stateController.text.trim(),
//         country: _countryController.text.trim().isEmpty
//             ? null
//             : _countryController.text.trim(),
//         pincode: _pincodeController.text.trim().isEmpty
//             ? null
//             : _pincodeController.text.trim(),
//         customFields: _customFields.isEmpty ? null : _customFields,
//         timeline: widget.lead?.timeline ?? [],
//         assignedTo: _selectedAgent,
//         priority: _selectedPriority,
//         createdAt: widget.lead?.createdAt ?? DateTime.now(),
//         updatedAt: DateTime.now(),
//         createdBy: widget.lead?.createdBy,
//         notes: _notesController.text.trim().isEmpty
//             ? null
//             : _notesController.text.trim(),

//         // Communication Preferences
//         // phoneCommunication: _phoneCommunication,
//         // emailCommunication: _emailCommunication,
//         // whatsappCommunication: _whatsappCommunication,
//         // onCallCommunication: _onCallCommunication,

//         // // Additional Fields
//         // gender: _selectedGender,
//         // maritalStatus: _selectedMaritalStatus,
//         // alternatePhone: _alternatePhoneController.text.trim().isEmpty
//         //     ? null
//         //     : _alternatePhoneController.text.trim(),
//         // whatsappNumber: _whatsappController.text.trim().isEmpty
//         //     ? null
//         //     : _whatsappController.text.trim(),
//         // dateOfBirth: _dobController.text.trim().isEmpty
//         //     ? null
//         //     : _dobController.text.trim(),
//         // specializedIn: _selectedSpecializations.isEmpty ? null : _selectedSpecializations,
//         // qualification: _qualificationController.text.trim().isEmpty
//         //     ? null
//         //     : _qualificationController.text.trim(),
//         // educationProgram: _educationProgramController.text.trim().isEmpty
//         //     ? null
//         //     : _educationProgramController.text.trim(),
//         // skills: _skillsController.text.trim().isEmpty
//         //     ? null
//         //     : _skillsController.text.trim(),
//         // countriesInterested: _selectedCountries.isEmpty ? null : _selectedCountries,
//         // profession: _selectedProfession,
//       );

//       if (widget.isEditMode) {
//         // leadController.updateLead(lead);
//       } else {
//         // leadController.addLead(lead);
//       }
//       Get.back();
//     }
//   }

//   Widget _buildCustomFields() {
//     if (_selectedBusinessType == null) return const SizedBox();

//     final customFieldsConfig =
//         BusinessTypeConfig.getCustomFields(_selectedBusinessType!);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//           title: 'Additional Information',
//           icon: Icons.add_circle_outline,
//         ),
//         const SizedBox(height: 16),
//         ...customFieldsConfig.entries.map((field) {
//           final fieldKey = field.key;
//           final fieldValue = field.value;

//           if (fieldValue is List && fieldValue.isNotEmpty) {
//             // Dropdown field
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomDropdownField(
//                 label: fieldKey,
//                 value: _customFields[fieldKey],
//                 items: fieldValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _customFields[fieldKey] = value;
//                   });
//                 },
//               ),
//             );
//           } else {
//             // Text field
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomTextFormField(
//                 label: fieldKey,
//                 controller: TextEditingController(),
//                 // onChanged: (value) {
//                 //   setState(() {
//                 //     _customFields[fieldKey] = value;
//                 //   });
//                 // },
//               ),
//             );
//           }
//         }),
//       ],
//     );
//   }

//   Widget _buildCommunicationPreferences() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle(
//           title: 'Communication Preferences',
//           icon: Icons.notifications_active,
//         ),
//         const SizedBox(height: 16),
//         ResponsiveGrid(
//           columns: 2,
//           children: [
//             EnhancedSwitchTile(
//               label: 'Phone Communication',
//               icon: Icons.phone,
//               value: _phoneCommunication,
//               onChanged: (value) => setState(() => _phoneCommunication = value),
//             ),
//             EnhancedSwitchTile(
//               label: 'Email Communication',
//               icon: Icons.email,
//               value: _emailCommunication,
//               onChanged: (value) => setState(() => _emailCommunication = value),
//             ),
//             EnhancedSwitchTile(
//               label: 'WhatsApp Communication',
//               icon: Icons.chat,
//               value: _whatsappCommunication,
//               onChanged: (value) =>
//                   setState(() => _whatsappCommunication = value),
//             ),
//             EnhancedSwitchTile(
//               label: 'On Call Communication',
//               icon: Icons.call,
//               value: _onCallCommunication,
//               onChanged: (value) =>
//                   setState(() => _onCallCommunication = value),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(16),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 900),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Header
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Colors.blue.shade700,
//                         Colors.lightBlue.shade400,
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(Icons.person_add,
//                             color: Colors.white, size: 28),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.isEditMode ? 'Edit Lead' : 'Add New Lead',
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               widget.isEditMode
//                                   ? 'Update lead information and preferences'
//                                   : 'Capture lead details for follow up',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.close,
//                             color: Colors.white, size: 24),
//                         onPressed: () => Get.back(),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Form Content
//                 Expanded(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Main Form
//                       Expanded(
//                         flex: 3,
//                         child: SingleChildScrollView(
//                           padding: const EdgeInsets.all(24),
//                           child: Column(
//                             children: [
//                               // Business Type & Lead Source
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: CustomDropdownField(
//                                       label: 'Business Type *',
//                                       value: _selectedBusinessType,
//                                       items: BusinessTypeConfig.businessTypes,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _selectedBusinessType = value;
//                                           _customFields = {};
//                                         });
//                                       },
//                                       isRequired: true,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: CustomDropdownField(
//                                       label: 'Lead Source *',
//                                       value: _selectedLeadSource,
//                                       items: BusinessTypeConfig.leadSources,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _selectedLeadSource = value;
//                                         });
//                                       },
//                                       isRequired: true,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Basic Information
//                               const SectionTitle(
//                                 title: 'Basic Information',
//                                 icon: Icons.person_outline,
//                               ),
//                               const SizedBox(height: 16),
//                               ResponsiveGrid(
//                                 columns: 3,
//                                 children: [
//                                   CustomTextFormField(
//                                     label: 'Full Name *',
//                                     controller: _fullNameController,
//                                     isRequired: true,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Email *',
//                                     controller: _emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     isRequired: true,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Phone *',
//                                     controller: _phoneController,
//                                     keyboardType: TextInputType.phone,
//                                     isRequired: true,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Company',
//                                     controller: _companyController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Designation',
//                                     controller: _designationController,
//                                   ),
//                                   CustomDropdownField(
//                                     label: 'Gender',
//                                     value: _selectedGender,
//                                     items: const ['Male', 'Female', 'Other'],
//                                     onChanged: (value) =>
//                                         setState(() => _selectedGender = value),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Personal Details
//                               const SectionTitle(
//                                 title: 'Personal Details',
//                                 icon: Icons.person_pin,
//                               ),
//                               const SizedBox(height: 16),
//                               ResponsiveGrid(
//                                 columns: 3,
//                                 children: [
//                                   CustomTextFormField(
//                                     label: 'Alternate Phone',
//                                     controller: _alternatePhoneController,
//                                     keyboardType: TextInputType.phone,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'WhatsApp Number',
//                                     controller: _whatsappController,
//                                     keyboardType: TextInputType.phone,
//                                   ),
//                                   CustomDateField(
//                                     label: 'Date of Birth',
//                                     controller: _dobController,
//                                     isRequired: false,
//                                   ),
//                                   CustomDropdownField(
//                                     label: 'Marital Status',
//                                     value: _selectedMaritalStatus,
//                                     items: const [
//                                       'Single',
//                                       'Married',
//                                       'Divorced',
//                                       'Widowed'
//                                     ],
//                                     onChanged: (value) => setState(
//                                         () => _selectedMaritalStatus = value),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Professional Details
//                               const SectionTitle(
//                                 title: 'Professional Details',
//                                 icon: Icons.work_outline,
//                               ),
//                               const SizedBox(height: 16),
//                               ResponsiveGrid(
//                                 columns: 2,
//                                 children: [
//                                   CustomDropdownField(
//                                     label: 'Profession',
//                                     value: _selectedProfession,
//                                     items: configController
//                                             .configData.value.jobCategory
//                                             ?.map((e) => e.name ?? "")
//                                             .toList() ??
//                                         [],
//                                     onChanged: (value) => setState(
//                                         () => _selectedProfession = value),
//                                   ),
//                                   CustomCheckDropdown(
//                                     label: 'Countries Interested',
//                                     items: configController
//                                             .configData.value.country
//                                             ?.map((e) => e.name ?? "")
//                                             .toList() ??
//                                         [],
//                                     values: _selectedCountries,
//                                     onChanged: (values) => setState(() =>
//                                         _selectedCountries =
//                                             values.cast<String>()),
//                                   ),
//                                   CustomCheckDropdown(
//                                     label: 'Specialized In',
//                                     items: configController
//                                             .configData.value.specialized
//                                             ?.map((e) => e.name ?? "")
//                                             .toList() ??
//                                         [],
//                                     values: _selectedSpecializations,
//                                     onChanged: (values) => setState(() =>
//                                         _selectedSpecializations =
//                                             values.cast<String>()),
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Skills',
//                                     controller: _skillsController,
//                                   ),
//                                   CustomDropdownField(
//                                     label: 'Education',
//                                     value: _qualificationController.text.isEmpty
//                                         ? null
//                                         : _qualificationController.text,
//                                     items: configController
//                                             .configData.value.programType
//                                             ?.map((e) => e.name ?? "")
//                                             .toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _qualificationController.text =
//                                             value ?? '';
//                                       });
//                                     },
//                                   ),
//                                   CustomDropdownField(
//                                     label: 'Education Program',
//                                     value:
//                                         _educationProgramController.text.isEmpty
//                                             ? null
//                                             : _educationProgramController.text,
//                                     items: configController
//                                             .configData.value.program
//                                             ?.map((e) => e.name ?? "")
//                                             .toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _educationProgramController.text =
//                                             value ?? '';
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Lead Details
//                               const SectionTitle(
//                                 title: 'Lead Details',
//                                 icon: Icons.description,
//                               ),
//                               const SizedBox(height: 16),
//                               ResponsiveGrid(
//                                 columns: 2,
//                                 children: [
//                                   CustomTextFormField(
//                                     label: 'Product/Service Interest',
//                                     controller: _productInterestController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Service Required',
//                                     controller: _serviceRequiredController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Budget',
//                                     controller: _budgetController,
//                                     keyboardType: TextInputType.number,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Preferred Location',
//                                     controller: _preferredLocationController,
//                                   ),
//                                   CustomDateField(
//                                     label: 'Preferred Date',
//                                     controller: TextEditingController(
//                                       text: _preferredDate != null
//                                           ? DateFormat('dd/MM/yyyy')
//                                               .format(_preferredDate!)
//                                           : '',
//                                     ),
//                                     onChanged: (value) {
//                                       if (value.isNotEmpty) {
//                                         setState(() {
//                                           _preferredDate =
//                                               DateFormat('dd/MM/yyyy')
//                                                   .parse(value);
//                                         });
//                                       }
//                                     },
//                                   ),
//                                   CustomOfficerDropDown(
//                                     label: 'Assigned To',
//                                     value: _selectedAgent,
//                                     items: officersController.officersList
//                                         .map((e) => e.name ?? "")
//                                         .toList(),
//                                     onChanged: (value) =>
//                                         setState(() => _selectedAgent = value),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Status & Priority
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: CustomDropdownField(
//                                       label: 'Status *',
//                                       value: _selectedStatus,
//                                       items: BusinessTypeConfig.leadStatuses,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _selectedStatus = value;
//                                         });
//                                       },
//                                       isRequired: true,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           'Priority *',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         DropdownButtonFormField<int>(
//                                           value: _selectedPriority,
//                                           items:
//                                               [1, 2, 3, 4, 5].map((priority) {
//                                             return DropdownMenuItem<int>(
//                                               value: priority,
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.flag,
//                                                     color: _getPriorityColor(
//                                                         priority),
//                                                     size: 16,
//                                                   ),
//                                                   const SizedBox(width: 8),
//                                                   Text('Priority $priority'),
//                                                 ],
//                                               ),
//                                             );
//                                           }).toList(),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _selectedPriority = value!;
//                                             });
//                                           },
//                                           decoration: const InputDecoration(
//                                             border: OutlineInputBorder(),
//                                             contentPadding:
//                                                 EdgeInsets.symmetric(
//                                                     horizontal: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Address Information
//                               const SectionTitle(
//                                 title: 'Address Information',
//                                 icon: Icons.location_on,
//                               ),
//                               const SizedBox(height: 16),
//                               CustomTextFormField(
//                                 label: 'Address',
//                                 controller: _addressController,
//                                 maxLines: 2,
//                               ),
//                               const SizedBox(height: 16),
//                               ResponsiveGrid(
//                                 columns: 2,
//                                 children: [
//                                   CustomTextFormField(
//                                     label: 'City',
//                                     controller: _cityController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'State',
//                                     controller: _stateController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Country',
//                                     controller: _countryController,
//                                   ),
//                                   CustomTextFormField(
//                                     label: 'Pincode',
//                                     controller: _pincodeController,
//                                     keyboardType: TextInputType.number,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // Custom Fields based on Business Type
//                               _buildCustomFields(),

//                               // Communication Preferences
//                               const SizedBox(height: 24),
//                               _buildCommunicationPreferences(),

//                               // Notes
//                               const SizedBox(height: 24),
//                               const SectionTitle(
//                                 title: 'Additional Notes',
//                                 icon: Icons.notes,
//                               ),
//                               const SizedBox(height: 16),
//                               CustomTextFormField(
//                                 label: 'Notes',
//                                 controller: _notesController,
//                                 maxLines: 4,
//                               ),

//                               // Action Buttons
//                               const SizedBox(height: 32),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: CustomActionButton(
//                                       text: 'Cancel',
//                                       icon: Icons.close,
//                                       textColor: Colors.grey,
//                                       onPressed: () => Get.back(),
//                                       borderColor: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: CustomActionButton(
//                                       text: widget.isEditMode
//                                           ? 'Update Lead'
//                                           : 'Create Lead',
//                                       icon: Icons.save,
//                                       isFilled: true,
//                                       gradient: const LinearGradient(
//                                         colors: [Colors.blue, Colors.lightBlue],
//                                       ),
//                                       onPressed: _saveLead,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Side Panel - Communication Preferences
//                       Container(
//                         width: 300,
//                         margin: const EdgeInsets.all(24),
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.blue.shade50,
//                               Colors.lightBlue.shade50,
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.blue.shade100),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Icon(
//                                 Icons.notifications_active,
//                                 size: 40,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             const Text(
//                               'Communication Preferences',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             const Text(
//                               'Choose how you\'d like to communicate with this lead',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             _buildCommunicationSidePanel(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCommunicationSidePanel() {
//     return Column(
//       children: [
//         _buildPreferenceTile(
//           'Phone Calls',
//           'Call for updates and follow-ups',
//           Icons.phone,
//           _phoneCommunication,
//           (value) => setState(() => _phoneCommunication = value),
//         ),
//         const SizedBox(height: 12),
//         _buildPreferenceTile(
//           'Email Updates',
//           'Send email notifications',
//           Icons.email,
//           _emailCommunication,
//           (value) => setState(() => _emailCommunication = value),
//         ),
//         const SizedBox(height: 12),
//         _buildPreferenceTile(
//           'WhatsApp Messages',
//           'Chat via WhatsApp',
//           Icons.chat,
//           _whatsappCommunication,
//           (value) => setState(() => _whatsappCommunication = value),
//         ),
//         const SizedBox(height: 12),
//         _buildPreferenceTile(
//           'On-Call Support',
//           'Immediate call support',
//           Icons.call,
//           _onCallCommunication,
//           (value) => setState(() => _onCallCommunication = value),
//         ),
//       ],
//     );
//   }

//   Widget _buildPreferenceTile(String title, String subtitle, IconData icon,
//       bool value, Function(bool) onChanged) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: value
//                   ? Colors.blue.withOpacity(0.1)
//                   : Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               color: value ? Colors.blue : Colors.grey,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: value ? Colors.blue : Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: Colors.blue,
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getPriorityColor(int priority) {
//     switch (priority) {
//       case 1:
//         return Colors.green;
//       case 2:
//         return Colors.blue;
//       case 3:
//         return Colors.orange;
//       case 4:
//         return Colors.red;
//       case 5:
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }

//   // Add missing controller
//   final _leadDateController = TextEditingController();
// }
