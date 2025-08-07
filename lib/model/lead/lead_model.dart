class LeadModel {
  String? sId;
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

  LeadModel({
    this.sId,
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
  });

  LeadModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clientId = json['client_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    alternatePhone = json['alternate_phone'];
    whatsapp = json['whatsapp'];
    gender = json['gender'];
    dob = json['dob'];
    maritalStatus = json['matrial_status'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    jobInterests = List<String>.from(json['job_interests'] ?? []);
    countryInterested = List<String>.from(json['country_interested'] ?? []);
    expectedSalary = json['expected_salary'];
    qualification = json['qualification'];
    experience = json['experience'];
    skills = List<String>.from(json['skills'] ?? []);
    profession = json['profession'];
    specializedIn = List<String>.from(json['specialized_in'] ?? []);
    leadSource = json['lead_source'];
    note = json['note'];
    onCallCommunication = json['on_call_communication'];
    onWhatsappCommunication = json['on_whatsapp_communication'];
    onEmailCommunication = json['on_email_communication'];
    status = json['status'];
    serviceType = json['service_type'];
    assignedTo = json['assigned_to'];
    branch = json['branch'];

    recruiterId = json['recruiter_id'];
    createdAt = json['created_at'] != null && json['created_at'] is String
        ? DateTime.tryParse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null && json['updated_at'] is String
        ? DateTime.tryParse(json['updated_at'])
        : null;
    officerStaffId = json['officer_staff_id'];
    officerName = json['officer_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': sId,
      // 'client_id': clientId,
      'name': name,
      'email': email,
      'phone': phone,
      'country_code': countryCode,
      'alternate_phone': alternatePhone,
      'whatsapp': whatsapp,
      'gender': gender,
      'dob': dob,
      'matrial_status': maritalStatus,
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
      // 'recruiter_id': recruiterId,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      // 'officer_staff_id': officerStaffId,
      // 'officer_name': officerName,
    };
  }
}
