class OfficersModel {
  String? id;
  String? officerId;
  String? name;
  String? status;
  String? phone;
  String? gender;
  String? companyPhoneNumber;
  List<dynamic>? designation;
  List<String>? department;
  List<String>? branch;
  DateTime? createdAt;
  List<SubOfficerModel>? officers;

  OfficersModel({
    required this.id,
    required this.officerId,
    required this.name,
    required this.status,
    required this.phone,
    required this.gender,
    required this.companyPhoneNumber,
    required this.designation,
    required this.department,
    required this.branch,
    required this.createdAt,
    required this.officers,
  });

  // factory OfficersModel.fromJson(Map<String, dynamic> json) => OfficersModel(
  //       id: json["_id"],
  //       officerId: json["officer_id"],
  //       name: json["name"],
  //       status: json["status"],
  //       phone: json["phone"],
  //       gender: json["gender"],
  //       companyPhoneNumber: json["company_phone_number"],
  //       // designation: List<dynamic>.from(json["designation"].map((x) => x)),
  //       // department: List<String>.from(json["department"].map((x) => x)),
  //       // branch: List<String>.from(json["branch"].map((x) => x)),
  //       // createdAt: DateTime.parse(json["created_at"]),
  //   designation: json["designation"] != null
  //       ? List<dynamic>.from(json["designation"].map((x) => x))
  //       : [],
  //   department: json["department"] != null
  //       ? List<String>.from(json["department"].map((x) => x))
  //       : [],
  //   branch: json["branch"] != null
  //       ? List<String>.from(json["branch"].map((x) => x))
  //       : [],
  //   createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
  //
  //   // officers: List<String>.from(json["officers"].map((x) => x)),
  //   officers: json["officers"] != null
  //       ? List<String>.from(json["officers"].map((x) => x))
  //       : [],
  //     );
  factory OfficersModel.fromJson(Map<String, dynamic> json) => OfficersModel(
    id: json["_id"],
    officerId: json["officer_id"],
    name: json["name"],
    status: json["status"],
    phone: json["phone"],
    gender: json["gender"],
    companyPhoneNumber: json["company_phone_number"],
    designation: json["designation"] != null
        ? List<dynamic>.from(json["designation"].map((x) => x))
        : [],
    department: json["department"] != null
        ? List<String>.from(json["department"].map((x) => x))
        : [],
    branch: json["branch"] != null
        ? List<String>.from(json["branch"].map((x) => x))
        : [],
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    // officers: json["officers"] != null
    //     ? List<String>.from(json["officers"].map((x) => x))
    //     : [],
    officers: json["officers"] != null
        ? List<SubOfficerModel>.from(json["officers"].map((x) => SubOfficerModel.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "officer_id": officerId,
        "name": name,
        "status": status,
        "phone": phone,
        "gender": gender,
        "company_phone_number": companyPhoneNumber,
        "designation": List<dynamic>.from(designation?.map((x) => x)??[]),
        "department": List<dynamic>.from(department?.map((x) => x)??[]),
        "branch": List<dynamic>.from(branch?.map((x) => x)??[]),
        "created_at": createdAt?.toIso8601String()??'',
        "officers": List<dynamic>.from(officers?.map((x) => x)??[]),
      };
}

class SubOfficerModel {
  String? id;
  String? name;
  String? branch;
  int? designation;

  SubOfficerModel({this.id, this.name, this.branch, this.designation});

  SubOfficerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    branch = json['branch'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['branch'] = this.branch;
    data['designation'] = this.designation;
    return data;
  }
}


// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:overseas_front_end/model/doc_file_model/doc_file_model.dart';
//
// OfficerModel officerModelFromJson(String str) =>
//     OfficerModel.fromJson(json.decode(str));
//
// String officerModelToJson(OfficerModel data) => json.encode(data.toJson());
//
// class OfficerModel {
//   String? id;
//   String? officerId;
//   String? salutation;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? dob;
//   String? gender;
//   String? email;
//   String? phone;
//   String? alternatePhone;
//   String? address;
//   String? city;
//   String? state;
//   String? country;
//   String? status;
//   String? emergencyContact;
//   String? emergencyContactName;
//   String? emergencyContactRelation;
//   List<dynamic>? designation;
//   List<dynamic>? branch;
//   String? nationality;
//   String? maritalStatus;
//   Uint8List? imageBytes;
//   String? pin;
//   DocFileModel? docFile;
//   String? joiningDate; // Added field
//
//   OfficerModel({
//     this.id,
//     this.officerId,
//     this.salutation,
//     this.firstName,
//     this.middleName,
//     this.lastName,
//     this.dob,
//     this.gender,
//     this.email,
//     this.phone,
//     this.alternatePhone,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.status,
//     this.emergencyContact,
//     this.emergencyContactName,
//     this.emergencyContactRelation,
//     this.designation,
//     this.branch,
//     this.docFile,
//     this.nationality,
//     this.maritalStatus,
//     this.imageBytes,
//     this.pin,
//     this.joiningDate, // Added field
//   });
//
//   OfficerModel copyWith({
//     String? id,
//     String? officerId,
//     String? salutation,
//     String? firstName,
//     String? middleName,
//     String? lastName,
//     String? dob,
//     String? gender,
//     String? email,
//     String? phone,
//     String? alternatePhone,
//     String? address,
//     String? city,
//     String? state,
//     String? country,
//     String? status,
//     String? emergencyContact,
//     String? emergencyContactName,
//     String? emergencyContactRelation,
//     List<String>? designation,
//     List<String>? branch,
//     DocFileModel? docFile,
//     String? nationality,
//     String? maritalStatus,
//     Uint8List? imageBytes,
//     String? mobileTeleCode,
//     String? whatsmobileTeleCode,
//     String? alterselectedTeleCode,
//     String? emerselectedTeleCode,
//     String? pin,
//     String? joiningDate, // Added field
//   }) =>
//       OfficerModel(
//         id: id ?? this.id,
//         officerId: officerId ?? this.officerId,
//         salutation: salutation ?? this.salutation,
//         firstName: firstName ?? this.firstName,
//         middleName: middleName ?? this.middleName,
//         lastName: lastName ?? this.lastName,
//         dob: dob ?? this.dob,
//         gender: gender ?? this.gender,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         alternatePhone: alternatePhone ?? this.alternatePhone,
//         address: address ?? this.address,
//         city: city ?? this.city,
//         state: state ?? this.state,
//         country: country ?? this.country,
//         status: status ?? this.status,
//         emergencyContact: emergencyContact ?? this.emergencyContact,
//         emergencyContactName: emergencyContactName ?? this.emergencyContactName,
//         emergencyContactRelation:
//             emergencyContactRelation ?? this.emergencyContactRelation,
//         designation: designation ?? this.designation,
//         branch: branch ?? this.branch,
//         docFile: docFile ?? this.docFile,
//         nationality: nationality ?? this.nationality,
//         maritalStatus: maritalStatus ?? this.maritalStatus,
//         imageBytes: imageBytes ?? this.imageBytes,
//         pin: pin ?? this.pin,
//         joiningDate: joiningDate ?? this.joiningDate, // Added field
//       );
//
//   factory OfficerModel.fromJson(Map<String, dynamic> json) => OfficerModel(
//         id: json["_id"],
//         officerId: json["officer_id"],
//         salutation: json["salutation"],
//         firstName: json["first_name"],
//         middleName: json["middle_name"],
//         lastName: json["last_name"],
//         dob: json["dob"],
//         gender: json["gender"],
//         email: json["email"],
//         phone: json["phone"],
//         alternatePhone: json["alternate_phone"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         status: json["status"],
//         emergencyContact: json["emergency_contact"],
//         emergencyContactName: json["emergency_contact_name"],
//         emergencyContactRelation: json["emergency_contact_relation"],
//         designation: json["designation"] == null
//             ? []
//             : List<String>.from(json["designation"]),
//         branch: json["branch"] == null ? [] : List<String>.from(json["branch"]),
//         docFile: json["doc_file"] == null
//             ? null
//             : DocFileModel.fromJson(json["doc_file"]),
//         nationality: json["nationality"],
//         maritalStatus: json["marital_status"],
//         imageBytes: json["image_bytes"] != null
//             ? base64Decode(json["image_bytes"])
//             : null,
//         pin: json["pin"],
//         joiningDate: json["joining_date"], // Added field
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "officer_id": officerId,
//         "salutation": salutation,
//         "first_name": firstName,
//         "middle_name": middleName,
//         "last_name": lastName,
//         "dob": dob,
//         "gender": gender,
//         "email": email,
//         "phone": phone,
//         "alternate_phone": alternatePhone,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country": country,
//         "status": status,
//         "emergency_contact": emergencyContact,
//         "emergency_contact_name": emergencyContactName,
//         "emergency_contact_relation": emergencyContactRelation,
//         "designation": designation,
//         "branch": branch,
//         "doc_file": docFile?.toJson(),
//         "nationality": nationality,
//         "marital_status": maritalStatus,
//         "image_bytes": imageBytes != null ? base64Encode(imageBytes!) : null,
//         "pin": pin,
//         "joining_date": joiningDate, // Added field
//       };
// }

// To parse this JSON data, do
//
//     final officersList = officersListFromJson(jsonString);

// To parse this JSON data, do
//
//     final officersList = officersListFromJson(jsonString);