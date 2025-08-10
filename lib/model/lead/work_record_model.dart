class WorkRecordModel {
  String? position;
  String? department;
  String? organization;
  String? country;
  DateTime? fromDate;
  DateTime? toDate;

  WorkRecordModel({
    this.position,
    this.department,
    this.organization,
    this.country,
    this.fromDate,
    this.toDate,
  });

  factory WorkRecordModel.fromJson(Map<String, dynamic> json) {
    return WorkRecordModel(
      position: json['position'],
      department: json['department'],
      organization: json['organization'],
      country: json['country'],
      fromDate: json['from_date'] != null
          ? DateTime.tryParse(json['from_date'])
          : null,
      toDate:
          json['to_date'] != null ? DateTime.tryParse(json['to_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'department': department,
      'organization': organization,
      'country': country,
      'from_date': fromDate?.toIso8601String(),
      'to_date': toDate?.toIso8601String(),
    };
  }
}
