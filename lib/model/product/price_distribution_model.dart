class PriceDistributionModel {
  String? title;
  double? amount;
  double? gstPercent;
  double? cgstPercent;
  double? sgstPercent;

  PriceDistributionModel({
    this.title,
    this.amount,
    this.gstPercent,
    this.cgstPercent,
    this.sgstPercent,
  });

  factory PriceDistributionModel.fromJson(Map<String, dynamic> json) =>
      PriceDistributionModel(
        title: json["title"],
        amount: json["amount"],
        gstPercent: json["gstPercent"],
        cgstPercent: json["cgstPercent"],
        sgstPercent: json["sgstPercent"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "gstPercent": gstPercent,
        "cgstPercent": cgstPercent,
        "sgstPercent": sgstPercent,
      };
}
