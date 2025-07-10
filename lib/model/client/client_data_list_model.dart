import 'package:overseas_front_end/model/client/client_data_model.dart';

import '../lead/lead_model.dart';

class ClientDataListModel {
  final List<LeadModel> data;
  final int totalItems;
  final int totalPages;

  ClientDataListModel({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ClientDataListModel.fromMap(Map<String, dynamic> map) {
    return ClientDataListModel(
      data: List<LeadModel>.from(
        (map['data'] ?? []).map((item) => LeadModel.fromJson(item)),
      ),
      totalItems: map['totalItems'] ?? 0,
      totalPages: map['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}
