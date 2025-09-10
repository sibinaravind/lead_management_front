import 'academic_record_model.dart';
import 'document_record_model.dart';
import 'exam_record_model.dart';
import 'travel_record_model.dart';
import 'work_record_model.dart';

class LeadModel {
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
  List<String>? jobInterests;
  List<String>? countryInterested;
  int? expectedSalary;
  String? qualification;
  int? experience;
  List<String>? skills;
  String? profession;
  List<String>? specializedIn;
  String? leadSource;
  String? note;
  bool? onCallCommunication;
  bool? onWhatsappCommunication;
  bool? onEmailCommunication;
  String? status;
  String? serviceType;
  String? assignedTo;
  String? branch;
  String? recruiterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? officerStaffId;
  String? officerName;
  String? birthCountry;
  String? birthPlace;
  String? emailPassword;
  String? emergencyContact;
  String? passportNumber;
  String? passportExpiryDate;
  String? religion;
  int? jobGapMonths;
  DateTime? firstJobDate;
  List<AcademicRecordModel>? academicRecords;
  List<ExamRecordModel>? examRecords;
  List<TravelRecordModel>? travelRecords;
  List<WorkRecordModel>? workRecords;
  List<DocumentRecordModel>? documents;
  DateTime? nextSchedule; // Added
  String? feedback; // Added

  LeadModel({
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
    this.jobInterests,
    this.countryInterested,
    this.expectedSalary,
    this.qualification,
    this.experience,
    this.skills,
    this.profession,
    this.specializedIn,
    this.leadSource,
    this.note,
    this.onCallCommunication,
    this.onWhatsappCommunication,
    this.onEmailCommunication,
    this.status,
    this.serviceType,
    this.assignedTo,
    this.branch,
    this.recruiterId,
    this.createdAt,
    this.updatedAt,
    this.officerStaffId,
    this.officerName,
    this.birthCountry,
    this.birthPlace,
    this.emailPassword,
    this.emergencyContact,
    this.passportNumber,
    this.passportExpiryDate,
    this.religion,
    this.jobGapMonths,
    this.firstJobDate,
    this.academicRecords,
    this.examRecords,
    this.travelRecords,
    this.workRecords,
    this.documents,
    this.nextSchedule, // Added
    this.feedback, // Added
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
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
      jobInterests: List<String>.from(json['job_interests'] ?? []),
      countryInterested: List<String>.from(json['country_interested'] ?? []),
      expectedSalary: json['expected_salary'],
      qualification: json['qualification'],
      experience: json['experience'],
      skills: List<String>.from(json['skills'] ?? []),
      profession: json['profession'],
      specializedIn: List<String>.from(json['specialized_in'] ?? []),
      leadSource: json['lead_source'],
      note: json['note'],
      onCallCommunication: json['on_call_communication'],
      onWhatsappCommunication: json['on_whatsapp_communication'],
      onEmailCommunication: json['on_email_communication'],
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
      nextSchedule: json['next_schedule'] != null
          ? DateTime.tryParse(json['next_schedule'])
          : null,
      feedback: json['feedback'],
      officerName: json['officer_name'],
      officerStaffId: json['officer_staff_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'job_interests': jobInterests,
      'country_interested': countryInterested,
      'expected_salary': expectedSalary,
      'qualification': qualification,
      'experience': experience,
      'skills': skills,
      'profession': profession,
      'specialized_in': specializedIn,
      'lead_source': leadSource,
      'note': note,
      'on_call_communication': onCallCommunication,
      'on_whatsapp_communication': onWhatsappCommunication,
      'on_email_communication': onEmailCommunication,
      'status': status,
      'service_type': serviceType,
      'officer_id': assignedTo,
      'branch': branch,
      'recruiter_id': recruiterId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'birth_country': birthCountry,
      'birth_place': birthPlace,
      'email_password': emailPassword,
      'emergency_contact': emergencyContact,
      'passport_number': passportNumber,
      'passport_expiry_date': passportExpiryDate,
      'religion': religion,
      'job_gap_months': jobGapMonths,
      'first_job_date': firstJobDate?.toIso8601String(),
      'academic_records': academicRecords?.map((x) => x.toJson()).toList(),
      'exam_records': examRecords?.map((x) => x.toJson()).toList(),
      'travel_records': travelRecords?.map((x) => x.toJson()).toList(),
      'work_records': workRecords?.map((x) => x.toJson()).toList(),
      'documents': documents?.map((x) => x.toJson()).toList(),
      'next_schedule': nextSchedule?.toIso8601String(), // Added
      'feedback': feedback, // Added
      'officer_name': officerName,
      'officer_staff_id': officerStaffId,
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
