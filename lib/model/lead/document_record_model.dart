import '../../utils/functions/format_date.dart';

class DocumentRecordModel {
  String? docType;
  String? filePath;
  String? uploadedAt;

  DocumentRecordModel({
    this.docType,
    this.filePath,
    this.uploadedAt,
  });

  factory DocumentRecordModel.fromJson(Map<String, dynamic> json) =>
      DocumentRecordModel(
        docType: json["doc_type"],
        filePath: json["file_path"],
        uploadedAt: json["uploaded_at"] == null
            ? null
            : formatDatetoString(json["uploaded_at"]),
      );

  Map<String, dynamic> toJson() => {
        "doc_type": docType,
        "file_path": filePath,
        "uploaded_at": uploadedAt,
      };

  DocumentRecordModel copyWith({
    String? docType,
    String? filePath,
    String? uploadedAt,
  }) {
    return DocumentRecordModel(
      docType: docType ?? this.docType,
      filePath: filePath ?? this.filePath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
