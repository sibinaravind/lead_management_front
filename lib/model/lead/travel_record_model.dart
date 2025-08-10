import 'package:overseas_front_end/utils/functions/format_date.dart';

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
      'departure_date': formatDatetoString(departureDate),
      'return_date': formatDatetoString(returnDate),
      'visa_valid_date': formatDatetoString(visaValidDate),
    };
  }
}
