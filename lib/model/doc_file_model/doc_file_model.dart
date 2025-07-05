class DocFileModel {
  final String? fileName;
  final String? fileUrl;

  DocFileModel({this.fileName, this.fileUrl});

  factory DocFileModel.fromJson(Map<String, dynamic> json) => DocFileModel(
        fileName: json["file_name"],
        fileUrl: json["file_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": fileName,
        "base64": fileUrl,
      };
}
