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
import 'package:overseas_front_end/core/services/login_cache_service.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/model/lead/call_event_model.dart';
import 'package:overseas_front_end/model/project/project_manager.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/model/project/vacancy_model.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../core/services/api_service.dart';
import '../../model/client/client_model.dart';

class ProjectProvider extends ChangeNotifier {
  ProjectProvider._privateConstructor();
  static final _instance = ProjectProvider._privateConstructor();
  factory ProjectProvider() => _instance;

  final ApiService _apiService = ApiService();
  String itemsPerPage = "10";
  int currentPage = 0;
  String? _error;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? responseId;

  List<ClientModel> _clients = [];
  List<ClientModel> filteredClients = [];
  List<ProjectModel> projects = [];
  List<ProjectModel> filterProjects = [];
  List<VacancyModel> vacancies = [];

  List<ClientModel> get clients => _clients;

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
      final response =
          await _apiService.post(context: context, Constant().addClient, body);

      if (response["success"] == true) {
        // final newClient = ClientModel.fromJson(response["data"]);
        //
        // _clients.insert(0, newClient);
        // _filteredClients.insert(0, newClient);
        fetchClients(
          context,
        );
        notifyListeners();
        CustomToast.showToast(
            context: context, message: 'Client created successfully');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Client created successfully")),
        // );
        return true;
      } else {
        CustomToast.showToast(
            context: context, message: "Failed: ${response["data"]}");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Failed: ${response["data"]}")),
        // );
        return false;
      }
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Error: $e")),
      // );
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

  Future<void> createVacancy(context, Map<String, dynamic> vacancyData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(
        context: context,
        Constant().createVacancy,
        vacancyData,
      );

      if (response.data['data'] != null && response.data['success'] == true) {
        fetchVacancies(
          context,
        );
        print('Vacancy created successfully');
        responseId = response.data['data']['_id'];
      } else {
        responseId = null;
      }
    } catch (e) {
      print('Error creating vacancy: $e');
      responseId = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> editVacancy(
      context, String vacancyId, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.patch(
        context: context,
        '${Constant().editVacancy}/$vacancyId',
        updatedData,
      );

      if (response.data['success'] == true) {
        fetchVacancies(
          context,
        );
        print('Vacancy updated successfully');
      } else {
        print('Failed to update vacancy');
      }
    } catch (e) {
      print('Error editing vacancy: $e');
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<void> deleteVacancy(context, String vacancyId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.delete(
          context: context, '${Constant().deleteVacancy}/$vacancyId', {});

      if (response.data['success'] == true) {
        print('Vacancy deleted successfully');
        vacancies.removeWhere((vacancy) => vacancy.sId == vacancyId);
      } else {
        print('Failed to delete vacancy');
      }
    } catch (e) {
      print('Error deleting vacancy: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProjects(
    context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _apiService.get(context: context, Constant().projectList);

      if (response['success']) {
        projects =
            List.from(response['data'].map((e) => ProjectModel.fromJson(e)));
        filterProjects = projects;
      } else {
        throw Exception("Failed to load projects");
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchVacancies(
    context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _apiService.get(context: context, Constant().vacancyList);

      if (response['success']) {
        vacancies =
            List.from(response['data'].map((e) => VacancyModel.fromJson(e)));
      } else {
        throw Exception("Failed to load Vacancies");
      }
    } catch (e) {
      throw Exception('Error fetching Vacancies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addProject(
    context, {
    required String projectName,
    required String organizationType,
    required String organizationCategory,
    required String organizationName,
    required String city,
    required String country,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await _apiService.post(context: context, Constant().addProject, {
        "project_name": projectName,
        "organization_type": organizationType,
        "organization_category": organizationCategory,
        "organization_name": organizationName,
        "city": city,
        "country": country,
      });
      projects.add(ProjectModel(
          city: city,
          country: country,
          organizationType: organizationType,
          organizationCategory: organizationCategory,
          projectName: projectName,
          organizationName: organizationName,
          createdAt: DateTime.now().toString(),
          status: "ACTIVE"));

      // fetchProjects();
      // _campaignModel = CampaignModel.fromJson(response.data);

      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      _isLoading = false;
      // fetchProjects();
      notifyListeners();
    }
  }

  Future<bool> editProject(
    context, {
    required String projectId,
    required String projectName,
    required String organizationType,
    required String organizationCategory,
    required String organizationName,
    required String city,
    required String country,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService
          .patch(context: context, '${Constant().editProject}/$projectId', {
        "project_name": projectName,
        "organization_type": organizationType,
        "organization_category": organizationCategory,
        "organization_name": organizationName,
        "city": city,
        "country": country,
      });
      projects.removeWhere((element) => element.sId == projectId);
      projects.add(ProjectModel(
          city: city,
          country: country,
          organizationCategory: organizationCategory,
          organizationName: organizationName,
          organizationType: organizationType,
          projectName: projectName));
      // fetchProjects();
      // _campaignModel = CampaignModel.fromJson(response.data);

      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      _isLoading = false;
      // fetchProjects();
      notifyListeners();
    }
  }

  Future<void> fetchClients(
    context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _apiService.get(context: context, Constant().clientList);

      if (response['success']) {
        final List<ClientModel> loadedClients = [];

        for (var item in response['data']) {
          loadedClients.add(ClientModel.fromJson(item));
        }

        _clients = loadedClients;
        filteredClients = loadedClients; // Initialize filtered list
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

  Future deleteProject(String projectId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.delete(
          context: context, "${Constant().deleteProject}/$projectId", {});
      if (response["success"] == true) {
        projects.removeWhere((element) => element.sId == projectId);
        // fetchProjects();
        notifyListeners();
        CustomToast.showToast(
            context: context, message: "deleted successfully");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("deleted successfully")),
        // );
        return true;
      } else {
        CustomToast.showToast(context: context, message: 'Deletion failed');

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Deletion failed')),
        // );
        return false;
      }
    } catch (ex) {
      throw Exception(ex);
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
      final response = await _apiService.patch(
          context: context, "${Constant().updateClient}/$clientId", body);

      if (response["success"] == true) {
        fetchClients(
          context,
        );

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

        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("Client updated successfully")),
        // );
        CustomToast.showToast(
            context: context, message: 'Client updated successfully');
        return true;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Failed: ${response["data"]}")),
        // );
        CustomToast.showToast(
            context: context, message: "Failed: ${response["data"]}");
        return false;
      }
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Error: $e")),
      // );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProjects(String query) {
    if (query.isEmpty) {
      filterProjects = projects;
    } else {
      final q = query.toLowerCase();

      filterProjects = projects.where((project) {
        return (project.projectName?.toLowerCase().contains(q) ?? false) ||
            (project.organizationName?.toLowerCase().contains(q) ?? false) ||
            (project.organizationType?.toLowerCase().contains(q) ?? false) ||
            (project.organizationCategory?.toLowerCase().contains(q) ??
                false) ||
            (project.city?.toLowerCase().contains(q) ?? false) ||
            (project.country?.toLowerCase().contains(q) ?? false);
      }).toList();
    }
    notifyListeners();
  }

  void searchClients(String query) {
    if (query.isEmpty) {
      filteredClients = _clients;
    } else {
      final q = query.toLowerCase();

      filteredClients = _clients.where((client) {
        return (client.name?.toLowerCase().contains(q) ?? false) ||
            (client.email?.toLowerCase().contains(q) ?? false) ||
            (client.phone?.toLowerCase().contains(q) ?? false) ||
            (client.alternatePhone?.toLowerCase().contains(q) ?? false) ||
            (client.address?.toLowerCase().contains(q) ?? false) ||
            (client.city?.toLowerCase().contains(q) ?? false) ||
            (client.state?.toLowerCase().contains(q) ?? false) ||
            (client.country?.toLowerCase().contains(q) ?? false) ||
            // (client.clientId?.toLowerCase().contains(q) ?? false) ||
            (client.status?.toLowerCase().contains(q) ?? false);
      }).toList();
    }

    notifyListeners();
  }
}
