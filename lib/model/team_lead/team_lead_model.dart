class TeamLeadModel {
  String? sId;
  String? officerId;
  String? name;
  String? status;
  String? phone;
  String? gender;
  String? companyPhoneNumber;
  List<int>? designation;
  List<String>? department;
  List<String>? branch;
  String? createdAt;
  List<Officers>? officers;

  TeamLeadModel(
      {this.sId,
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
      this.officers});

  TeamLeadModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    officerId = json['officer_id'];
    name = json['name'];
    status = json['status'];
    phone = json['phone'];
    gender = json['gender'];
    companyPhoneNumber = json['company_phone_number'];
    designation = json['designation'].cast<int>();
    department = json['department'].cast<String>();
    branch = json['branch'].cast<String>();
    createdAt = json['created_at'];
    if (json['officers'] != null) {
      officers = <Officers>[];
      json['officers'].forEach((v) {
        officers!.add(new Officers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['officer_id'] = this.officerId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['company_phone_number'] = this.companyPhoneNumber;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['branch'] = this.branch;
    data['created_at'] = this.createdAt;
    if (this.officers != null) {
      data['officers'] = this.officers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Officers {
  String? id;
  String? name;
  String? branch;
  String? designation;

  Officers({this.id, this.name, this.branch, this.designation});

  Officers.fromJson(Map<String, dynamic> json) {
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
