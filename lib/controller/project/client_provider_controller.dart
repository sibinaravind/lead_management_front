// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/shared/constants.dart';
// import '../../core/services/api_service.dart';
// import '../../model/client/client_model.dart';
//
// class ClientProvider extends ChangeNotifier {
//
//   ClientProvider._privateConstructor();
//   static final _instance = ClientProvider._privateConstructor();
//   factory ClientProvider() {
//     return _instance;
//   }
//
//   final ApiService _apiService = ApiService();
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   List<ClientModel> _clients = [];
//
//   List<ClientModel> get clients => _clients;
//
//
//
//   Future<bool> createClient({
//     required String name,
//     required String email,
//     required String phone,
//     required String alternatePhone,
//     required String address,
//     required String city,
//     required String state,
//     required String country,
//     required BuildContext context,
//   }) async {
//     _isLoading = true;
//     notifyListeners();
//
//     final body = {
//       "name": name,
//       "email": email,
//       "phone": phone,
//       "alternate_phone": alternatePhone,
//       "address": address,
//       "city": city,
//       "state": state,
//       "country": country,
//     };
//
//     try {
//       final response = await _apiService.post(Constant().addClient, body);
//
//       if (response["success"] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Client created successfully")),
//         );
//         return true;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed: ${response["data"]}")),
//         );
//         return false;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//   Future<void> fetchClients() async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await _apiService.get(Constant().clientList);
//
//       if (response['success']) {
//         final List<ClientModel> loadedClients = [];
//
//         for (var item in response['data']) {
//           loadedClients.add(ClientModel.fromJson(item));
//         }
//         _clients = loadedClients;
//       }
//       else {
//         throw Exception("Failed to load clients");
//       }
//     } catch (e) {
//       throw Exception('Error fetching clients: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//
// }


import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../../core/services/api_service.dart';
import '../../model/client/client_model.dart';

class ClientProvider extends ChangeNotifier {
  ClientProvider._privateConstructor();
  static final _instance = ClientProvider._privateConstructor();
  factory ClientProvider() => _instance;

  final ApiService _apiService = ApiService();

  String? _error;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<ClientModel> _clients = [];
  List<ClientModel> _filteredClients = [];

  List<ClientModel> get clients => _filteredClients;


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
        // final newClient = ClientModel.fromJson(response["data"]);
        //
        // _clients.insert(0, newClient);
        // _filteredClients.insert(0, newClient);
        fetchClients();
        notifyListeners();

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

  // Future<bool> createClient({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String alternatePhone,
  //   required String address,
  //   required String city,
  //   required String state,
  //   required String country,
  //   required BuildContext context,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   final body = {
  //     "name": name,
  //     "email": email,
  //     "phone": phone,
  //     "alternate_phone": alternatePhone,
  //     "address": address,
  //     "city": city,
  //     "state": state,
  //     "country": country,
  //   };
  //
  //   try {
  //     final response = await _apiService.post(Constant().addClient, body);
  //
  //     if (response["success"] == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Client created successfully")),
  //       );
  //       return true;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Failed: ${response["data"]}")),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchClients() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.get(Constant().clientList);

      if (response['success']) {
        final List<ClientModel> loadedClients = [];

        for (var item in response['data']) {
          loadedClients.add(ClientModel.fromJson(item));
        }

        _clients = loadedClients;
        _filteredClients = loadedClients; // Initialize filtered list
      } else {
        throw Exception("Failed to load clients");
      }
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> editClient({
    required String clientId, // this is "_id"
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
      final response = await _apiService.patch("${Constant().updateClient}/$clientId", body);

      if (response["success"] == true) {
        fetchClients();

        // final index = _clients.indexWhere((client) => client.id == clientId);
        // if (index != -1) {
        //   final updatedClient = ClientModel(
        //     id: clientId,
        //     clientId: _clients[index].clientId,
        //     name: name,
        //     email: email,
        //     phone: phone,
        //     alternatePhone: alternatePhone,
        //     address: address,
        //     city: city,
        //     state: state,
        //     country: country,
        //     status: _clients[index].status,
        //     createdAt: _clients[index].createdAt,
        //   );
        //
        //   _clients[index] = updatedClient;
        //   _filteredClients[index] = updatedClient;
        //   notifyListeners();
        // }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Client updated successfully")),
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


  void searchClients(String query) {
    if (query.isEmpty) {
      _filteredClients = _clients;
    } else {
      final q = query.toLowerCase();

      _filteredClients = _clients.where((client) {
        return client.name.toLowerCase().contains(q) ||
            client.email.toLowerCase().contains(q) ||
            client.phone.toLowerCase().contains(q) ||
            client.alternatePhone.toLowerCase().contains(q) ||
            client.address.toLowerCase().contains(q) ||
            client.city.toLowerCase().contains(q) ||
            client.state.toLowerCase().contains(q) ||
            client.country.toLowerCase().contains(q) ||
            client.clientId.toLowerCase().contains(q) ||
            client.status.toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }
}
