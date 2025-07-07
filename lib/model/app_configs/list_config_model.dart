class ListConfigModel {
  ListConfigModel({
    required this.id,
    required this.name,
    required this.educationProgram,
    required this.knownLanguages,
    required this.university,
    required this.intake,
    required this.country,
    required this.leadCategory,
    required this.leadSource,
    required this.serviceType,
    required this.profession,
    required this.medicalProfessionCategory,
    required this.nonMedical,
    required this.callType,
    required this.callStatus,
    required this.clientStatus,
    required this.designation,
    required this.department,
    required this.test,
    required this.branch,
  });

  final String? id;
  final String? name;
  final List<Branch> educationProgram;
  final List<Branch> knownLanguages;
  final List<Branch> university;
  final List<Branch> intake;
  final List<Branch> country;
  final List<Branch> leadCategory;
  final List<Branch> leadSource;
  final List<Branch> serviceType;
  final List<Branch> profession;
  final List<Branch> medicalProfessionCategory;
  final List<Branch> nonMedical;
  final List<Branch> callType;
  final List<Branch> callStatus;
  final List<Branch> clientStatus;
  final List<Branch> designation;
  final List<Branch> department;
  final List<Branch> test;
  final List<Branch> branch;

  factory ListConfigModel.fromJson(Map<String, dynamic> json) {
    return ListConfigModel(
      id: json["_id"],
      name: json["name"],
      educationProgram: json["education_program"] == null
          ? []
          : List<Branch>.from(
              json["education_program"]!.map((x) => Branch.fromJson(x))),
      knownLanguages: json["known_languages"] == null
          ? []
          : List<Branch>.from(
              json["known_languages"]!.map((x) => Branch.fromJson(x))),
      university: json["university"] == null
          ? []
          : List<Branch>.from(
              json["university"]!.map((x) => Branch.fromJson(x))),
      intake: json["intake"] == null
          ? []
          : List<Branch>.from(json["intake"]!.map((x) => Branch.fromJson(x))),
      country: json["country"] == null
          ? []
          : List<Branch>.from(json["country"]!.map((x) => Branch.fromJson(x))),
      leadCategory: json["lead_category"] == null
          ? []
          : List<Branch>.from(
              json["lead_category"]!.map((x) => Branch.fromJson(x))),
      leadSource: json["lead_source"] == null
          ? []
          : List<Branch>.from(
              json["lead_source"]!.map((x) => Branch.fromJson(x))),
      serviceType: json["service_type"] == null
          ? []
          : List<Branch>.from(
              json["service_type"]!.map((x) => Branch.fromJson(x))),
      profession: json["profession"] == null
          ? []
          : List<Branch>.from(
              json["profession"]!.map((x) => Branch.fromJson(x))),
      medicalProfessionCategory: json["medical_profession_category"] == null
          ? []
          : List<Branch>.from(json["medical_profession_category"]!
              .map((x) => Branch.fromJson(x))),
      nonMedical: json["non_medical"] == null
          ? []
          : List<Branch>.from(
              json["non_medical"]!.map((x) => Branch.fromJson(x))),
      callType: json["call_type"] == null
          ? []
          : List<Branch>.from(
              json["call_type"]!.map((x) => Branch.fromJson(x))),
      callStatus: json["call_status"] == null
          ? []
          : List<Branch>.from(
              json["call_status"]!.map((x) => Branch.fromJson(x))),
      clientStatus: json["client_status"] == null
          ? []
          : List<Branch>.from(
              json["client_status"]!.map((x) => Branch.fromJson(x))),
      designation: json["designation"] == null
          ? []
          : List<Branch>.from(
              json["designation"]!.map((x) => Branch.fromJson(x))),
      department: json["department"] == null
          ? []
          : List<Branch>.from(
              json["department"]!.map((x) => Branch.fromJson(x))),
      test: json["test"] == null
          ? []
          : List<Branch>.from(json["test"]!.map((x) => Branch.fromJson(x))),
      branch: json["branch"] == null
          ? []
          : List<Branch>.from(json["branch"]!.map((x) => Branch.fromJson(x))),
    );
  }
}

// class Branch {
//   Branch({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.colour,
//   });

//   final String? id;
//   final String? name;
//   final String? status;
//   final String? colour;

//   factory Branch.fromJson(Map<String, dynamic> json) {
//     return Branch(
//       id: json["_id"],
//       name: json["name"],
//       status: json["status"],
//       colour: json["colour"],
//     );
//   }
// }

class Branch {
  Branch({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
    required this.province,
    required this.status,
    required this.colour,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? country;
  final String? province;
  final String? status;
  final String? colour;

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json["_id"],
      name: json["name"],
      code: json["code"],
      country: json["country"],
      province: json["province"],
      status: json["status"],
      colour: json["colour"],
    );
  }
}
