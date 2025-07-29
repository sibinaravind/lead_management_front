class OfficerModel {
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
  String? createdAt;
  String? token;

  OfficerModel({
    this.id,
    this.officerId,
    this.name,
    this.status,
    this.phone,
    this.gender,
    this.companyPhoneNumber,
    this.designation,
    this.department,
    this.branch,
    this.createdAt,
    this.token,
  });

  factory OfficerModel.fromJson(Map<String, dynamic> json) {
    return OfficerModel(
      id: json["_id"],
      officerId: json["officer_id"],
      name: json["name"],
      status: json["status"],
      phone: json["phone"],
      gender: json["gender"],
      companyPhoneNumber: json["company_phone_number"],
      designation: json["designation"] != null
          ? List<dynamic>.from(json["designation"])
          : null,
      department: json["department"] != null
          ? List<String>.from(json["department"])
          : null,
      branch: json["branch"] != null ? List<String>.from(json["branch"]) : null,
      createdAt: json["created_at"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "officer_id": officerId,
      "name": name,
      "status": status,
      "phone": phone,
      "gender": gender,
      "company_phone_number": companyPhoneNumber,
      "designation": designation,
      "department": department,
      "branch": branch,
      "created_at": createdAt,
      "token": token,
    };
  }
}
