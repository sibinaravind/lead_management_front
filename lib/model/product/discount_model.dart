class DiscountModel {
  String? title;
  double? percent;
  String? validFrom;
  String? validTo;

  DiscountModel({
    this.title,
    this.percent,
    this.validFrom,
    this.validTo,
  });
  factory DiscountModel.fromMap(Map<String, dynamic> map) {
    return DiscountModel(
      title: map['title'],
      percent: map['percent']?.toDouble(),
      validFrom: map['validFrom'],
      validTo: map['validTo'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'percent': percent,
      'validFrom': validFrom,
      'validTo': validTo,
    };
  }
}
