class ProjectModel {
  String? sId;
  String? projectName;
  String? organizationType;
  String? organizationCategory;
  String? organizationName;
  String? country;
  String? city;
  String? status;
  String? createdAt;

  ProjectModel(
      {this.sId,
      this.projectName,
      this.organizationType,
      this.organizationCategory,
      this.organizationName,
      this.country,
      this.city,
      this.status,
      this.createdAt});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['project_name'];
    organizationType = json['organization_type'];
    organizationCategory = json['organization_category'];
    organizationName = json['organization_name'];
    country = json['country'];
    city = json['city'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['project_name'] = this.projectName;
    data['organization_type'] = this.organizationType;
    data['organization_category'] = this.organizationCategory;
    data['organization_name'] = this.organizationName;
    data['country'] = this.country;
    data['city'] = this.city;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
