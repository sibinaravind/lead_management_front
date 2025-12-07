import '../../utils/functions/format_date.dart';

class ExamRecordModel {
  String? examName;
  double? score;
  String? testDate;
  String? validity;
  String? description;

  ExamRecordModel({
    this.examName,
    this.score,
    this.testDate,
    this.validity,
    this.description,
  });

  factory ExamRecordModel.fromJson(Map<String, dynamic> json) =>
      ExamRecordModel(
        examName: json["exam_name"],
        score: json["score"]?.toDouble(),
        testDate: json["test_date"] == null
            ? null
            : formatDatetoString(json["test_date"]),
        validity: json["validity"] == null
            ? null
            : formatDatetoString(json["validity"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "exam_name": examName,
        "score": score,
        "test_date": testDate != null ? formatDateToYYYYMMDD(testDate) : null,
        "validity": validity != null ? formatDateToYYYYMMDD(validity) : null,
        "description": description,
      };

  ExamRecordModel copyWith({
    String? examName,
    double? score,
    String? testDate,
    String? validity,
    String? description,
  }) {
    return ExamRecordModel(
      examName: examName ?? this.examName,
      score: score ?? this.score,
      testDate: testDate ?? this.testDate,
      validity: validity ?? this.validity,
      description: description ?? this.description,
    );
  }
}
