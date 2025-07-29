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
  List<Officers>? officers;

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
          ? (json["officers"] as List).map((v) => Officers.fromJson(v)).toList()
          : null,
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
    };
  }
}

/// ✅ Same Officers model from your TeamLeadModel
class Officers {
  String? officerId;
  bool? editPermission;
  String? staffId;
  String? name;
  String? phone;
  String? companyPhoneNumber;
  String? sId;
  String? branch;

  Officers({
    this.officerId,
    this.editPermission,
    this.staffId,
    this.name,
    this.phone,
    this.companyPhoneNumber,
    this.sId,
    this.branch,
  });

  Officers.fromJson(Map<String, dynamic> json) {
    officerId = json['officer_id'];
    editPermission = json['edit_permission'];
    staffId = json['staff_id'];
    name = json['name'];
    phone = json['phone'];
    companyPhoneNumber = json['company_phone_number'];
    sId = json['_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    return {
      'officer_id': officerId,
      'edit_permission': editPermission,
      'staff_id': staffId,
      'name': name,
      'phone': phone,
      'company_phone_number': companyPhoneNumber,
      '_id': sId,
      'branch': branch,
    };
  }
}
