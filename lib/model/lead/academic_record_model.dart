class AcademicRecordModel {
  String? qualification;
  String? institution;
  int? yearOfPassing;
  double? percentage;
  String? board;
  String? description;

  AcademicRecordModel({
    this.qualification,
    this.institution,
    this.yearOfPassing,
    this.percentage,
    this.board,
    this.description,
  });

  factory AcademicRecordModel.fromJson(Map<String, dynamic> json) =>
      AcademicRecordModel(
        qualification: json["qualification"],
        institution: json["institution"],
        yearOfPassing: json["year_of_passing"],
        percentage: json["percentage"],
        board: json["board"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "qualification": qualification,
        "institution": institution,
        "year_of_passing": yearOfPassing,
        "percentage": percentage,
        "board": board,
        "description": description,
      };

  AcademicRecordModel copyWith({
    String? qualification,
    String? institution,
    int? yearOfPassing,
    double? percentage,
    String? board,
    String? description,
  }) {
    return AcademicRecordModel(
      qualification: qualification ?? this.qualification,
      institution: institution ?? this.institution,
      yearOfPassing: yearOfPassing ?? this.yearOfPassing,
      percentage: percentage ?? this.percentage,
      board: board ?? this.board,
      description: description ?? this.description,
    );
  }
}
