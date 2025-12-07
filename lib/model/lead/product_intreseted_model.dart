import 'product_offered_model.dart';

class ProductInterestedModel {
  String? productId;
  String? productName;
  List<ProductOfferedModel>? offers;

  ProductInterestedModel({
    this.productId,
    this.productName,
    this.offers,
  });

  factory ProductInterestedModel.fromJson(Map<String, dynamic> json) =>
      ProductInterestedModel(
        productId: json["product_id"],
        productName: json["product_name"],
        offers: json["offers"] == null
            ? []
            : List<ProductOfferedModel>.from(
                json["offers"]!.map((x) => ProductOfferedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };

  ProductInterestedModel copyWith({
    String? productId,
    String? productName,
    List<ProductOfferedModel>? offers,
  }) {
    return ProductInterestedModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      offers: offers ?? this.offers,
    );
  }
}
