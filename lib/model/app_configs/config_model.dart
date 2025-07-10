import '../../core/shared/enums.dart';

class ConfigModel {
  String? id;
  String? name;
  String? code;
  String? country;
  String? province;
  Status? status;
  String? colour;

  ConfigModel({
    this.id,
    this.name,
    this.code,
    this.country,
    this.province,
    this.status,
    this.colour,
  });

  factory ConfigModel.fromMap(Map<String, dynamic> json) => ConfigModel(
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        country: json["country"],
        province: json["province"],
        status: json["status"] != null
            ? json['status'] == "ACTIVE"
                ? Status.ACTIVE
                : Status.INACTIVE
            : Status.INACTIVE,
        colour: json["colour"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "country": country,
        "province": province,
        "status": statusValues.reverse[status],
        "colour": colour,
      };

  bool hasFieldName(String fieldName) {
    const validFields = [
      'id',
      'name',
      'code',
      'country',
      'province',
      'status',
      'colour'
    ];
    return validFields.contains(fieldName);
  }

  bool hasField(String fieldName) {
    return _getFieldValue(fieldName) != null;
  }

  dynamic getFieldValue(String fieldName) {
    return _getFieldValue(fieldName);
  }

  dynamic _getFieldValue(String fieldName) {
    switch (fieldName) {
      case 'id':
        return id;
      case 'name':
        return name;
      case 'code':
        return code;
      case 'country':
        return country;
      case 'province':
        return province;
      case 'status':
        return status;
      case 'colour':
        return colour;
      default:
        return null;
    }
  }
}
