import '../../utils/functions/format_date.dart';

class ProductOfferedModel {
  int? offerPrice;
  int? demandingPrice;
  String? uploadedAt;
  String? updatedBy;
  String? description;

  ProductOfferedModel({
    this.offerPrice,
    this.demandingPrice,
    this.uploadedAt,
    this.updatedBy,
    this.description,
  });

  factory ProductOfferedModel.fromJson(Map<String, dynamic> json) =>
      ProductOfferedModel(
        offerPrice: json["offer_price"],
        demandingPrice: json["demanding_price"],
        uploadedAt: json["uploaded_at"] == null
            ? null
            : formatDatetoString(json["uploaded_at"]),
        updatedBy: json["updated_by"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "offer_price": offerPrice,
        "demanding_price": demandingPrice,
        "uploaded_at": uploadedAt ?? formatDateToYYYYMMDD(uploadedAt),
        "updated_by": updatedBy,
        "description": description,
      };
}
