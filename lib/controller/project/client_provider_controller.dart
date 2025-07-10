import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../../core/services/api_service.dart';

class ClientProvider extends ChangeNotifier {
  ClientProvider._privateConstructor();
  static final _instance = ClientProvider._privateConstructor();
  factory ClientProvider() {
    return _instance;
  }
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> createClient({
    required String name,
    required String email,
    required String phone,
    required String alternatePhone,
    required String address,
    required String city,
    required String state,
    required String country,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "alternate_phone": alternatePhone,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
    };

    try {
      final response = await _apiService.post(Constant().addClient, body);

      if (response["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Client created successfully")),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response["data"]}")),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
