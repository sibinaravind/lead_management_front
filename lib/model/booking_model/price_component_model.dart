import 'booking_applied_offer_model.dart';

class PriceComponentModel {
  String? title;
  double? amount;
  double? gstPercent;
  double? cgstPercent;
  double? sgstPercent;
  List<BookingAppliedOfferModel>? offersApplied;

  PriceComponentModel({
    this.title,
    this.amount,
    this.gstPercent,
    this.cgstPercent,
    this.sgstPercent,
    this.offersApplied,
  });

  factory PriceComponentModel.fromJson(Map<String, dynamic> json) =>
      PriceComponentModel(
        title: json["title"],
        amount: json["amount"],
        gstPercent: json["gstPercent"],
        cgstPercent: json["cgstPercent"],
        sgstPercent: json["sgstPercent"],
        offersApplied: json["offersApplied"] == null
            ? null
            : List<BookingAppliedOfferModel>.from(json["offersApplied"]
                .map((x) => BookingAppliedOfferModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "gstPercent": gstPercent,
        "cgstPercent": cgstPercent,
        "sgstPercent": sgstPercent,
        "offersApplied": offersApplied == null
            ? null
            : List<dynamic>.from(offersApplied!.map((x) => x.toJson())),
      };
}
