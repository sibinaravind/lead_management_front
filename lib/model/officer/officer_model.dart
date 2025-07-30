class OfficerModel {
  String? id;
  String? officerId;
  String? name;
  String? status;
  String? phone;
  String? gender;
  String? companyPhoneNumber;
  List<String>? designation;
  List<String>? branch;
  String? createdAt;
  String? token;
  List<OfficerModel>? officers;
  String? password;

  OfficerModel({
    this.id,
    this.officerId,
    this.name,
    this.status,
    this.phone,
    this.gender,
    this.companyPhoneNumber,
    this.designation,
    this.branch,
    this.createdAt,
    this.token,
    this.officers,
    this.password,
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
          ? List<String>.from(json["designation"])
          : null,
      branch: json["branch"] != null ? List<String>.from(json["branch"]) : null,
      createdAt: json["created_at"],
      token: json["token"],
      officers: json["officers"] != null
          ? (json["officers"] as List)
              .map((v) => OfficerModel.fromJson(v))
              .toList()
          : null,
      password: json["password"],
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
      "branch": branch,
      "created_at": createdAt,
      "token": token,
      "officers": officers?.map((v) => v.toJson()).toList(),
      "password": password,
    };
  }

  OfficerModel copyWith({
    String? id,
    String? officerId,
    String? name,
    String? status,
    String? phone,
    String? gender,
    String? companyPhoneNumber,
    List<String>? designation,
    List<String>? branch,
    String? createdAt,
    String? token,
    List<OfficerModel>? officers,
    String? password,
  }) {
    return OfficerModel(
      id: id ?? this.id,
      officerId: officerId ?? this.officerId,
      name: name ?? this.name,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      companyPhoneNumber: companyPhoneNumber ?? this.companyPhoneNumber,
      designation: designation ?? this.designation,
      branch: branch ?? this.branch,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
      officers: officers ?? this.officers,
      password: password ?? this.password,
    );
  }
}
