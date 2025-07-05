import 'package:overseas_front_end/model/client/client_data_model.dart';

class ClientDataListModel {
  final List<ClientDataModel> data;
  final int totalItems;
  final int totalPages;

  ClientDataListModel({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ClientDataListModel.fromMap(Map<String, dynamic> map) {
    return ClientDataListModel(
      data: List<ClientDataModel>.from(
        (map['data'] ?? []).map((item) => ClientDataModel.fromMap(item)),
      ),
      totalItems: map['totalItems'] ?? 0,
      totalPages: map['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((item) => item.toMap()).toList(),
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}

