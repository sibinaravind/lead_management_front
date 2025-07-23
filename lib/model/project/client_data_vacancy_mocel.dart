class VacancyClientDataModel {
  final ClientInfo? clientInfo;
  final String? clientId;
  final Map<String, VacancyDetail>? vacancies;
  final List<CommissionHistory>? commissionHistory;

  VacancyClientDataModel({
    this.clientInfo,
    this.clientId,
    this.vacancies,
    this.commissionHistory,
  });

  factory VacancyClientDataModel.fromJson(Map<String, dynamic> json) {
    return VacancyClientDataModel(
      clientInfo: json['client_info'] != null
          ? ClientInfo.fromJson(json['client_info'])
          : null,
      clientId: json['client_id'],
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

class ClientInfo {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final String? status;

  ClientInfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.status,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    return ClientInfo(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      status: json['status'],
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
