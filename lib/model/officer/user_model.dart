import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? sub;
  final String? givenName;
  final String? familyName;
  final String? email;
  final String? branch;
  final int? branchId;
  final int? officerId;

  const UserModel({
    this.sub,
    this.givenName,
    this.familyName,
    this.email,
    this.branch,
    this.branchId,
    this.officerId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      sub: json['sub'] as String?,
      givenName: json['givenName'] as String?,
      familyName: json['familyName'] as String?,
      email: json['email'] as String?,
      branch: json['branch'] as String?,
      branchId: json['branchId'] as int?,
      officerId: json['officerId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub': sub,
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'branch': branch,
      'branchId': branchId,
      'officerId': officerId,
    };
  }

  @override
  List<Object?> get props => [
        sub,
        givenName,
        familyName,
        email,
        branch,
        branchId,
        officerId,
      ];

  @override
  bool? get stringify => true;
}
