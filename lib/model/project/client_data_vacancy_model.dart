class VacancyClientDataModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? country;
  String? status;
  String? clientId;
  final Map<String, VacancyDetail>? vacancies;
  final List<CommissionHistory>? commissionHistory;

  VacancyClientDataModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.status,
    this.clientId,
    this.vacancies,
    this.commissionHistory,
  });

  factory VacancyClientDataModel.fromJson(Map<String, dynamic> json) {
    return VacancyClientDataModel(
      id: json["client_info"]["_id"],
      name: json["client_info"]["name"],
      email: json["client_info"]["email"],
      phone: json["client_info"]["phone"],
      address: json["client_info"]["address"],
      city: json["client_info"]["city"],
      country: json["client_info"]["country"],
      status: json["client_info"]["status"],
      clientId: json["client_id"],
      vacancies: (json['vacancies'] as Map<String, dynamic>?)?.map(
        (key, value) {
          if (value is Map<String, dynamic>) {
            return MapEntry(key, VacancyDetail.fromJson(value));
          } else if (value is int) {
            // For the case like: "OP": 10
            return MapEntry(key, VacancyDetail(count: value));
          } else {
            return MapEntry(key, VacancyDetail());
          }
        },
      ),
      commissionHistory: (json['commission_history'] as List<dynamic>?)
          ?.map((e) => CommissionHistory.fromJson(e))
          .toList(),
    );
  }
}

class VacancyDetail {
  final int? count;
  final int? targetCv;

  VacancyDetail({
    this.count,
    this.targetCv,
  });

  factory VacancyDetail.fromJson(Map<String, dynamic> json) {
    return VacancyDetail(
      count: json['count'],
      targetCv: json['target_cv'],
    );
  }
}

class CommissionHistory {
  final int? value;
  final DateTime? updatedAt;

  CommissionHistory({
    this.value,
    this.updatedAt,
  });

  factory CommissionHistory.fromJson(Map<String, dynamic> json) {
    return CommissionHistory(
      value: json['value'],
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }
}
