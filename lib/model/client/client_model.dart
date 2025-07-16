class ClientModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? alternatePhone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? status;
  String? createdAt;

  ClientModel(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.alternatePhone,
      this.address,
      this.city,
      this.state,
      this.country,
      this.status,
      this.createdAt});

  ClientModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
