import '../../utils/functions/format_date.dart';

class WorkRecordModel {
  String? company;
  String? position;
  String? startDate;
  String? endDate;
  String? description;

  WorkRecordModel({
    this.company,
    this.position,
    this.startDate,
    this.endDate,
    this.description,
  });

  factory WorkRecordModel.fromJson(Map<String, dynamic> json) =>
      WorkRecordModel(
        company: json["company"],
        position: json["position"],
        startDate: json["start_date"] == null
            ? null
            : formatDatetoString(json["start_date"]),
        endDate: json["end_date"] == null
            ? null
            : formatDatetoString(json["end_date"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "position": position,
        "start_date": formatDateToYYYYMMDD(startDate),
        "end_date": formatDateToYYYYMMDD(endDate),
        "description": description,
      };

  WorkRecordModel copyWith({
    String? company,
    String? position,
    String? startDate,
    String? endDate,
    String? description,
  }) {
    return WorkRecordModel(
      company: company ?? this.company,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
    );
  }
}
