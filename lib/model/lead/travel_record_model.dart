class TravelRecordModel {
  String? country;
  String? visaType;
  DateTime? departureDate;
  DateTime? returnDate;
  DateTime? visaValidDate;

  TravelRecordModel({
    this.country,
    this.visaType,
    this.departureDate,
    this.returnDate,
    this.visaValidDate,
  });

  factory TravelRecordModel.fromJson(Map<String, dynamic> json) {
    return TravelRecordModel(
      country: json['country'],
      visaType: json['visa_type'],
      departureDate: json['departure_date'] != null
          ? DateTime.tryParse(json['departure_date'])
          : null,
      returnDate: json['return_date'] != null
          ? DateTime.tryParse(json['return_date'])
          : null,
      visaValidDate: json['visa_valid_date'] != null
          ? DateTime.tryParse(json['visa_valid_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'visa_type': visaType,
      'departure_date': departureDate?.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'visa_valid_date': visaValidDate?.toIso8601String(),
    };
  }
}
