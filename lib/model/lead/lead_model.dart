import 'academic_record_model.dart';
import 'document_record_model.dart';
import 'exam_record_model.dart';
import 'travel_record_model.dart';
import 'work_record_model.dart';

class LeadModel {
  // Core Lead Information
  String? sId;
  String? clientId;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? alternatePhone;
  String? whatsapp;
  String? gender;
  String? dob;
  String? maritalStatus;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;

  // Professional Information
  List<String>? jobInterests;
  List<String>? countryInterested;
  int? expectedSalary;
  String? qualification;
  int? experience;
  List<String>? skills;
  String? profession;
  List<String>? specializedIn;
  String?
      employmentStatus; // SALARIED, SELF_EMPLOYED, BUSINESS, STUDENT, UNEMPLOYED
  double? annualIncome;
  String? panCardNumber;
  String? gstNumber;
  bool? hasExistingLoans;
  double? loanAmountRequired;
  int? creditScore;

  // Lead Management
  String? leadSource;
  String? sourceCampaign;
  String?
      status; // NEW, CONTACTED, QUALIFIED, PROPOSAL_SENT, NEGOTIATION, WON, LOST
  String? serviceType;
  String? assignedTo;
  String? branch;
  String? recruiterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? nextFollowUpDate;
  DateTime? lastContactDate;
  String? note;

  // Communication Preferences
  bool? onCallCommunication;
  bool? onWhatsappCommunication;
  bool? onEmailCommunication;
  bool? phoneCommunication;
  bool? emailCommunication;
  bool? whatsappCommunication;

  // Officer Information
  String? officerStaffId;
  String? officerName;

  // Personal Details
  String? birthCountry;
  String? birthPlace;
  String? emailPassword;
  String? emergencyContact;
  String? passportNumber;
  String? passportExpiryDate;
  String? religion;
  int? jobGapMonths;
  DateTime? firstJobDate;

  // Records
  List<AcademicRecordModel>? academicRecords;
  List<ExamRecordModel>? examRecords;
  List<TravelRecordModel>? travelRecords;
  List<WorkRecordModel>? workRecords;
  List<DocumentRecordModel>? documents;

  // Additional Fields
  DateTime? nextSchedule;
  String? feedback;

  // Business Type Specific Fields

  // Common for multiple business types
  List<String>? productInterest;
  double? budget;
  String? preferredLocation;
  DateTime? preferredDate;
  List<TimelineEvent>? timeline;

  // Travel Specific
  String? travelPurpose; // BUSINESS, HONEYMOON, FAMILY, FRIENDS, SOLO
  int? numberOfTravelers;
  String? accommodationPreference; // BUDGET, STANDARD, LUXURY
  List<String>? visitedCountries;
  String? visaTypeRequired;
  int? travelDuration;
  bool? requiresTravelInsurance;
  bool? requiresHotelBooking;
  bool? requiresFlightBooking;

  // Education Specific
  String? preferredStudyMode; // ONLINE, OFFLINE, HYBRID
  String? batchPreference;
  String? highestQualification;
  int? yearOfPassing;
  String? fieldOfStudy;
  double? percentageOrCGPA;
  List<String>? coursesInterested;

  // Migration Specific
  String? targetVisaType;
  List<LanguageTestScore>? languageTestScores;
  bool? hasRelativesAbroad;
  String? relativeCountry;
  String? relativeRelation;
  bool? requiresJobAssistance;
  String? preferredSettlementCity;

  // Vehicle Specific
  String? vehicleType; // NEW, USED
  String? brandPreference;
  String? modelPreference;
  String? fuelType; // PETROL, DIESEL, ELECTRIC, CNG
  String? transmission; // MANUAL, AUTOMATIC
  double? downPaymentAvailable;
  String? insuranceType; // COMPREHENSIVE, THIRD_PARTY

  // Real Estate Specific
  String? propertyType; // RESIDENTIAL, COMMERCIAL, PLOT, INDUSTRIAL
  String? propertyUse; // SELF_USE, INVESTMENT, RENTAL
  bool? requiresHomeLoan;
  double? loanAmountRequiredRealEstate;
  String? possessionTimeline; // IMMEDIATE, 3_MONTHS, 6_MONTHS, 1_YEAR
  String? furnishingPreference; // FULLY_FURNISHED, SEMI_FURNISHED, UNFURNISHED
  bool? requiresLegalAssistance;
  String? totalPeoples;
  String? groupType; // COUPLE, MARRIED_COUPLE, BOYS, GIRLS

  LeadModel({
    // Core Lead Information
    this.sId,
    this.clientId,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.countryCode,
    this.alternatePhone,
    this.whatsapp,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,

    // Professional Information
    this.jobInterests,
    this.countryInterested,
    this.expectedSalary,
    this.qualification,
    this.experience,
    this.skills,
    this.profession,
    this.specializedIn,
    this.employmentStatus,
    this.annualIncome,
    this.panCardNumber,
    this.gstNumber,
    this.hasExistingLoans,
    this.loanAmountRequired,
    this.creditScore,

    // Lead Management
    this.leadSource,
    this.sourceCampaign,
    this.status,
    this.serviceType,
    this.assignedTo,
    this.branch,
    this.recruiterId,
    this.createdAt,
    this.updatedAt,
    this.nextFollowUpDate,
    this.lastContactDate,
    this.note,

    // Communication Preferences
    this.onCallCommunication,
    this.onWhatsappCommunication,
    this.onEmailCommunication,
    this.phoneCommunication,
    this.emailCommunication,
    this.whatsappCommunication,

    // Officer Information
    this.officerStaffId,
    this.officerName,

    // Personal Details
    this.birthCountry,
    this.birthPlace,
    this.emailPassword,
    this.emergencyContact,
    this.passportNumber,
    this.passportExpiryDate,
    this.religion,
    this.jobGapMonths,
    this.firstJobDate,

    // Records
    this.academicRecords,
    this.examRecords,
    this.travelRecords,
    this.workRecords,
    this.documents,

    // Additional Fields
    this.nextSchedule,
    this.feedback,

    // Business Type Specific Fields
    this.productInterest,
    this.budget,
    this.preferredLocation,
    this.preferredDate,
    this.timeline,

    // Travel Specific
    this.travelPurpose,
    this.numberOfTravelers,
    this.accommodationPreference,
    this.visitedCountries,
    this.visaTypeRequired,
    this.travelDuration,
    this.requiresTravelInsurance,
    this.requiresHotelBooking,
    this.requiresFlightBooking,

    // Education Specific
    this.preferredStudyMode,
    this.batchPreference,
    this.highestQualification,
    this.yearOfPassing,
    this.fieldOfStudy,
    this.percentageOrCGPA,
    this.coursesInterested,

    // Migration Specific
    this.targetVisaType,
    this.languageTestScores,
    this.hasRelativesAbroad,
    this.relativeCountry,
    this.relativeRelation,
    this.requiresJobAssistance,
    this.preferredSettlementCity,

    // Vehicle Specific
    this.vehicleType,
    this.brandPreference,
    this.modelPreference,
    this.fuelType,
    this.transmission,
    this.downPaymentAvailable,
    this.insuranceType,

    // Real Estate Specific
    this.propertyType,
    this.propertyUse,
    this.requiresHomeLoan,
    this.loanAmountRequiredRealEstate,
    this.possessionTimeline,
    this.furnishingPreference,
    this.requiresLegalAssistance,
    this.totalPeoples,
    this.groupType,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      // Core Lead Information
      sId: json['_id'],
      clientId: json['client_id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      countryCode: json['country_code'],
      alternatePhone: json['alternate_phone'],
      whatsapp: json['whatsapp'],
      gender: json['gender'],
      dob: json['dob'],
      maritalStatus: json['marital_status'] ?? json['matrial_status'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],

      // Professional Information
      jobInterests: List<String>.from(json['job_interests'] ?? []),
      countryInterested: List<String>.from(json['country_interested'] ?? []),
      expectedSalary: json['expected_salary'],
      qualification: json['qualification'],
      experience: json['experience'],
      skills: List<String>.from(json['skills'] ?? []),
      profession: json['profession'],
      specializedIn: List<String>.from(json['specialized_in'] ?? []),
      employmentStatus: json['employment_status'],
      annualIncome: json['annual_income']?.toDouble(),
      panCardNumber: json['pan_card_number'],
      gstNumber: json['gst_number'],
      hasExistingLoans: json['has_existing_loans'],
      loanAmountRequired: json['loan_amount_required']?.toDouble(),
      creditScore: json['credit_score'],

      // Lead Management
      leadSource: json['lead_source'],
      sourceCampaign: json['source_campaign'],
      status: json['status'],
      serviceType: json['service_type'],
      assignedTo: json['officer_id'],
      branch: json['branch'],
      recruiterId: json['recruiter_id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      nextFollowUpDate: json['next_follow_up_date'] != null
          ? DateTime.tryParse(json['next_follow_up_date'])
          : null,
      lastContactDate: json['last_contact_date'] != null
          ? DateTime.tryParse(json['last_contact_date'])
          : null,
      note: json['note'],

      // Communication Preferences
      onCallCommunication: json['on_call_communication'],
      onWhatsappCommunication: json['on_whatsapp_communication'],
      onEmailCommunication: json['on_email_communication'],
      phoneCommunication: json['phone_communication'],
      emailCommunication: json['email_communication'],
      whatsappCommunication: json['whatsapp_communication'],

      // Officer Information
      officerStaffId: json['officer_staff_id'],
      officerName: json['officer_name'],

      // Personal Details
      birthCountry: json['birth_country'],
      birthPlace: json['birth_place'],
      emailPassword: json['email_password'],
      emergencyContact: json['emergency_contact'],
      passportNumber: json['passport_number'],
      passportExpiryDate: json['passport_expiry_date'],
      religion: json['religion'],
      jobGapMonths: json['job_gap_months'],
      firstJobDate: json['first_job_date'] != null
          ? DateTime.tryParse(json['first_job_date'])
          : null,

      // Records
      academicRecords: json['academic_records'] != null
          ? List<AcademicRecordModel>.from(json['academic_records']
              .map((x) => AcademicRecordModel.fromJson(x)))
          : null,
      examRecords: json['exam_records'] != null
          ? List<ExamRecordModel>.from(
              json['exam_records'].map((x) => ExamRecordModel.fromJson(x)))
          : null,
      travelRecords: json['travel_records'] != null
          ? List<TravelRecordModel>.from(
              json['travel_records'].map((x) => TravelRecordModel.fromJson(x)))
          : null,
      workRecords: json['work_records'] != null
          ? List<WorkRecordModel>.from(
              json['work_records'].map((x) => WorkRecordModel.fromJson(x)))
          : null,
      documents: json['documents'] != null
          ? List<DocumentRecordModel>.from(
              json['documents'].map((x) => DocumentRecordModel.fromJson(x)))
          : null,

      // Additional Fields
      nextSchedule: json['next_schedule'] != null
          ? DateTime.tryParse(json['next_schedule'])
          : null,
      feedback: json['feedback'],

      // Business Type Specific Fields
      productInterest: List<String>.from(json['product_interest'] ?? []),
      budget: json['budget']?.toDouble(),
      preferredLocation: json['preferred_location'],
      preferredDate: json['preferred_date'] != null
          ? DateTime.tryParse(json['preferred_date'])
          : null,
      timeline: json['timeline'] != null
          ? List<TimelineEvent>.from(
              json['timeline'].map((x) => TimelineEvent.fromJson(x)))
          : null,

      // Travel Specific
      travelPurpose: json['travel_purpose'],
      numberOfTravelers: json['number_of_travelers'],
      accommodationPreference: json['accommodation_preference'],
      visitedCountries: List<String>.from(json['visited_countries'] ?? []),
      visaTypeRequired: json['visa_type_required'],
      travelDuration: json['travel_duration'],
      requiresTravelInsurance: json['requires_travel_insurance'],
      requiresHotelBooking: json['requires_hotel_booking'],
      requiresFlightBooking: json['requires_flight_booking'],

      // Education Specific
      preferredStudyMode: json['preferred_study_mode'],
      batchPreference: json['batch_preference'],
      highestQualification: json['highest_qualification'],
      yearOfPassing: json['year_of_passing'],
      fieldOfStudy: json['field_of_study'],
      percentageOrCGPA: json['percentage_or_cgpa']?.toDouble(),
      coursesInterested: List<String>.from(json['courses_interested'] ?? []),

      // Migration Specific
      targetVisaType: json['target_visa_type'],
      languageTestScores: json['language_test_scores'] != null
          ? List<LanguageTestScore>.from(json['language_test_scores']
              .map((x) => LanguageTestScore.fromJson(x)))
          : null,
      hasRelativesAbroad: json['has_relatives_abroad'],
      relativeCountry: json['relative_country'],
      relativeRelation: json['relative_relation'],
      requiresJobAssistance: json['requires_job_assistance'],
      preferredSettlementCity: json['preferred_settlement_city'],

      // Vehicle Specific
      vehicleType: json['vehicle_type'],
      brandPreference: json['brand_preference'],
      modelPreference: json['model_preference'],
      fuelType: json['fuel_type'],
      transmission: json['transmission'],
      downPaymentAvailable: json['down_payment_available']?.toDouble(),
      insuranceType: json['insurance_type'],

      // Real Estate Specific
      propertyType: json['property_type'],
      propertyUse: json['property_use'],
      requiresHomeLoan: json['requires_home_loan'],
      loanAmountRequiredRealEstate:
          json['loan_amount_required_real_estate']?.toDouble(),
      possessionTimeline: json['possession_timeline'],
      furnishingPreference: json['furnishing_preference'],
      requiresLegalAssistance: json['requires_legal_assistance'],
      totalPeoples: json['total_peoples'],
      groupType: json['group_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Core Lead Information
      '_id': sId,
      'client_id': clientId,
      'name': name,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'country_code': countryCode,
      'alternate_phone': alternatePhone,
      'whatsapp': whatsapp,
      'gender': gender,
      'dob': dob,
      'marital_status': maritalStatus,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,

      // Professional Information
      'job_interests': jobInterests,
      'country_interested': countryInterested,
      'expected_salary': expectedSalary,
      'qualification': qualification,
      'experience': experience,
      'skills': skills,
      'profession': profession,
      'specialized_in': specializedIn,
      'employment_status': employmentStatus,
      'annual_income': annualIncome,
      'pan_card_number': panCardNumber,
      'gst_number': gstNumber,
      'has_existing_loans': hasExistingLoans,
      'loan_amount_required': loanAmountRequired,
      'credit_score': creditScore,

      // Lead Management
      'lead_source': leadSource,
      'source_campaign': sourceCampaign,
      'status': status,
      'service_type': serviceType,
      'officer_id': assignedTo,
      'branch': branch,
      'recruiter_id': recruiterId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'next_follow_up_date': nextFollowUpDate?.toIso8601String(),
      'last_contact_date': lastContactDate?.toIso8601String(),
      'note': note,

      // Communication Preferences
      'on_call_communication': onCallCommunication,
      'on_whatsapp_communication': onWhatsappCommunication,
      'on_email_communication': onEmailCommunication,
      'phone_communication': phoneCommunication,
      'email_communication': emailCommunication,
      'whatsapp_communication': whatsappCommunication,

      // Officer Information
      'officer_staff_id': officerStaffId,
      'officer_name': officerName,

      // Personal Details
      'birth_country': birthCountry,
      'birth_place': birthPlace,
      'email_password': emailPassword,
      'emergency_contact': emergencyContact,
      'passport_number': passportNumber,
      'passport_expiry_date': passportExpiryDate,
      'religion': religion,
      'job_gap_months': jobGapMonths,
      'first_job_date': firstJobDate?.toIso8601String(),

      // Records
      'academic_records': academicRecords?.map((x) => x.toJson()).toList(),
      'exam_records': examRecords?.map((x) => x.toJson()).toList(),
      'travel_records': travelRecords?.map((x) => x.toJson()).toList(),
      'work_records': workRecords?.map((x) => x.toJson()).toList(),
      'documents': documents?.map((x) => x.toJson()).toList(),

      // Additional Fields
      'next_schedule': nextSchedule?.toIso8601String(),
      'feedback': feedback,

      // Business Type Specific Fields
      'product_interest': productInterest,
      'budget': budget,
      'preferred_location': preferredLocation,
      'preferred_date': preferredDate?.toIso8601String(),
      'timeline': timeline?.map((x) => x.toJson()).toList(),

      // Travel Specific
      'travel_purpose': travelPurpose,
      'number_of_travelers': numberOfTravelers,
      'accommodation_preference': accommodationPreference,
      'visited_countries': visitedCountries,
      'visa_type_required': visaTypeRequired,
      'travel_duration': travelDuration,
      'requires_travel_insurance': requiresTravelInsurance,
      'requires_hotel_booking': requiresHotelBooking,
      'requires_flight_booking': requiresFlightBooking,

      // Education Specific
      'preferred_study_mode': preferredStudyMode,
      'batch_preference': batchPreference,
      'highest_qualification': highestQualification,
      'year_of_passing': yearOfPassing,
      'field_of_study': fieldOfStudy,
      'percentage_or_cgpa': percentageOrCGPA,
      'courses_interested': coursesInterested,

      // Migration Specific
      'target_visa_type': targetVisaType,
      'language_test_scores':
          languageTestScores?.map((x) => x.toJson()).toList(),
      'has_relatives_abroad': hasRelativesAbroad,
      'relative_country': relativeCountry,
      'relative_relation': relativeRelation,
      'requires_job_assistance': requiresJobAssistance,
      'preferred_settlement_city': preferredSettlementCity,

      // Vehicle Specific
      'vehicle_type': vehicleType,
      'brand_preference': brandPreference,
      'model_preference': modelPreference,
      'fuel_type': fuelType,
      'transmission': transmission,
      'down_payment_available': downPaymentAvailable,
      'insurance_type': insuranceType,

      // Real Estate Specific
      'property_type': propertyType,
      'property_use': propertyUse,
      'requires_home_loan': requiresHomeLoan,
      'loan_amount_required_real_estate': loanAmountRequiredRealEstate,
      'possession_timeline': possessionTimeline,
      'furnishing_preference': furnishingPreference,
      'requires_legal_assistance': requiresLegalAssistance,
      'total_peoples': totalPeoples,
      'group_type': groupType,
    };
  }

  Map<String, dynamic> toPersonalDetailsJson() {
    return {
      'name': name,
      'last_name': lastName,
      'email': email,
      'email_password': emailPassword,
      'phone': phone,
      'country_code': countryCode,
      'emergency_contact': emergencyContact,
      'alternate_phone': alternatePhone,
      'whatsapp': whatsapp,
      'gender': gender,
      'dob': dob,
      'marital_status': maritalStatus,
      'country': country,
      'address': address,
      'birth_place': birthPlace,
      'birth_country': birthCountry,
      'religion': religion,
      'passport_number': passportNumber,
      'passport_expiry_date': passportExpiryDate,
      'note': note,
      'on_call_communication': onCallCommunication,
      'on_whatsapp_communication': onWhatsappCommunication,
      'on_email_communication': onEmailCommunication,
      'country_interested': countryInterested,
    };
  }
}

// Supporting Models
class TimelineEvent {
  final DateTime date;
  final String event;
  final String description;
  final String? performedBy;

  TimelineEvent({
    required this.date,
    required this.event,
    required this.description,
    this.performedBy,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
      date: DateTime.parse(json['date']),
      event: json['event'],
      description: json['description'],
      performedBy: json['performed_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'event': event,
      'description': description,
      'performed_by': performedBy,
    };
  }
}

class LanguageTestScore {
  final String testType; // IELTS, TOEFL, PTE
  final double overallScore;
  final Map<String, double>
      sectionScores; // reading, writing, listening, speaking
  final DateTime testDate;

  LanguageTestScore({
    required this.testType,
    required this.overallScore,
    required this.sectionScores,
    required this.testDate,
  });

  factory LanguageTestScore.fromJson(Map<String, dynamic> json) {
    return LanguageTestScore(
      testType: json['test_type'],
      overallScore: json['overall_score']?.toDouble(),
      sectionScores: Map<String, double>.from(json['section_scores']),
      testDate: DateTime.parse(json['test_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'test_type': testType,
      'overall_score': overallScore,
      'section_scores': sectionScores,
      'test_date': testDate.toIso8601String(),
    };
  }
}
