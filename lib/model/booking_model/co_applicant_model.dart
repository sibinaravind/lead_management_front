class CoApplicantModel {
  String? name;
  String? phone;
  DateTime? dob;
  String? address;
  String? email;
  String? idCardType;
  String? idCardNumber;

  CoApplicantModel({
    this.name,
    this.phone,
    this.dob,
    this.address,
    this.email,
    this.idCardType,
    this.idCardNumber,
  });

  factory CoApplicantModel.fromJson(Map<String, dynamic> json) {
    return CoApplicantModel(
      name: json['name'],
      phone: json['phone'],
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      address: json['address'],
      email: json['email'],
      idCardType: json['idCardType'],
      idCardNumber: json['idCardNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'dob': dob?.toIso8601String(),
      'address': address,
      'email': email,
      'idCardType': idCardType,
      'idCardNumber': idCardNumber,
    };
  }
}
