// import 'dart:convert';
//
// AccessPermission accessPermissionFromJson(String str) => AccessPermission.fromJson(json.decode(str));
//
// String accessPermissionToJson(AccessPermission data) => json.encode(data.toJson());
//
// class AccessPermission {
//   bool success;
//   Data data;
//
//   AccessPermission({
//     required this.success,
//     required this.data,
//   });
//
//   factory AccessPermission.fromJson(Map<String, dynamic> json) => AccessPermission(
//     success: json["success"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   String id;
//   String name;
//   Map<String, bool> admin;
//   Map<String, bool> counselor;
//   Map<String, bool> manager;
//   Map<String, bool> frontDesk;
//   Map<String, bool> documentation;
//   Map<String, bool> visa;
//
//   Data({
//     required this.id,
//     required this.name,
//     required this.admin,
//     required this.counselor,
//     required this.manager,
//     required this.frontDesk,
//     required this.documentation,
//     required this.visa,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["_id"],
//     name: json["name"],
//     admin: Map.from(json["admin"]).map((k, v) => MapEntry<String, bool>(k, v)),
//     counselor: Map.from(json["counselor"]).map((k, v) => MapEntry<String, bool>(k, v)),
//     manager: Map.from(json["manager"]).map((k, v) => MapEntry<String, bool>(k, v)),
//     frontDesk: Map.from(json["front_desk"]).map((k, v) => MapEntry<String, bool>(k, v)),
//     documentation: Map.from(json["documentation"]).map((k, v) => MapEntry<String, bool>(k, v)),
//     visa: Map.from(json["visa"]).map((k, v) => MapEntry<String, bool>(k, v)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "admin": Map.from(admin).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "counselor": Map.from(counselor).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "manager": Map.from(manager).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "front_desk": Map.from(frontDesk).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "documentation": Map.from(documentation).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "visa": Map.from(visa).map((k, v) => MapEntry<String, dynamic>(k, v)),
//   };
// }



class EmployeePermissionModel {
  String? id;
  String? name;
  Map<String, bool>? admin;
  Map<String, bool>? counselor;
  Map<String, bool>? manager;
  Map<String, bool>? frontDesk;
  Map<String, bool>? documentation;
  Map<String, bool>? visa;

  EmployeePermissionModel({
    this.id,
    this.name,
    this.admin,
    this.counselor,
    this.manager,
    this.frontDesk,
    this.documentation,
    this.visa,
  });

  factory EmployeePermissionModel.fromJson(Map<String, dynamic> json) =>
      EmployeePermissionModel(
        id: json["_id"],
        name: json["name"],
        admin: Map<String, bool>.from(json["admin"]),
        counselor: Map<String, bool>.from(json["counselor"]),
        manager: Map<String, bool>.from(json["manager"]),
        frontDesk: Map<String, bool>.from(json["front_desk"]),
        documentation: Map<String, bool>.from(json["documentation"]),
        visa: Map<String, bool>.from(json["visa"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "admin": admin,
    "counselor": counselor,
    "manager": manager,
    "front_desk": frontDesk,
    "documentation": documentation,
    "visa": visa,
  };
}
