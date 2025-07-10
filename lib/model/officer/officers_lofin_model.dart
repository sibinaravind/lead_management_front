class Officer {
  String id;
  String officerId;
  String name;
  String status;
  String phone;
  String gender;
  String companyPhoneNumber;
  List<dynamic> designation;
  List<String> department;
  List<String> branch;
  String createdAt;

  Officer({
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
  });

  factory Officer.fromJson(Map<String, dynamic> json) {
    return Officer(
      id: json["_id"],
      officerId: json["officer_id"],
      name: json["name"],
      status: json["status"],
      phone: json["phone"],
      gender: json["gender"],
      companyPhoneNumber: json["company_phone_number"],
      designation: List<dynamic>.from(json["designation"]),
      department: List<String>.from(json["department"]),
      branch: List<String>.from(json["branch"]),
      createdAt: json["created_at"],
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
    };
  }
}
