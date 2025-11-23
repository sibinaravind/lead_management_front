// lead_model.dart

// add_edit_lead.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/lead/lead_controller.dart';
import '../../widgets/widgets.dart';

// model/lead_model.dart
class Lead {
  final String? id;
  final String businessType;
  final String leadSource;
  final String status;
  final String fullName;
  final String email;
  String? countryCode;
  final String phone;
  final String? company;
  final String? designation;
  final String? productInterest;
  final String? serviceRequired;
  final double? budget;
  final String? preferredLocation;
  final DateTime? preferredDate;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;
  final Map<String, dynamic>? customFields;
  final List<dynamic> timeline;
  final String? assignedTo;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? createdBy;
  final String? notes;

  // Communication Preferences
  final bool phoneCommunication;
  final bool emailCommunication;
  final bool whatsappCommunication;
  final bool onCallCommunication;

  // Additional Personal Fields
  final String? gender;
  final String? maritalStatus;
  final String? alternatePhone;
  final String? whatsappNumber;
  final String? dateOfBirth;

  // Financial Information
  final double? annualIncome;
  final String? incomeSource;
  final String?
      employmentStatus; // SALARIED, SELF_EMPLOYED, BUSINESS, STUDENT, UNEMPLOYED
  final String? companyName;
  final int? workExperience; // in years
  final String? taxIdentificationNumber;
  final String? creditScore; // EXCELLENT, GOOD, FAIR, POOR
  final bool? hasExistingLoans;
  final double? existingLoanAmount;

  // Education Background
  final String? highestQualification;
  final String? institutionName;
  final int? yearOfPassing;
  final double? percentageOrCGPA;
  final String? fieldOfStudy;

  // Career Details
  final String? currentIndustry;
  final String? currentJobRole;
  final double? currentSalary;
  final String? desiredJobRole;
  final double? expectedSalary;
  final List<String>? technicalSkills;
  final List<String>? softSkills;
  final String? resumeUrl;

  // Travel Specific
  final String? passportNumber;
  final DateTime? passportExpiry;
  final List<String>? visitedCountries;
  final String? visaTypeRequired;
  final String? travelPurpose; // TOURISM, BUSINESS, EDUCATION, MEDICAL
  final int? travelGroupSize;
  final bool? requiresTravelInsurance;
  final bool? requiresHotelBooking;
  final bool? requiresFlightBooking;

  // Migration Specific
  final String? currentVisaStatus;
  final String? targetVisaType;
  final String? languageTestTaken; // IELTS, TOEFL, PTE
  final double? languageTestScore;
  final bool? hasRelativesAbroad;
  final String? relativeCountry;
  final String? relativeRelation;
  final bool? requiresJobAssistance;
  final String? preferredSettlementCity;

  // Real Estate Specific
  final String? propertyType; // RESIDENTIAL, COMMERCIAL, PLOT, INDUSTRIAL
  final String? propertyUse; // SELF_USE, INVESTMENT, RENTAL
  final bool? requiresHomeLoan;
  final double? loanAmountRequired;
  final String? possessionTimeline; // IMMEDIATE, 3_MONTHS, 6_MONTHS, 1_YEAR
  final String?
      furnishingPreference; // FULLY_FURNISHED, SEMI_FURNISHED, UNFURNISHED
  final bool? requiresLegalAssistance;

  // Vehicle Specific
  final String? vehicleType; // NEW, USED
  final String? brandPreference;
  final String? modelPreference;
  final String? fuelType; // PETROL, DIESEL, ELECTRIC, CNG
  final String? transmission; // MANUAL, AUTOMATIC
  final bool? requiresFinancing;
  final double? downPaymentAvailable;
  final String? insuranceType; // COMPREHENSIVE, THIRD_PARTY

  // Language & Preferences
  final List<String>? spokenLanguages;
  final String? preferredLanguage;
  final String? timezone;

  // Multi-select fields
  final List<String>? specializedIn;
  final List<String>? countriesInterested;
  final String? profession;

  Lead({
    this.id,
    required this.businessType,
    required this.leadSource,
    required this.status,
    required this.fullName,
    required this.email,
    required this.phone,
    this.countryCode,
    this.company,
    this.designation,
    this.productInterest,
    this.serviceRequired,
    this.budget,
    this.preferredLocation,
    this.preferredDate,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.customFields,
    this.timeline = const [],
    this.assignedTo,
    this.priority = 3,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.notes,

    // Communication Preferences
    this.phoneCommunication = true,
    this.emailCommunication = false,
    this.whatsappCommunication = false,
    this.onCallCommunication = false,

    // Personal
    this.gender,
    this.maritalStatus,
    this.alternatePhone,
    this.whatsappNumber,
    this.dateOfBirth,

    // Financial
    this.annualIncome,
    this.incomeSource,
    this.employmentStatus,
    this.companyName,
    this.workExperience,
    this.taxIdentificationNumber,
    this.creditScore,
    this.hasExistingLoans,
    this.existingLoanAmount,

    // Education
    this.highestQualification,
    this.institutionName,
    this.yearOfPassing,
    this.percentageOrCGPA,
    this.fieldOfStudy,

    // Career
    this.currentIndustry,
    this.currentJobRole,
    this.currentSalary,
    this.desiredJobRole,
    this.expectedSalary,
    this.technicalSkills,
    this.softSkills,
    this.resumeUrl,

    // Travel
    this.passportNumber,
    this.passportExpiry,
    this.visitedCountries,
    this.visaTypeRequired,
    this.travelPurpose,
    this.travelGroupSize,
    this.requiresTravelInsurance,
    this.requiresHotelBooking,
    this.requiresFlightBooking,
    // Migration
    this.currentVisaStatus,
    this.targetVisaType,
    this.languageTestTaken,
    this.languageTestScore,
    this.hasRelativesAbroad,
    this.relativeCountry,
    this.relativeRelation,
    this.requiresJobAssistance,
    this.preferredSettlementCity,

    // Real Estate
    this.propertyType,
    this.propertyUse,
    this.requiresHomeLoan,
    this.loanAmountRequired,
    this.possessionTimeline,
    this.furnishingPreference,
    this.requiresLegalAssistance,

    // Vehicle
    this.vehicleType,
    this.brandPreference,
    this.modelPreference,
    this.fuelType,
    this.transmission,
    this.requiresFinancing,
    this.downPaymentAvailable,
    this.insuranceType,

    // Language
    this.spokenLanguages,
    this.preferredLanguage,
    this.timezone,

    // Multi-select
    this.specializedIn,
    this.countriesInterested,
    this.profession,
  });

  // Add toJson and fromJson methods as needed
}

class LeadTimeline {
  String action; // CALL, EMAIL, MEETING, PROPOSAL_SENT, FOLLOW_UP, NOTE
  String description;
  DateTime timestamp;
  String performedBy;
  String? nextFollowUp;

  LeadTimeline({
    required this.action,
    required this.description,
    required this.timestamp,
    required this.performedBy,
    this.nextFollowUp,
  });

  factory LeadTimeline.fromJson(Map<String, dynamic> json) {
    return LeadTimeline(
      action: json['action'] ?? '',
      description: json['description'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      performedBy: json['performedBy'] ?? '',
      nextFollowUp: json['nextFollowUp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'performedBy': performedBy,
      if (nextFollowUp != null) 'nextFollowUp': nextFollowUp,
    };
  }
}

// Business Type Specific Configurations
class BusinessTypeConfig {
  static const List<String> businessTypes = [
    'TRAVEL',
    'ABROAD',
    'CAR_SHOP',
    'BIKE_SHOP',
    'EDUCATIONAL',
    'OTHER'
  ];

  static const List<String> leadSources = [
    'WEBSITE',
    'REFERRAL',
    'SOCIAL_MEDIA',
    'WALK_IN',
    'CALL',
    'EMAIL',
    'OTHER'
  ];

  static const List<String> leadStatuses = [
    'NEW',
    'CONTACTED',
    'QUALIFIED',
    'PROPOSAL_SENT',
    'NEGOTIATION',
    'WON',
    'LOST'
  ];

  static const List<String> timelineActions = [
    'CALL',
    'EMAIL',
    'MEETING',
    'PROPOSAL_SENT',
    'FOLLOW_UP',
    'NOTE',
    'DEMO',
    'QUOTATION_SENT'
  ];

  // Custom fields for each business type
  static Map<String, List<String>> getCustomFields(String businessType) {
    switch (businessType) {
      case 'TRAVEL':
        return {
          'Destinations': [],
          'Travel Dates': [],
          'Number of Travelers': [],
          'Travel Type': ['Leisure', 'Business', 'Family', 'Honeymoon'],
          'Accommodation Preference': ['Budget', 'Standard', 'Luxury'],
        };
      case 'ABROAD':
        return {
          'Destination Country': [],
          'Purpose': ['Study', 'Work', 'Immigration', 'Tourism'],
          'Duration': [],
          'Visa Type': [],
          'Documents Required': [],
        };
      case 'CAR_SHOP':
        return {
          'Car Model': [],
          'Car Type': ['New', 'Used'],
          'Fuel Type': ['Petrol', 'Diesel', 'Electric', 'Hybrid'],
          'Transmission': ['Manual', 'Automatic'],
          'Test Drive Required': ['Yes', 'No'],
        };
      case 'BIKE_SHOP':
        return {
          'Bike Model': [],
          'Bike Type': ['Sports', 'Cruiser', 'Commuter', 'Adventure'],
          'Engine Capacity': [],
          'Test Drive Required': ['Yes', 'No'],
        };
      case 'EDUCATIONAL':
        return {
          'Course Interest': [],
          'Education Level': [
            'School',
            'Undergraduate',
            'Postgraduate',
            'Diploma'
          ],
          'Preferred Mode': ['Online', 'Offline', 'Hybrid'],
          'Duration': [],
          'Batch Preference': [],
        };
      default:
        return {
          'Requirements': [],
          'Timeline': [],
          'Specific Needs': [],
        };
    }
  }
}

class AddEditLead extends StatefulWidget {
  final Lead? lead;
  final bool isEditMode;

  const AddEditLead({super.key, this.lead, required this.isEditMode});

  @override
  State<AddEditLead> createState() => _AddEditLeadState();
}

class _AddEditLeadState extends State<AddEditLead> {
  final _formKey = GlobalKey<FormState>();
  final leadController = Get.find<LeadController>();

  // Basic Information
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _designationController = TextEditingController();

  // Lead Details
  final _productInterestController = TextEditingController();
  final _serviceRequiredController = TextEditingController();
  final _budgetController = TextEditingController();
  final _preferredLocationController = TextEditingController();
  final _notesController = TextEditingController();

  // Address
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();

  // Dropdown Values
  String? _selectedBusinessType;
  String? _selectedLeadSource;
  String? _selectedStatus;
  int _selectedPriority = 3;
  DateTime? _preferredDate;

  // Custom Fields
  Map<String, dynamic> _customFields = {};

  @override
  void initState() {
    _initializeForm();
    super.initState();
  }

  void _initializeForm() {
    if (widget.isEditMode && widget.lead != null) {
      final lead = widget.lead!;

      // Basic Information
      _fullNameController.text = lead.fullName;
      _emailController.text = lead.email;
      _phoneController.text = lead.phone;
      _companyController.text = lead.company ?? '';
      _designationController.text = lead.designation ?? '';

      // Lead Details
      _productInterestController.text = lead.productInterest ?? '';
      _serviceRequiredController.text = lead.serviceRequired ?? '';
      _budgetController.text = lead.budget?.toString() ?? '';
      _preferredLocationController.text = lead.preferredLocation ?? '';
      _notesController.text = lead.notes ?? '';

      // Address
      _addressController.text = lead.address ?? '';
      _cityController.text = lead.city ?? '';
      _stateController.text = lead.state ?? '';
      _countryController.text = lead.country ?? '';
      _pincodeController.text = lead.pincode ?? '';

      // Dropdowns
      _selectedBusinessType = lead.businessType;
      _selectedLeadSource = lead.leadSource;
      _selectedStatus = lead.status;
      _selectedPriority = lead.priority;
      _preferredDate = lead.preferredDate;

      // Custom Fields
      _customFields = lead.customFields ?? {};
    } else {
      _selectedBusinessType = 'TRAVEL';
      _selectedLeadSource = 'WEBSITE';
      _selectedStatus = 'NEW';
    }
  }

  void _saveLead() {
    if (_formKey.currentState!.validate()) {
      final lead = Lead(
        id: widget.lead?.id,
        businessType: _selectedBusinessType!,
        leadSource: _selectedLeadSource!,
        status: _selectedStatus!,
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        company: _companyController.text.trim().isEmpty
            ? null
            : _companyController.text.trim(),
        designation: _designationController.text.trim().isEmpty
            ? null
            : _designationController.text.trim(),
        productInterest: _productInterestController.text.trim().isEmpty
            ? null
            : _productInterestController.text.trim(),
        serviceRequired: _serviceRequiredController.text.trim().isEmpty
            ? null
            : _serviceRequiredController.text.trim(),
        budget: _budgetController.text.trim().isEmpty
            ? null
            : double.tryParse(_budgetController.text.trim()),
        preferredLocation: _preferredLocationController.text.trim().isEmpty
            ? null
            : _preferredLocationController.text.trim(),
        preferredDate: _preferredDate,
        address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
        city: _cityController.text.trim().isEmpty
            ? null
            : _cityController.text.trim(),
        state: _stateController.text.trim().isEmpty
            ? null
            : _stateController.text.trim(),
        country: _countryController.text.trim().isEmpty
            ? null
            : _countryController.text.trim(),
        pincode: _pincodeController.text.trim().isEmpty
            ? null
            : _pincodeController.text.trim(),
        customFields: _customFields.isEmpty ? null : _customFields,
        timeline: widget.lead?.timeline ?? [],
        assignedTo: widget.lead?.assignedTo,
        priority: _selectedPriority,
        createdAt: widget.lead?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: widget.lead?.createdBy,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (widget.isEditMode) {
        // leadController.updateLead(lead);
      } else {
        // leadController.addLead(lead);
      }
      Get.back();
    }
  }

  Widget _buildCustomFields() {
    if (_selectedBusinessType == null) return const SizedBox();

    final customFieldsConfig =
        BusinessTypeConfig.getCustomFields(_selectedBusinessType!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Additional Information',
          icon: Icons.add_circle_outline,
        ),
        const SizedBox(height: 16),
        ...customFieldsConfig.entries.map((field) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomDropdownField(
              label: field.key,
              value: _customFields[field.key],
              items: field.value.isNotEmpty ? field.value : [''],
              onChanged: (value) {
                setState(() {
                  _customFields[field.key] = value;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person_add_alt_1,
                          color: Colors.blue, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        widget.isEditMode ? 'Edit Lead' : 'Add New Lead',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Business Type & Lead Source
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownField(
                                label: 'Business Type *',
                                value: _selectedBusinessType,
                                items: BusinessTypeConfig.businessTypes,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBusinessType = value;
                                    _customFields = {}; // Reset custom fields
                                  });
                                },
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDropdownField(
                                label: 'Lead Source *',
                                value: _selectedLeadSource,
                                items: BusinessTypeConfig.leadSources,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLeadSource = value;
                                  });
                                },
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Basic Information
                        const SectionTitle(
                          title: 'Basic Information',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            CustomTextFormField(
                              label: 'Full Name *',
                              controller: _fullNameController,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Email *',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Phone *',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Company',
                              controller: _companyController,
                            ),
                            CustomTextFormField(
                              label: 'Designation',
                              controller: _designationController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Lead Details
                        const SectionTitle(
                          title: 'Lead Details',
                          icon: Icons.description,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            CustomTextFormField(
                              label: 'Product/Service Interest',
                              controller: _productInterestController,
                            ),
                            CustomTextFormField(
                              label: 'Service Required',
                              controller: _serviceRequiredController,
                            ),
                            CustomTextFormField(
                              label: 'Budget',
                              controller: _budgetController,
                              keyboardType: TextInputType.number,
                            ),
                            CustomTextFormField(
                              label: 'Preferred Location',
                              controller: _preferredLocationController,
                            ),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() {
                                    _preferredDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _preferredDate != null
                                          ? '${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}'
                                          : 'Preferred Date (Optional)',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Status & Priority
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownField(
                                label: 'Status *',
                                value: _selectedStatus,
                                items: BusinessTypeConfig.leadStatuses,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStatus = value;
                                  });
                                },
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Priority *',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<int>(
                                    value: _selectedPriority,
                                    items: [1, 2, 3, 4, 5].map((priority) {
                                      return DropdownMenuItem<int>(
                                        value: priority,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.flag,
                                              color:
                                                  _getPriorityColor(priority),
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text('Priority $priority'),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPriority = value!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Address Information
                        const SectionTitle(
                          title: 'Address Information',
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          label: 'Address',
                          controller: _addressController,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
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
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Custom Fields based on Business Type
                        _buildCustomFields(),

                        // Notes
                        const SizedBox(height: 20),
                        const SectionTitle(
                          title: 'Additional Notes',
                          icon: Icons.notes,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          label: 'Notes',
                          controller: _notesController,
                          maxLines: 4,
                        ),

                        // Action Buttons
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: CustomActionButton(
                                text: 'Cancel',
                                icon: Icons.close,
                                textColor: Colors.grey,
                                onPressed: () => Get.back(),
                                borderColor: Colors.grey.shade300,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomActionButton(
                                text: widget.isEditMode
                                    ? 'Update Lead'
                                    : 'Create Lead',
                                icon: Icons.save,
                                isFilled: true,
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.lightBlue],
                                ),
                                onPressed: _saveLead,
                              ),
                            ),
                          ],
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
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class LeadsListScreen extends StatelessWidget {
  final LeadController leadController = Get.find<LeadController>();

  LeadsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.dialog(const AddEditLead(isEditMode: false));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          _buildFilters(),

          // Statistics
          // _buildStatistics(),

          // Leads List
          Expanded(
            child: Obx(() {
              if (leadController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final leads = leadController.filteredLeads;

              if (leads.isEmpty) {
                return const Center(
                  child: Text('No leads found'),
                );
              }

              return ListView.builder(
                itemCount: leads.length,
                itemBuilder: (context, index) {
                  final lead = leads[index];
                  return _buildLeadCard(lead);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(const AddEditLead(isEditMode: false));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: leadController.selectedBusinessType.value,
                    items: ['ALL', ...BusinessTypeConfig.businessTypes]
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      leadController.selectedBusinessType.value = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Business Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: leadController.filterStatus.value,
                    items: ['ALL', ...BusinessTypeConfig.leadStatuses]
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) {
                      leadController.filterStatus.value = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: leadController.filterPriority.value,
                    items: ['ALL', '1', '2', '3', '4', '5']
                        .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Text(priority == 'ALL'
                                  ? 'All Priorities'
                                  : 'Priority $priority'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      leadController.filterPriority.value = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStatistics() {
  //   return Obx(() {
  //     final stats = leadController.leadStatistics;
  //     return SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         children: stats.entries.map((entry) {
  //           return Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 8),
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: _getStatusColor(entry.key),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   entry.value.toString(),
  //                   style: const TextStyle(
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 Text(
  //                   entry.key,
  //                   style: const TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   });
  // }

  Widget _buildLeadCard(Lead lead) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(lead.status),
          child: Text(
            lead.fullName[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(lead.fullName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lead.email),
            Text(lead.phone),
            Text('${lead.businessType} • ${lead.status}'),
            if (lead.productInterest != null)
              Text('Interest: ${lead.productInterest!}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.flag,
              color: _getPriorityColor(lead.priority),
            ),
            const SizedBox(width: 8),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  Get.dialog(AddEditLead(lead: lead, isEditMode: true));
                } else if (value == 'delete') {
                  // leadController.deleteLead(lead.id!);
                }
              },
            ),
          ],
        ),
        onTap: () {
          // Navigate to lead details screen
          _showLeadDetails(lead);
        },
      ),
    );
  }

  void _showLeadDetails(Lead lead) {
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    lead.fullName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Email', lead.email),
              _buildDetailRow('Phone', lead.phone),
              _buildDetailRow('Business Type', lead.businessType),
              _buildDetailRow('Status', lead.status),
              _buildDetailRow('Lead Source', lead.leadSource),
              if (lead.company != null)
                _buildDetailRow('Company', lead.company!),
              if (lead.productInterest != null)
                _buildDetailRow('Product Interest', lead.productInterest!),
              if (lead.budget != null)
                _buildDetailRow('Budget', '\$${lead.budget}'),
              if (lead.notes != null) _buildDetailRow('Notes', lead.notes!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'NEW':
        return Colors.blue;
      case 'CONTACTED':
        return Colors.orange;
      case 'QUALIFIED':
        return Colors.green;
      case 'PROPOSAL_SENT':
        return Colors.purple;
      case 'NEGOTIATION':
        return Colors.amber;
      case 'WON':
        return Colors.green;
      case 'LOST':
        return Colors.red;
      case 'TOTAL':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/lead/lead_controller.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/view/widgets/widgets.dart';
// import '../../../utils/style/colors/colors.dart';
// import '../../../utils/style/colors/dimension.dart';
// import '../../widgets/custom_toast.dart';
// import '../../widgets/customer_filter_chip.dart';
// import 'add_lead_screen.dart';
// import 'widgets/bulk_lead.dart';
// import 'widgets/lead_user_list_table.dart';

// class LeadDataDisplay extends StatefulWidget {
//   const LeadDataDisplay({super.key});
//   @override
//   State<LeadDataDisplay> createState() => _LeadDataDisplayState();
// }

// class _LeadDataDisplayState extends State<LeadDataDisplay> {
//   final leadController = Get.find<LeadController>();
//   final officersController = Get.find<OfficersController>();
//   final configController = Get.find<ConfigController>();
//   var filterOptions = <String, List<String>>{};
//   var selectedFilters = <String, dynamic>{}.obs;
//   final isFilterActive = false.obs;
//   final showFilters = false.obs;

//   int page = 1;
//   int limit = 10;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await fetchConfig();

//       fetchData();
//     });
//   }

//   Future<void> fetchConfig() async {
//     await configController.loadConfigData();
//     leadController.getLeadCount();
//     await Get.find<OfficersController>().fetchOfficersList();
//     filterOptions = {
//       'Status': configController.configData.value.clientStatus
//               ?.map((item) => "${item.name}")
//               .toList() ??
//           [],
//       'Country': configController.configData.value.country
//               ?.map((item) => "${item.name}")
//               .toList() ??
//           [],
//       'Officers': officersController.officersList.value
//               .map((item) => "${item.name}")
//               .toList() ??
//           [],
//     };
//     setState(() {});
//   }

//   Map<String, dynamic> buildQueryParams() {
//     final params = {
//       "page": page.toString(),
//       "limit": limit.toString(),
//     };

//     if (leadController.selectedFilter.isNotEmpty) {
//       params["filterCategory"] = leadController.selectedFilter.value;
//     }
//     if (searchController.text.trim().isNotEmpty) {
//       params["searchString"] = searchController.text.trim();
//     }

//     selectedFilters.forEach((key, value) {
//       if (value != null && value.toString().isNotEmpty) {
//         switch (key) {
//           case "Status":
//             params["status"] = value;
//             break;
//           case "Officers":
//             params["employee"] = value;
//             break;
//           case "Country":
//             params["country"] = value;
//             break;
//           case "startDate":
//             params["startDate"] = value;
//             break;
//           case "endDate":
//             params["endDate"] = value;
//             break;
//         }
//       }
//     });

//     return params;
//   }

//   void fetchData() {
//     final params = buildQueryParams();
//     if (leadController.selectedFilter.value == 'HISTORY') {
//       leadController.fetchMatchingHistoricalClients(filterSelected: params);
//       return;
//     }
//     leadController.fetchMatchingClients(filterSelected: params);
//   }

//   void applyFilters() {
//     isFilterActive.value = true;
//     page = 1;
//     fetchData();
//     showFilters.value = false;
//   }

//   void cleardata() {
//     leadController.selectedFilter.value = '';
//     isFilterActive.value = false;
//     selectedFilters.clear();
//     searchController.clear();
//     page = 1;
//   }

//   void resetFilters() {
//     leadController.selectedFilter.value = '';
//     isFilterActive.value = false;
//     selectedFilters.clear();
//     searchController.clear();
//     page = 1;
//     fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   decoration: BoxDecoration(
//                     gradient: AppColors.blackGradient,
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.primaryColor.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.3),
//                             width: 1,
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.analytics_outlined,
//                           color: AppColors.textWhiteColour,
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: 24),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: "Lead Management Dashboard",
//                               color: AppColors.textWhiteColour,
//                               fontSize: Dimension().isMobile(context) ? 13 : 19,
//                               maxLines: 2,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: AppColors.orangeGradient,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.orangeSecondaryColor
//                                   .withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20),
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => const BulkLeadScreen(),
//                               );
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add_circle_outline,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   SizedBox(width: 12),
//                                   CustomText(
//                                     text: 'Bulk Lead',
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: AppColors.buttonGraidentColour,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color:
//                                   AppColors.violetPrimaryColor.withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20),
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => const AddLeadScreen(),
//                               );
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add_circle_outline,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                   SizedBox(width: 12),
//                                   CustomText(
//                                     text: 'New Lead',
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: double.maxFinite,
//                   padding: const EdgeInsets.only(
//                       top: 6, bottom: 8, left: 15, right: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Obx(
//                             () => Row(
//                               children: [
//                                 CustomFilterChip(
//                                   icon: Icons.all_inclusive,
//                                   text: 'All Leads',
//                                   count:
//                                       leadController.leadCount.value.total ?? 0,
//                                   color: AppColors.primaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value == '',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value = '';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.fiber_new,
//                                   text: 'New',
//                                   count: leadController
//                                           .leadCount.value.countModelNew ??
//                                       0,
//                                   color: AppColors.blueSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'NEW',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'NEW';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.today,
//                                   text: 'Today',
//                                   count:
//                                       leadController.leadCount.value.today ?? 0,
//                                   color: AppColors.greenSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'TODAY',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'TODAY';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.today,
//                                   text: 'Tommorrow',
//                                   count:
//                                       leadController.leadCount.value.tomorrow ??
//                                           0,
//                                   color: AppColors.orangeSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'TOMORROW',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'TOMORROW';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.schedule,
//                                   text: 'Pending',
//                                   count:
//                                       leadController.leadCount.value.pending ??
//                                           0,
//                                   color: AppColors.redSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'PENDING',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'PENDING';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.history,
//                                   text: 'Upcoming',
//                                   count:
//                                       leadController.leadCount.value.upcoming ??
//                                           0,
//                                   color: AppColors.skyBlueSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'UPCOMING',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'UPCOMING';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 // _buildFilterChip(
//                                 //   icon: Icons.history,
//                                 //   text: 'Converted',
//                                 //   count: 156,
//                                 //   color: AppColors.viloletSecondaryColor,
//                                 //   isSelected: selectedFilter == 'converted',
//                                 //   onTap: () {
//                                 //     setState(() {
//                                 //       selectedFilter = 'converted';
//                                 //     });
//                                 //   },
//                                 // ),
//                                 CustomFilterChip(
//                                   icon: Icons.trending_up,
//                                   text: 'UnAssigned',
//                                   count: leadController
//                                           .leadCount.value.unassigned ??
//                                       0,
//                                   color: AppColors.textGrayColour,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'UNASSIGNED',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'UNASSIGNED';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                                 CustomFilterChip(
//                                   icon: Icons.history,
//                                   text: 'History',
//                                   count:
//                                       leadController.leadCount.value.history ??
//                                           0,
//                                   color: AppColors.skyBlueSecondaryColor,
//                                   isSelected:
//                                       leadController.selectedFilter.value ==
//                                           'HISTORY',
//                                   onTap: () {
//                                     cleardata();
//                                     setState(() {
//                                       leadController.selectedFilter.value =
//                                           'HISTORY';
//                                     });
//                                     fetchData();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SearchBarWidget(
//                       controller: searchController,
//                       onSearch: () {
//                         page = 1;
//                         fetchData();
//                       },
//                     ),
//                     Obx(() => FilterToggleButtonsWidget(
//                           isFilterActive: isFilterActive.value,
//                           onReset: () {
//                             if (isFilterActive.value ||
//                                 searchController.text.isNotEmpty) {
//                               resetFilters();
//                             }
//                           },
//                           onToggle: () =>
//                               showFilters.value = !showFilters.value,
//                         )),
//                   ],
//                 ),
//                 Obx(() => FilterPanelWidget(
//                       showFilters: showFilters.value,
//                       filterOptions: filterOptions,
//                       selectedFilters: selectedFilters,
//                       onFilterChange: (newFilters) {
//                         selectedFilters.value = newFilters;
//                       },
//                       dateFilter: true,
//                       onApply: () {
//                         if (selectedFilters.isEmpty &&
//                             searchController.text.trim().isEmpty) {
//                           CustomToast.showToast(
//                             context: context,
//                             message:
//                                 "Please select at least one filter or enter a search term",
//                           );
//                           return;
//                         }
//                         applyFilters();
//                       },
//                       onClose: () => showFilters.value = false,
//                     )),

//                 // 📊 Leads table + Pagination
//                 Obx(() {
//                   final customerList =
//                       leadController.customerMatchingList.value.leads;

//                   if (customerList == null || customerList.isEmpty) {
//                     return const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: CustomText(text: "No matching leads found"),
//                     );
//                   }

//                   return Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 20,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(16)),
//                           child: LeadUserListTable(
//                             userlist: leadController
//                                     .customerMatchingList.value.leads ??
//                                 [],
//                           ),
//                         ),
//                         PaginationFooterWidget(
//                           currentPage: page,
//                           totalPages: leadController
//                                   .customerMatchingList.value.totalPages ??
//                               1,
//                           totalItems: leadController
//                                   .customerMatchingList.value.totalMatch ??
//                               0,
//                           onPageSelected: (newPage) {
//                             if (page != newPage) {
//                               setState(() {
//                                 page = newPage;
//                               });
//                               fetchData();
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
