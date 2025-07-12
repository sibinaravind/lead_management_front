import 'package:overseas_front_end/model/lead/round_robin.dart';

class RoundRobinGroup {
  final String id;
  final String name;
  final String country;
  final List<RoundRobinOfficerModel> officerDetails;

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
          ?.map((e) => RoundRobinOfficerModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
