class PriceDistributionModel {
  String? title;
  int? percent;
  int? gstPercent;
  int? cgstPercent;
  int? sgstPercent;

  PriceDistributionModel({
    this.title,
    this.percent,
    this.gstPercent,
    this.cgstPercent,
    this.sgstPercent,
  });

  factory PriceDistributionModel.fromJson(Map<String, dynamic> json) =>
      PriceDistributionModel(
        title: json["title"],
        percent: json["percent"],
        gstPercent: json["gstPercent"],
        cgstPercent: json["cgstPercent"],
        sgstPercent: json["sgstPercent"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "percent": percent,
        "gstPercent": gstPercent,
        "cgstPercent": cgstPercent,
        "sgstPercent": sgstPercent,
      };
}
