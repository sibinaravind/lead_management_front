class LeadModel {
  String? sId;
  String? clientId;
  String? name;
  String? email;
  String? phone;
  String? leadSource;
  String? assignedTo;
  String? status;
  String? createdAt;

  LeadModel(
      {this.sId,
      this.clientId,
      this.name,
      this.email,
      this.phone,
      this.leadSource,
      this.assignedTo,
      this.status,
      this.createdAt});

  LeadModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clientId = json['client_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    leadSource = json['lead_source'];
    assignedTo = json['assigned_to'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['lead_source'] = this.leadSource;
    data['assigned_to'] = this.assignedTo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
