class BookingAppliedOfferModel {
  String? offerName;
  double? discountAmount;

  BookingAppliedOfferModel({
    this.offerName,
    this.discountAmount,
  });

  factory BookingAppliedOfferModel.fromJson(Map<String, dynamic> json) {
    return BookingAppliedOfferModel(
      offerName: json['offer_name'],
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer_name': offerName,
      'discount_amount': discountAmount,
    };
  }
}
