import '../../utils/functions/format_date.dart';
import 'academic_record_model.dart';
import 'call_event_model.dart';
import 'document_record_model.dart';
import 'exam_record_model.dart';
import 'product_intreseted_model.dart';
import 'travel_record_model.dart';
import 'work_record_model.dart';

class LeadModel {
  String? id;
  String? clientId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? alternatePhone;
  String? whatsapp;
  String? gender;
  String? dob;
  String? maritalStatus;
  String? serviceType;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? leadSource;
  String? sourceCampaign;
  String? status;
  String? branch;
  String? note;
  List<String>? interestedIn;
  String? feedback;
  bool? loanRequired;
  bool? onCallCommunication;
  bool? phoneCommunication;
  bool? emailCommunication;
  bool? whatsappCommunication;
  List<ProductInterestedModel>? productInterested;
  int? budget;
  String? preferredLocation;
  String? preferredDate;
  String? officerId;
  String? createdAt;
  String? updatedAt;
  List<AcademicRecordModel>? academicRecords;
  String? accommodationPreference;
  int? annualIncome;
  String? batchPreference;
  String? birthCountry;
  String? birthPlace;
  String? brandPreference;
  List<String>? countryInterested;
  List<String>? coursesInterested;
  int? creditScore;
  int? downPaymentAvailable;
  String? emailPassword;
  String? emergencyContact;
  String? employmentStatus;
  List<ExamRecordModel>? examRecords;
  int? expectedSalary;
  int? experience;
  String? fieldOfStudy;
  String? firstJobDate;
  String? fuelType;
  String? furnishingPreference;
  String? groupType;
  String? gstNumber;
  bool? hasExistingLoans;
  bool? hasRelativesAbroad;
  String? highestQualification;
  String? insuranceType;
  int? jobGapMonths;
  dynamic loanAmountRequired;
  int? loanAmountRequiredRealEstate;
  String? modelPreference;
  int? numberOfTravelers;
  String? panCardNumber;
  String? passportExpiryDate;
  String? passportNumber;
  int? percentageOrCgpa;
  String? possessionTimeline;
  String? preferredSettlementCity;
  String? preferredStudyMode;
  String? profession;
  String? propertyType;
  String? propertyUse;
  String? qualification;
  String? relativeCountry;
  String? relativeRelation;
  String? religion;
  bool? requiresFlightBooking;
  bool? requiresHomeLoan;
  bool? requiresHotelBooking;
  bool? requiresJobAssistance;
  bool? requiresLegalAssistance;
  bool? requiresTravelInsurance;
  String? skills;
  String? specializedIn;
  String? targetVisaType;
  String? totalPeoples;
  String? transmission;
  int? travelDuration;
  String? travelPurpose;
  List<TravelRecordModel>? travelRecords;
  String? vehicleType;
  String? visaTypeRequired;
  List<String>? visitedCountries;
  List<WorkRecordModel>? workRecords;
  int? yearOfPassing;
  List<DocumentRecordModel>? documents;
  String? deadLeadReason;
  CallEventModel? lastcall;
  String? officerName;
  String? idProofType;
  String? idProofNumber;
  String? officerGenId;

  LeadModel({
    this.id,
    this.clientId,
    this.name,
    this.email,
    this.phone,
    this.countryCode,
    this.alternatePhone,
    this.whatsapp,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.serviceType,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.leadSource,
    this.sourceCampaign,
    this.status,
    this.branch,
    this.note,
    this.interestedIn,
    this.feedback,
    this.loanRequired,
    this.onCallCommunication,
    this.phoneCommunication,
    this.emailCommunication,
    this.whatsappCommunication,
    this.productInterested,
    this.budget,
    this.preferredLocation,
    this.preferredDate,
    this.officerId,
    this.createdAt,
    this.updatedAt,
    this.academicRecords,
    this.accommodationPreference,
    this.annualIncome,
    this.batchPreference,
    this.birthCountry,
    this.birthPlace,
    this.brandPreference,
    this.countryInterested,
    this.coursesInterested,
    this.creditScore,
    this.downPaymentAvailable,
    this.emailPassword,
    this.emergencyContact,
    this.employmentStatus,
    this.examRecords,
    this.expectedSalary,
    this.experience,
    this.fieldOfStudy,
    this.firstJobDate,
    this.fuelType,
    this.furnishingPreference,
    this.groupType,
    this.gstNumber,
    this.hasExistingLoans,
    this.hasRelativesAbroad,
    this.highestQualification,
    this.insuranceType,
    this.jobGapMonths,
    this.loanAmountRequired,
    this.loanAmountRequiredRealEstate,
    this.modelPreference,
    this.numberOfTravelers,
    this.panCardNumber,
    this.passportExpiryDate,
    this.passportNumber,
    this.percentageOrCgpa,
    this.possessionTimeline,
    this.preferredSettlementCity,
    this.preferredStudyMode,
    this.profession,
    this.propertyType,
    this.propertyUse,
    this.qualification,
    this.relativeCountry,
    this.relativeRelation,
    this.religion,
    this.requiresFlightBooking,
    this.requiresHomeLoan,
    this.requiresHotelBooking,
    this.requiresJobAssistance,
    this.requiresLegalAssistance,
    this.requiresTravelInsurance,
    this.skills,
    this.specializedIn,
    this.targetVisaType,
    this.totalPeoples,
    this.transmission,
    this.travelDuration,
    this.travelPurpose,
    this.travelRecords,
    this.vehicleType,
    this.visaTypeRequired,
    this.visitedCountries,
    this.workRecords,
    this.yearOfPassing,
    this.documents,
    this.deadLeadReason,
    this.lastcall,
    this.officerName,
    this.idProofType,
    this.idProofNumber,
    this.officerGenId,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
        id: json["_id"],
        clientId: json["client_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        countryCode: json["country_code"],
        alternatePhone: json["alternate_phone"],
        whatsapp: json["whatsapp"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : formatDatetoString(json["dob"]),
        maritalStatus: json["marital_status"],
        serviceType: json["service_type"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        leadSource: json["lead_source"],
        sourceCampaign: json["source_campaign"],
        status: json["status"],
        note: json["note"],
        interestedIn: json["interested_in"] == null
            ? []
            : List<String>.from(json["interested_in"]!.map((x) => x)),
        feedback: json["feedback"],
        loanRequired: json["loan_required"],
        onCallCommunication: json["on_call_communication"],
        phoneCommunication: json["phone_communication"],
        emailCommunication: json["email_communication"],
        whatsappCommunication: json["whatsapp_communication"],
        productInterested: json["product_interested"] == null
            ? []
            : List<ProductInterestedModel>.from(json["product_interested"]!
                .map((x) => ProductInterestedModel.fromJson(x))),
        budget: json["budget"],
        preferredLocation: json["preferred_location"],
        preferredDate: json["preferred_date"] == null
            ? null
            : formatDatetoString(json["preferred_date"]),
        officerId: json["officer_id"],
        createdAt: json["created_at"] == null
            ? null
            : formatDatetoString(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : formatDatetoString(json["updated_at"]),
        academicRecords: json["academic_records"] == null
            ? []
            : List<AcademicRecordModel>.from(json["academic_records"]!
                .map((x) => AcademicRecordModel.fromJson(x))),
        accommodationPreference: json["accommodation_preference"],
        annualIncome: json["annual_income"],
        batchPreference: json["batch_preference"],
        birthCountry: json["birth_country"],
        birthPlace: json["birth_place"],
        brandPreference: json["brand_preference"],
        countryInterested: json["country_interested"] == null
            ? []
            : List<String>.from(json["country_interested"]!.map((x) => x)),
        coursesInterested: json["courses_interested"] == null
            ? []
            : List<String>.from(json["courses_interested"]!.map((x) => x)),
        creditScore: json["credit_score"],
        downPaymentAvailable: json["down_payment_available"],
        emailPassword: json["email_password"],
        emergencyContact: json["emergency_contact"],
        employmentStatus: json["employment_status"],
        examRecords: json["exam_records"] == null
            ? []
            : List<ExamRecordModel>.from(
                json["exam_records"]!.map((x) => ExamRecordModel.fromJson(x))),
        expectedSalary: json["expected_salary"],
        experience: json["experience"],
        fieldOfStudy: json["field_of_study"],
        firstJobDate: json["first_job_date"] == null
            ? null
            : formatDatetoString(json["first_job_date"]),
        fuelType: json["fuel_type"],
        furnishingPreference: json["furnishing_preference"],
        groupType: json["group_type"],
        gstNumber: json["gst_number"],
        hasExistingLoans: json["has_existing_loans"],
        hasRelativesAbroad: json["has_relatives_abroad"],
        highestQualification: json["highest_qualification"],
        insuranceType: json["insurance_type"],
        jobGapMonths: json["job_gap_months"],
        loanAmountRequired: json["loan_amount_required"],
        loanAmountRequiredRealEstate: json["loan_amount_required_real_estate"],
        modelPreference: json["model_preference"],
        numberOfTravelers: json["number_of_travelers"],
        panCardNumber: json["pan_card_number"],
        passportExpiryDate: json["passport_expiry_date"] == null
            ? null
            : formatDatetoString(json["passport_expiry_date"]),
        passportNumber: json["passport_number"],
        percentageOrCgpa: json["percentage_or_cgpa"],
        possessionTimeline: json["possession_timeline"] == null
            ? null
            : formatDatetoString(json["possession_timeline"]),
        preferredSettlementCity: json["preferred_settlement_city"],
        preferredStudyMode: json["preferred_study_mode"],
        profession: json["profession"],
        propertyType: json["property_type"],
        propertyUse: json["property_use"],
        qualification: json["qualification"],
        relativeCountry: json["relative_country"],
        relativeRelation: json["relative_relation"],
        religion: json["religion"],
        requiresFlightBooking: json["requires_flight_booking"],
        requiresHomeLoan: json["requires_home_loan"],
        requiresHotelBooking: json["requires_hotel_booking"],
        requiresJobAssistance: json["requires_job_assistance"],
        requiresLegalAssistance: json["requires_legal_assistance"],
        requiresTravelInsurance: json["requires_travel_insurance"],
        skills: json["skills"],
        specializedIn: json["specialized_in"],
        targetVisaType: json["target_visa_type"],
        totalPeoples: json["total_peoples"],
        transmission: json["transmission"],
        travelDuration: json["travel_duration"],
        travelPurpose: json["travel_purpose"],
        travelRecords: json["travel_records"] == null
            ? []
            : List<TravelRecordModel>.from(json["travel_records"]!
                .map((x) => TravelRecordModel.fromJson(x))),
        vehicleType: json["vehicle_type"],
        visaTypeRequired: json["visa_type_required"],
        visitedCountries: json["visited_countries"] == null
            ? []
            : List<String>.from(json["visited_countries"]!.map((x) => x)),
        workRecords: json["work_records"] == null
            ? []
            : List<WorkRecordModel>.from(
                json["work_records"]!.map((x) => WorkRecordModel.fromJson(x))),
        yearOfPassing: json["year_of_passing"],
        documents: json["documents"] == null
            ? []
            : List<DocumentRecordModel>.from(
                json["documents"]!.map((x) => DocumentRecordModel.fromJson(x))),
        deadLeadReason: json["dead_lead_reason"],
        lastcall: json["lastcall"] == null
            ? null
            : CallEventModel.fromJson(json["lastcall"]),
        officerName: (json["officer"] != null &&
                json["officer"] is Map &&
                json["officer"]["name"] != null)
            ? json["officer"]["name"]
            : null,
        branch: (json["officer"] != null &&
                json["officer"] is Map &&
                json["officer"]["branch"] != null &&
                json["officer"]["branch"] is List &&
                json["officer"]["branch"].isNotEmpty)
            ? json["officer"]["branch"][0]
            : null,
        officerGenId: (json["officer"] != null &&
                json["officer"] is Map &&
                json["officer"]["officer_id"] != null)
            ? json["officer"]["officer_id"]
            : null,
        idProofType: json["id_proof_type"],
        idProofNumber: json["id_proof_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "client_id": clientId,
        "name": name,
        "email": email,
        "phone": phone,
        "country_code": countryCode,
        "alternate_phone": alternatePhone,
        "whatsapp": whatsapp,
        "gender": gender,
        "dob": dob == null ? null : formatDateToYYYYMMDD(dob),
        "marital_status": maritalStatus,
        "service_type": serviceType,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "lead_source": leadSource,
        "source_campaign": sourceCampaign,
        "status": status,
        "note": note,
        "interested_in": interestedIn == null
            ? []
            : List<dynamic>.from(interestedIn!.map((x) => x)),
        "feedback": feedback,
        "loan_required": loanRequired,
        "on_call_communication": onCallCommunication,
        "phone_communication": phoneCommunication,
        "email_communication": emailCommunication,
        "whatsapp_communication": whatsappCommunication,
        // "product_interested": productInterested == null
        //     ? []
        //     : List<dynamic>.from(productInterested!.map((x) => x.toJson())),
        "budget": budget,
        "preferred_location": preferredLocation,
        "preferred_date":
            preferredDate == null ? null : formatDateToYYYYMMDD(preferredDate),
        "officer_id": officerId,
        "academic_records": academicRecords == null
            ? []
            : List<dynamic>.from(academicRecords!.map((x) => x.toJson())),
        "accommodation_preference": accommodationPreference,
        "annual_income": annualIncome,
        "batch_preference": batchPreference,
        "birth_country": birthCountry,
        "birth_place": birthPlace,
        "brand_preference": brandPreference,
        "country_interested": countryInterested == null
            ? []
            : List<dynamic>.from(countryInterested!.map((x) => x)),
        "courses_interested": coursesInterested == null
            ? []
            : List<dynamic>.from(coursesInterested!.map((x) => x)),
        "credit_score": creditScore,
        "down_payment_available": downPaymentAvailable,
        "email_password": emailPassword,
        "emergency_contact": emergencyContact,
        "employment_status": employmentStatus,
        "exam_records": examRecords == null
            ? []
            : List<dynamic>.from(examRecords!.map((x) => x.toJson())),
        "expected_salary": expectedSalary,
        "experience": experience,
        "field_of_study": fieldOfStudy,
        "first_job_date":
            firstJobDate == null ? null : formatDateToYYYYMMDD(firstJobDate),
        "fuel_type": fuelType,
        "furnishing_preference": furnishingPreference,
        "group_type": groupType,
        "gst_number": gstNumber,
        "has_existing_loans": hasExistingLoans,
        "has_relatives_abroad": hasRelativesAbroad,
        "highest_qualification": highestQualification,
        "insurance_type": insuranceType,
        "job_gap_months": jobGapMonths,
        "loan_amount_required": loanAmountRequired,
        "loan_amount_required_real_estate": loanAmountRequiredRealEstate,
        "model_preference": modelPreference,
        "number_of_travelers": numberOfTravelers,
        "pan_card_number": panCardNumber,
        "passport_expiry_date": passportExpiryDate == null
            ? null
            : formatDateToYYYYMMDD(passportExpiryDate),
        "passport_number": passportNumber,
        "percentage_or_cgpa": percentageOrCgpa,
        "possession_timeline": possessionTimeline,
        "preferred_settlement_city": preferredSettlementCity,
        "preferred_study_mode": preferredStudyMode,
        "profession": profession,
        "property_type": propertyType,
        "property_use": propertyUse,
        "qualification": qualification,
        "relative_country": relativeCountry,
        "relative_relation": relativeRelation,
        "religion": religion,
        "requires_flight_booking": requiresFlightBooking,
        "requires_home_loan": requiresHomeLoan,
        "requires_hotel_booking": requiresHotelBooking,
        "requires_job_assistance": requiresJobAssistance,
        "requires_legal_assistance": requiresLegalAssistance,
        "requires_travel_insurance": requiresTravelInsurance,
        "skills": skills,
        "specialized_in": specializedIn,
        "target_visa_type": targetVisaType,
        "total_peoples": totalPeoples,
        "transmission": transmission,
        "travel_duration": travelDuration,
        "travel_purpose": travelPurpose,
        "travel_records": travelRecords == null
            ? []
            : List<dynamic>.from(travelRecords!.map((x) => x.toJson())),
        "vehicle_type": vehicleType,
        "visa_type_required": visaTypeRequired,
        "visited_countries": visitedCountries == null
            ? []
            : List<dynamic>.from(visitedCountries!.map((x) => x)),
        "work_records": workRecords == null
            ? []
            : List<dynamic>.from(workRecords!.map((x) => x.toJson())),
        "year_of_passing": yearOfPassing,
        // "documents": documents == null
        //     ? []
        //     : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "dead_lead_reason": deadLeadReason,
        "lastcall": lastcall?.toJson(),
        "id_proof_type": idProofType,
        "id_proof_number": idProofNumber,
      };
}

// import 'academic_record_model.dart';
// import 'document_record_model.dart';
// import 'exam_record_model.dart';
// import 'travel_record_model.dart';
// import 'work_record_model.dart';

// class LeadModel {
//   // Core Lead Information
//   String? sId;
//   String? clientId;
//   String? name;
//   String? lastName;
//   String? email;
//   String? phone;
//   String? countryCode;
//   String? alternatePhone;
//   String? whatsapp;
//   String? gender;
//   String? dob;
//   String? maritalStatus;
//   String? address;
//   String? city;
//   String? state;
//   String? country;
//   String? pincode;

//   // Professional Information
//   List<String>? jobInterests;
//   List<String>? countryInterested;
//   int? expectedSalary;
//   String? qualification;
//   int? experience;
//   List<String>? skills;
//   String? profession;
//   List<String>? specializedIn;
//   String?
//       employmentStatus; // SALARIED, SELF_EMPLOYED, BUSINESS, STUDENT, UNEMPLOYED
//   double? annualIncome;
//   String? panCardNumber;
//   String? gstNumber;
//   bool? hasExistingLoans;
//   double? loanAmountRequired;
//   int? creditScore;

//   // Lead Management
//   String? leadSource;
//   String? sourceCampaign;
//   String?
//       status; // NEW, CONTACTED, QUALIFIED, PROPOSAL_SENT, NEGOTIATION, WON, LOST
//   String? serviceType;
//   String? assignedTo;
//   String? branch;
//   String? recruiterId;
//   String? createdAt;
//   String? updatedAt;
//   String? nextFollowUpDate;
//   String? lastContactDate;
//   String? note;

//   // Communication Preferences
//   bool? onCallCommunication;
//   bool? onWhatsappCommunication;
//   bool? onEmailCommunication;
//   bool? phoneCommunication;
//   bool? emailCommunication;
//   bool? whatsappCommunication;

//   // Officer Information
//   String? officerStaffId;
//   String? officerName;

//   // Personal Details
//   String? birthCountry;
//   String? birthPlace;
//   String? emailPassword;
//   String? emergencyContact;
//   String? passportNumber;
//   String? passportExpiryDate;
//   String? religion;
//   int? jobGapMonths;
//   String? firstJobDate;

//   // Records
//   List<AcademicRecordModel>? academicRecords;
//   List<ExamRecordModel>? examRecords;
//   List<TravelRecordModel>? travelRecords;
//   List<WorkRecordModel>? workRecords;
//   List<DocumentRecordModel>? documents;

//   // Additional Fields
//   String? nextSchedule;
//   String? feedback;

//   // Business Type Specific Fields

//   // Common for multiple business types
//   List<String>? productInterest;
//   double? budget;
//   String? preferredLocation;
//   String? preferredDate;
//   List<TimelineEvent>? timeline;

//   // Travel Specific
//   String? travelPurpose; // BUSINESS, HONEYMOON, FAMILY, FRIENDS, SOLO
//   int? numberOfTravelers;
//   String? accommodationPreference; // BUDGET, STANDARD, LUXURY
//   List<String>? visitedCountries;
//   String? visaTypeRequired;
//   int? travelDuration;
//   bool? requiresTravelInsurance;
//   bool? requiresHotelBooking;
//   bool? requiresFlightBooking;

//   // Education Specific
//   String? preferredStudyMode; // ONLINE, OFFLINE, HYBRID
//   String? batchPreference;
//   String? highestQualification;
//   int? yearOfPassing;
//   String? fieldOfStudy;
//   double? percentageOrCGPA;
//   List<String>? coursesInterested;

//   // Migration Specific
//   String? targetVisaType;
//   List<LanguageTestScore>? languageTestScores;
//   bool? hasRelativesAbroad;
//   String? relativeCountry;
//   String? relativeRelation;
//   bool? requiresJobAssistance;
//   String? preferredSettlementCity;

//   // Vehicle Specific
//   String? vehicleType; // NEW, USED
//   String? brandPreference;
//   String? modelPreference;
//   String? fuelType; // PETROL, DIESEL, ELECTRIC, CNG
//   String? transmission; // MANUAL, AUTOMATIC
//   double? downPaymentAvailable;
//   String? insuranceType; // COMPREHENSIVE, THIRD_PARTY

//   // Real Estate Specific
//   String? propertyType; // RESIDENTIAL, COMMERCIAL, PLOT, INDUSTRIAL
//   String? propertyUse; // SELF_USE, INVESTMENT, RENTAL
//   bool? requiresHomeLoan;
//   double? loanAmountRequiredRealEstate;
//   String? possessionTimeline; // IMMEDIATE, 3_MONTHS, 6_MONTHS, 1_YEAR
//   String? furnishingPreference; // FULLY_FURNISHED, SEMI_FURNISHED, UNFURNISHED
//   bool? requiresLegalAssistance;
//   String? totalPeoples;
//   String? groupType; // COUPLE, MARRIED_COUPLE, BOYS, GIRLS

//   LeadModel({
//     // Core Lead Information
//     this.sId,
//     this.clientId,
//     this.name,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.countryCode,
//     this.alternatePhone,
//     this.whatsapp,
//     this.gender,
//     this.dob,
//     this.maritalStatus,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.pincode,

//     // Professional Information
//     this.jobInterests,
//     this.countryInterested,
//     this.expectedSalary,
//     this.qualification,
//     this.experience,
//     this.skills,
//     this.profession,
//     this.specializedIn,
//     this.employmentStatus,
//     this.annualIncome,
//     this.panCardNumber,
//     this.gstNumber,
//     this.hasExistingLoans,
//     this.loanAmountRequired,
//     this.creditScore,

//     // Lead Management
//     this.leadSource,
//     this.sourceCampaign,
//     this.status,
//     this.serviceType,
//     this.assignedTo,
//     this.branch,
//     this.recruiterId,
//     this.createdAt,
//     this.updatedAt,
//     this.nextFollowUpDate,
//     this.lastContactDate,
//     this.note,

//     // Communication Preferences
//     this.onCallCommunication,
//     this.onWhatsappCommunication,
//     this.onEmailCommunication,
//     this.phoneCommunication,
//     this.emailCommunication,
//     this.whatsappCommunication,

//     // Officer Information
//     this.officerStaffId,
//     this.officerName,

//     // Personal Details
//     this.birthCountry,
//     this.birthPlace,
//     this.emailPassword,
//     this.emergencyContact,
//     this.passportNumber,
//     this.passportExpiryDate,
//     this.religion,
//     this.jobGapMonths,
//     this.firstJobDate,

//     // Records
//     this.academicRecords,
//     this.examRecords,
//     this.travelRecords,
//     this.workRecords,
//     this.documents,

//     // Additional Fields
//     this.nextSchedule,
//     this.feedback,

//     // Business Type Specific Fields
//     this.productInterest,
//     this.budget,
//     this.preferredLocation,
//     this.preferredDate,
//     this.timeline,

//     // Travel Specific
//     this.travelPurpose,
//     this.numberOfTravelers,
//     this.accommodationPreference,
//     this.visitedCountries,
//     this.visaTypeRequired,
//     this.travelDuration,
//     this.requiresTravelInsurance,
//     this.requiresHotelBooking,
//     this.requiresFlightBooking,

//     // Education Specific
//     this.preferredStudyMode,
//     this.batchPreference,
//     this.highestQualification,
//     this.yearOfPassing,
//     this.fieldOfStudy,
//     this.percentageOrCGPA,
//     this.coursesInterested,

//     // Migration Specific
//     this.targetVisaType,
//     this.languageTestScores,
//     this.hasRelativesAbroad,
//     this.relativeCountry,
//     this.relativeRelation,
//     this.requiresJobAssistance,
//     this.preferredSettlementCity,

//     // Vehicle Specific
//     this.vehicleType,
//     this.brandPreference,
//     this.modelPreference,
//     this.fuelType,
//     this.transmission,
//     this.downPaymentAvailable,
//     this.insuranceType,

//     // Real Estate Specific
//     this.propertyType,
//     this.propertyUse,
//     this.requiresHomeLoan,
//     this.loanAmountRequiredRealEstate,
//     this.possessionTimeline,
//     this.furnishingPreference,
//     this.requiresLegalAssistance,
//     this.totalPeoples,
//     this.groupType,
//   });

//   factory LeadModel.fromJson(Map<String, dynamic> json) {
//     return LeadModel(
//       // Core Lead Information
//       sId: json['_id'],
//       clientId: json['client_id'],
//       name: json['name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       phone: json['phone'],
//       countryCode: json['country_code'],
//       alternatePhone: json['alternate_phone'],
//       whatsapp: json['whatsapp'],
//       gender: json['gender'],
//       dob: json['dob'],
//       maritalStatus: json['marital_status'] ?? json['matrial_status'],
//       address: json['address'],
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       pincode: json['pincode'],

//       // Professional Information
//       jobInterests: List<String>.from(json['job_interests'] ?? []),
//       countryInterested: List<String>.from(json['country_interested'] ?? []),
//       expectedSalary: json['expected_salary'],
//       qualification: json['qualification'],
//       experience: json['experience'],
//       skills: List<String>.from(json['skills'] ?? []),
//       profession: json['profession'],
//       specializedIn: List<String>.from(json['specialized_in'] ?? []),
//       employmentStatus: json['employment_status'],
//       annualIncome: json['annual_income']?.toDouble(),
//       panCardNumber: json['pan_card_number'],
//       gstNumber: json['gst_number'],
//       hasExistingLoans: json['has_existing_loans'],
//       loanAmountRequired: json['loan_amount_required']?.toDouble(),
//       creditScore: json['credit_score'],

//       // Lead Management
//       leadSource: json['lead_source'],
//       sourceCampaign: json['source_campaign'],
//       status: json['status'],
//       serviceType: json['service_type'],
//       assignedTo: json['officer_id'],
//       branch: json['branch'],
//       recruiterId: json['recruiter_id'],
//       createdAt: json['created_at'] != null
//           ? String.tryParse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? String.tryParse(json['updated_at'])
//           : null,
//       nextFollowUpDate: json['next_follow_up_date'] != null
//           ? String.tryParse(json['next_follow_up_date'])
//           : null,
//       lastContactDate: json['last_contact_date'] != null
//           ? String.tryParse(json['last_contact_date'])
//           : null,
//       note: json['note'],

//       // Communication Preferences
//       onCallCommunication: json['on_call_communication'],
//       onWhatsappCommunication: json['on_whatsapp_communication'],
//       onEmailCommunication: json['on_email_communication'],
//       phoneCommunication: json['phone_communication'],
//       emailCommunication: json['email_communication'],
//       whatsappCommunication: json['whatsapp_communication'],

//       // Officer Information
//       officerStaffId: json['officer_staff_id'],
//       officerName: json['officer_name'],

//       // Personal Details
//       birthCountry: json['birth_country'],
//       birthPlace: json['birth_place'],
//       emailPassword: json['email_password'],
//       emergencyContact: json['emergency_contact'],
//       passportNumber: json['passport_number'],
//       passportExpiryDate: json['passport_expiry_date'],
//       religion: json['religion'],
//       jobGapMonths: json['job_gap_months'],
//       firstJobDate: json['first_job_date'] != null
//           ? String.tryParse(json['first_job_date'])
//           : null,

//       // Records
//       academicRecords: json['academic_records'] != null
//           ? List<AcademicRecordModel>.from(json['academic_records']
//               .map((x) => AcademicRecordModel.fromJson(x)))
//           : null,
//       examRecords: json['exam_records'] != null
//           ? List<ExamRecordModel>.from(
//               json['exam_records'].map((x) => ExamRecordModel.fromJson(x)))
//           : null,
//       travelRecords: json['travel_records'] != null
//           ? List<TravelRecordModel>.from(
//               json['travel_records'].map((x) => TravelRecordModel.fromJson(x)))
//           : null,
//       workRecords: json['work_records'] != null
//           ? List<WorkRecordModel>.from(
//               json['work_records'].map((x) => WorkRecordModel.fromJson(x)))
//           : null,
//       documents: json['documents'] != null
//           ? List<DocumentRecordModel>.from(
//               json['documents'].map((x) => DocumentRecordModel.fromJson(x)))
//           : null,

//       // Additional Fields
//       nextSchedule: json['next_schedule'] != null
//           ? String.tryParse(json['next_schedule'])
//           : null,
//       feedback: json['feedback'],

//       // Business Type Specific Fields
//       productInterest: List<String>.from(json['product_interest'] ?? []),
//       budget: json['budget']?.toDouble(),
//       preferredLocation: json['preferred_location'],
//       preferredDate: json['preferred_date'] != null
//           ? String.tryParse(json['preferred_date'])
//           : null,
//       timeline: json['timeline'] != null
//           ? List<TimelineEvent>.from(
//               json['timeline'].map((x) => TimelineEvent.fromJson(x)))
//           : null,

//       // Travel Specific
//       travelPurpose: json['travel_purpose'],
//       numberOfTravelers: json['number_of_travelers'],
//       accommodationPreference: json['accommodation_preference'],
//       visitedCountries: List<String>.from(json['visited_countries'] ?? []),
//       visaTypeRequired: json['visa_type_required'],
//       travelDuration: json['travel_duration'],
//       requiresTravelInsurance: json['requires_travel_insurance'],
//       requiresHotelBooking: json['requires_hotel_booking'],
//       requiresFlightBooking: json['requires_flight_booking'],

//       // Education Specific
//       preferredStudyMode: json['preferred_study_mode'],
//       batchPreference: json['batch_preference'],
//       highestQualification: json['highest_qualification'],
//       yearOfPassing: json['year_of_passing'],
//       fieldOfStudy: json['field_of_study'],
//       percentageOrCGPA: json['percentage_or_cgpa']?.toDouble(),
//       coursesInterested: List<String>.from(json['courses_interested'] ?? []),

//       // Migration Specific
//       targetVisaType: json['target_visa_type'],
//       languageTestScores: json['language_test_scores'] != null
//           ? List<LanguageTestScore>.from(json['language_test_scores']
//               .map((x) => LanguageTestScore.fromJson(x)))
//           : null,
//       hasRelativesAbroad: json['has_relatives_abroad'],
//       relativeCountry: json['relative_country'],
//       relativeRelation: json['relative_relation'],
//       requiresJobAssistance: json['requires_job_assistance'],
//       preferredSettlementCity: json['preferred_settlement_city'],

//       // Vehicle Specific
//       vehicleType: json['vehicle_type'],
//       brandPreference: json['brand_preference'],
//       modelPreference: json['model_preference'],
//       fuelType: json['fuel_type'],
//       transmission: json['transmission'],
//       downPaymentAvailable: json['down_payment_available']?.toDouble(),
//       insuranceType: json['insurance_type'],

//       // Real Estate Specific
//       propertyType: json['property_type'],
//       propertyUse: json['property_use'],
//       requiresHomeLoan: json['requires_home_loan'],
//       loanAmountRequiredRealEstate:
//           json['loan_amount_required_real_estate']?.toDouble(),
//       possessionTimeline: json['possession_timeline'],
//       furnishingPreference: json['furnishing_preference'],
//       requiresLegalAssistance: json['requires_legal_assistance'],
//       totalPeoples: json['total_peoples'],
//       groupType: json['group_type'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       // Core Lead Information
//       '_id': sId,
//       'client_id': clientId,
//       'name': name,
//       'last_name': lastName,
//       'email': email,
//       'phone': phone,
//       'country_code': countryCode,
//       'alternate_phone': alternatePhone,
//       'whatsapp': whatsapp,
//       'gender': gender,
//       'dob': dob,
//       'marital_status': maritalStatus,
//       'address': address,
//       'city': city,
//       'state': state,
//       'country': country,
//       'pincode': pincode,

//       // Professional Information
//       'job_interests': jobInterests,
//       'country_interested': countryInterested,
//       'expected_salary': expectedSalary,
//       'qualification': qualification,
//       'experience': experience,
//       'skills': skills,
//       'profession': profession,
//       'specialized_in': specializedIn,
//       'employment_status': employmentStatus,
//       'annual_income': annualIncome,
//       'pan_card_number': panCardNumber,
//       'gst_number': gstNumber,
//       'has_existing_loans': hasExistingLoans,
//       'loan_amount_required': loanAmountRequired,
//       'credit_score': creditScore,

//       // Lead Management
//       'lead_source': leadSource,
//       'source_campaign': sourceCampaign,
//       'status': status,
//       'service_type': serviceType,
//       'officer_id': assignedTo,
//       'branch': branch,
//       'recruiter_id': recruiterId,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'next_follow_up_date': nextFollowUpDate,
//       'last_contact_date': lastContactDate,
//       'note': note,

//       // Communication Preferences
//       'on_call_communication': onCallCommunication,
//       'on_whatsapp_communication': onWhatsappCommunication,
//       'on_email_communication': onEmailCommunication,
//       'phone_communication': phoneCommunication,
//       'email_communication': emailCommunication,
//       'whatsapp_communication': whatsappCommunication,

//       // Officer Information
//       'officer_staff_id': officerStaffId,
//       'officer_name': officerName,

//       // Personal Details
//       'birth_country': birthCountry,
//       'birth_place': birthPlace,
//       'email_password': emailPassword,
//       'emergency_contact': emergencyContact,
//       'passport_number': passportNumber,
//       'passport_expiry_date': passportExpiryDate,
//       'religion': religion,
//       'job_gap_months': jobGapMonths,
//       'first_job_date': firstJobDate,

//       // Records
//       'academic_records': academicRecords?.map((x) => x.toJson()).toList(),
//       'exam_records': examRecords?.map((x) => x.toJson()).toList(),
//       'travel_records': travelRecords?.map((x) => x.toJson()).toList(),
//       'work_records': workRecords?.map((x) => x.toJson()).toList(),
//       'documents': documents?.map((x) => x.toJson()).toList(),

//       // Additional Fields
//       'next_schedule': nextSchedule,
//       'feedback': feedback,

//       // Business Type Specific Fields
//       'product_interest': productInterest,
//       'budget': budget,
//       'preferred_location': preferredLocation,
//       'preferred_date': preferredDate,
//       'timeline': timeline?.map((x) => x.toJson()).toList(),

//       // Travel Specific
//       'travel_purpose': travelPurpose,
//       'number_of_travelers': numberOfTravelers,
//       'accommodation_preference': accommodationPreference,
//       'visited_countries': visitedCountries,
//       'visa_type_required': visaTypeRequired,
//       'travel_duration': travelDuration,
//       'requires_travel_insurance': requiresTravelInsurance,
//       'requires_hotel_booking': requiresHotelBooking,
//       'requires_flight_booking': requiresFlightBooking,

//       // Education Specific
//       'preferred_study_mode': preferredStudyMode,
//       'batch_preference': batchPreference,
//       'highest_qualification': highestQualification,
//       'year_of_passing': yearOfPassing,
//       'field_of_study': fieldOfStudy,
//       'percentage_or_cgpa': percentageOrCGPA,
//       'courses_interested': coursesInterested,

//       // Migration Specific
//       'target_visa_type': targetVisaType,
//       'language_test_scores':
//           languageTestScores?.map((x) => x.toJson()).toList(),
//       'has_relatives_abroad': hasRelativesAbroad,
//       'relative_country': relativeCountry,
//       'relative_relation': relativeRelation,
//       'requires_job_assistance': requiresJobAssistance,
//       'preferred_settlement_city': preferredSettlementCity,

//       // Vehicle Specific
//       'vehicle_type': vehicleType,
//       'brand_preference': brandPreference,
//       'model_preference': modelPreference,
//       'fuel_type': fuelType,
//       'transmission': transmission,
//       'down_payment_available': downPaymentAvailable,
//       'insurance_type': insuranceType,

//       // Real Estate Specific
//       'property_type': propertyType,
//       'property_use': propertyUse,
//       'requires_home_loan': requiresHomeLoan,
//       'loan_amount_required_real_estate': loanAmountRequiredRealEstate,
//       'possession_timeline': possessionTimeline,
//       'furnishing_preference': furnishingPreference,
//       'requires_legal_assistance': requiresLegalAssistance,
//       'total_peoples': totalPeoples,
//       'group_type': groupType,
//     };
//   }

//   Map<String, dynamic> toPersonalDetailsJson() {
//     return {
//       'name': name,
//       'last_name': lastName,
//       'email': email,
//       'email_password': emailPassword,
//       'phone': phone,
//       'country_code': countryCode,
//       'emergency_contact': emergencyContact,
//       'alternate_phone': alternatePhone,
//       'whatsapp': whatsapp,
//       'gender': gender,
//       'dob': dob,
//       'marital_status': maritalStatus,
//       'country': country,
//       'address': address,
//       'birth_place': birthPlace,
//       'birth_country': birthCountry,
//       'religion': religion,
//       'passport_number': passportNumber,
//       'passport_expiry_date': passportExpiryDate,
//       'note': note,
//       'on_call_communication': onCallCommunication,
//       'on_whatsapp_communication': onWhatsappCommunication,
//       'on_email_communication': onEmailCommunication,
//       'country_interested': countryInterested,
//     };
//   }
// }

// // Supporting Models
// class TimelineEvent {
//   final String date;
//   final String event;
//   final String description;
//   final String? performedBy;

//   TimelineEvent({
//     required this.date,
//     required this.event,
//     required this.description,
//     this.performedBy,
//   });

//   factory TimelineEvent.fromJson(Map<String, dynamic> json) {
//     return TimelineEvent(
//       date: String.parse(json['date']),
//       event: json['event'],
//       description: json['description'],
//       performedBy: json['performed_by'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'event': event,
//       'description': description,
//       'performed_by': performedBy,
//     };
//   }
// }

// class LanguageTestScore {
//   final String testType; // IELTS, TOEFL, PTE
//   final double overallScore;
//   final Map<String, double>
//       sectionScores; // reading, writing, listening, speaking
//   final String testDate;

//   LanguageTestScore({
//     required this.testType,
//     required this.overallScore,
//     required this.sectionScores,
//     required this.testDate,
//   });

//   factory LanguageTestScore.fromJson(Map<String, dynamic> json) {
//     return LanguageTestScore(
//       testType: json['test_type'],
//       overallScore: json['overall_score']?.toDouble(),
//       sectionScores: Map<String, double>.from(json['section_scores']),
//       testDate: String.parse(json['test_date']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'test_type': testType,
//       'overall_score': overallScore,
//       'section_scores': sectionScores,
//       'test_date': testDate.toIso8601String(),
//     };
//   }
// }
