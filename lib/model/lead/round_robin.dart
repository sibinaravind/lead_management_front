class RoundRobinOfficerModel {
  final String id;
  final String name;
  final String phone;
  final String companyPhoneNumber;
  final List<String> branch;
  final List<String> designation;

  RoundRobinOfficerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.companyPhoneNumber,
    required this.branch,
    required this.designation,
  });

  factory RoundRobinOfficerModel.fromJson(Map<String, dynamic> json) {
    return RoundRobinOfficerModel(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      companyPhoneNumber: json['company_phone_number'],
      branch: List<String>.from(json['branch']),
      designation: List<String>.from(json['designation']),
    );
  }
}
