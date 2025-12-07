class TravelRecordModel {
  String? country;
  String? purpose;
  String? duration;
  int? year;
  String? description;

  TravelRecordModel({
    this.country,
    this.purpose,
    this.duration,
    this.year,
    this.description,
  });

  factory TravelRecordModel.fromJson(Map<String, dynamic> json) =>
      TravelRecordModel(
        country: json["country"],
        purpose: json["purpose"],
        duration: json["duration"],
        year: json["year"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "purpose": purpose,
        "duration": duration,
        "year": year,
        "description": description,
      };

  TravelRecordModel copyWith({
    String? country,
    String? purpose,
    String? duration,
    int? year,
    String? description,
  }) {
    return TravelRecordModel(
      country: country ?? this.country,
      purpose: purpose ?? this.purpose,
      duration: duration ?? this.duration,
      year: year ?? this.year,
      description: description ?? this.description,
    );
  }
}
