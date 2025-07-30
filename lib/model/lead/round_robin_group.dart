import 'package:overseas_front_end/model/officer/officer_model.dart';

class RoundRobinGroup {
  final String id;
  final String name;
  final String country;
  final List<OfficerModel> officerDetails;

  RoundRobinGroup({
    required this.id,
    required this.name,
    required this.country,
    required this.officerDetails,
  });

  factory RoundRobinGroup.fromJson(Map<String, dynamic> json) {
    return RoundRobinGroup(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      officerDetails: (json['officer_details'] as List<dynamic>?)
              ?.map((e) => OfficerModel.fromJson(e))
              .toList() ??
          [],
    );
  }
  RoundRobinGroup copyWith({
    String? id,
    String? name,
    String? country,
    List<OfficerModel>? officerDetails,
  }) {
    return RoundRobinGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      officerDetails: officerDetails ?? this.officerDetails,
    );
  }
}
