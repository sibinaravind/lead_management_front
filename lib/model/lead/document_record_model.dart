class DocumentRecordModel {
  String? docType;
  bool? required;
  String? filePath;
  DateTime? uploadedAt;

  DocumentRecordModel({
    this.docType,
    this.required,
    this.filePath,
    this.uploadedAt,
  });

  factory DocumentRecordModel.fromJson(Map<String, dynamic> json) {
    return DocumentRecordModel(
      docType: json['doc_type'],
      required: json['required'],
      filePath: json['file_path'],
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.tryParse(json['uploaded_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_type': docType,
      'required': required,
      'file_path': filePath,
      'uploaded_at': uploadedAt?.toIso8601String(),
    };
  }
}
