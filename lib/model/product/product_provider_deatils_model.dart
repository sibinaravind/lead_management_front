class ProductProviderDeatilsModel {
  String? name;
  String? contact;
  String? email;
  String? address;

  ProductProviderDeatilsModel({
    this.name,
    this.contact,
    this.email,
    this.address,
  });

  factory ProductProviderDeatilsModel.fromJson(Map<String, dynamic> json) =>
      ProductProviderDeatilsModel(
        name: json["name"],
        contact: json["contact"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "email": email,
        "address": address,
      };
}
