class TeamLeadModel {
  String? sId;
  String? officerId;
  String? name;
  String? status;
  String? phone;
  String? gender;
  String? companyPhoneNumber;
  List<String>? designation;
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
    designation = json['designation'].cast<String>();
    // department = json['department'].cast<String>();
    // branch = json['branch'].cast<String>() ?? '';
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

  static void updateOfficerInList(
      List<TeamLeadModel> list, TeamLeadModel updatedOfficer) {
    int index = list.indexWhere((officer) => officer.sId == updatedOfficer.sId);
    if (index != -1) {
      list[index] = updatedOfficer;
    }
  }

  /// Delete from list
  static void deleteOfficerFromList(List<TeamLeadModel> list, String id) {
    list.removeWhere((officer) => officer.sId == id);
  }
}

class Officers {
  String? officerId;
  bool? editPermission;
  String? staffId;
  String? name;
  String? phone;
  String? companyPhoneNumber;
  String? sId;
  String? branch;

  Officers(
      {this.officerId,
      this.editPermission,
      this.staffId,
      this.name,
      this.phone,
      this.companyPhoneNumber,
      this.sId,
      this.branch});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officer_id'] = this.officerId;
    data['edit_permission'] = this.editPermission;
    data['staff_id'] = this.staffId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['company_phone_number'] = this.companyPhoneNumber;
    data['_id'] = this.sId;
    data['branch'] = this.branch;
    return data;
  }
}
