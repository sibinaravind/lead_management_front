import '../officer/officer_model.dart';

class CustomerJourneyData {
  final String id;
  final String type;
  final String clientId;
  final DateTime createdAt;
  final String comment;
  final OfficerModel officer;

  CustomerJourneyData({
    required this.id,
    required this.type,
    required this.clientId,
    required this.createdAt,
    required this.comment,
    required this.officer,
  });

  factory CustomerJourneyData.fromJson(dynamic json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    return CustomerJourneyData(
      id: data['_id'] ?? '',
      type: data['type'] ?? '',
      clientId: data['client_id'] ?? '',
      createdAt: DateTime.parse(
          data['created_at'] ?? DateTime.now().toIso8601String()),
      comment: data['comment'] ?? '',
      officer: OfficerModel.fromJson(data['officer'] ?? {}),
    );
  }
}
