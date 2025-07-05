import '../../core/shared/enums.dart';

class ConfigModel {
  String? name;
  String? code;
  String? country;
  String? province;
  Status? status;
  String colour;

  ConfigModel({
    this.name,
    this.code,
    this.country,
    this.province,
    this.status,
    required this.colour,
  });

  factory ConfigModel.fromMap(Map<String, dynamic> json) => ConfigModel(
        name: json["name"],
        code: json["code"],
        country: json["country"],
        province: json["province"],
        status:
            json["status"] != null ? statusValues.map[json["status"]] : null,
        colour: json["colour"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "country": country,
        "province": province,
        "status": statusValues.reverse[status],
        "colour": colour,
      };
}
