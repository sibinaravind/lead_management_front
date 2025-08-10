class AcademicRecordModel {
  String? qualification;
  String? course;
  String? institution;
  String? university;
  int? startYear;
  int? endYear;
  String? grade;
  double? percentage;

  AcademicRecordModel({
    this.qualification,
    this.course,
    this.institution,
    this.university,
    this.startYear,
    this.endYear,
    this.grade,
    this.percentage,
  });

  factory AcademicRecordModel.fromJson(Map<String, dynamic> json) {
    return AcademicRecordModel(
      qualification: json['qualification'],
      course: json['course'],
      institution: json['institution'],
      university: json['university'],
      startYear: json['start_year'],
      endYear: json['end_year'],
      grade: json['grade'],
      percentage: json['percentage']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qualification': qualification,
      'course': course,
      'institution': institution,
      'university': university,
      'start_year': startYear,
      'end_year': endYear,
      'grade': grade,
      'percentage': percentage,
    };
  }
}
