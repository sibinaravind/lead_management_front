class ClientModel {
  final String id;
  final String clientId;
  final String name;
  final String email;
  final String phone;
  final String alternatePhone;
  final String address;
  final String city;
  final String state;
  final String country;
  final String status;
  final DateTime createdAt;

  ClientModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.email,
    required this.phone,
    required this.alternatePhone,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.status,
    required this.createdAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'],
      clientId: json['client_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      alternatePhone: json['alternate_phone'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
