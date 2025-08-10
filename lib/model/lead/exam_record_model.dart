import 'package:overseas_front_end/utils/functions/format_date.dart';

class ExamRecordModel {
  String? exam;
  String? status;
  DateTime? validityDate;
  DateTime? examDate;
  String? grade;
  int? score;

  ExamRecordModel({
    this.exam,
    this.status,
    this.validityDate,
    this.examDate,
    this.grade,
    this.score,
  });

  factory ExamRecordModel.fromJson(Map<String, dynamic> json) {
    return ExamRecordModel(
      exam: json['exam'],
      status: json['status'],
      validityDate: json['validity_date'] != null
          ? DateTime.tryParse(json['validity_date'])
          : null,
      examDate: json['exam_date'] != null
          ? DateTime.tryParse(json['exam_date'])
          : null,
      grade: json['grade'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam': exam,
      'status': status,
      'validity_date': formatDatetoString(validityDate),
      'exam_date': formatDatetoString(examDate),
      'grade': grade,
      'score': score,
    };
  }
}
