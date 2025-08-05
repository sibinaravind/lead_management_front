import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/model/lead/lead_list_model.dart';
import 'package:overseas_front_end/model/project/project_model.dart';
import 'package:overseas_front_end/model/project/vacancy_model.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../core/services/api_service.dart';
import '../../model/lead/lead_model.dart';
import '../../model/project/client_data_vacancy_model.dart'
    show VacancyClientDataModel;
import '../../model/project/client_model.dart';
import '../../utils/style/colors/colors.dart';
import '../../view/widgets/custom_snackbar.dart';

class ProjectController extends GetxController {
  final ApiService _apiService = ApiService();

  RxString itemsPerPage = "10".obs;
  RxInt currentPage = 0.obs;
  RxString? error;
  RxBool isLoading = false.obs;
  RxString? responseId;

  RxList<ClientModel> clients = <ClientModel>[].obs;
  RxList<ClientModel> filteredClients = <ClientModel>[].obs;
  RxList<ProjectModel> projects = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;

  RxList<VacancyClientDataModel> vacanciesClientList =
      <VacancyClientDataModel>[].obs;
  RxList<VacancyModel> vacancies = <VacancyModel>[].obs;

  RxList<VacancyModel> filteredVacancies = <VacancyModel>[].obs;

  Rx<LeadListModel> customerMatchingList = LeadListModel().obs;

  RxList<LeadModel> favouriteClients = <LeadModel>[].obs;

  Map<String, dynamic> filter = {};
  String? selectedVacancyId;

  Future<void> fetchClients() async {
    if (clients.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().clientList,
          fromJson: (json) =>
              List<ClientModel>.from(json.map((e) => ClientModel.fromJson(e))));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          clients.value = loadedClients;
          filteredClients.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createClient({
    required ClientModel client,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    final body = client.toJson()
      ..remove('_id')
      ..remove('created_at');

    try {
      var response = await _apiService.postRequest(
          endpoint: Constant().addClient, body: body, fromJson: (json) => json);
      response.fold(
        (failure) {
          CustomToast.showToast(
              context: context,
              message: failure != null
                  ? failure.toString()
                  : "Failed to create client");
          return false;
        },
        (data) {
          client.sId = data;
          clients.insert(clients.length, client);
          filteredClients.insert(filteredClients.length, client);
          CustomToast.showToast(
              context: context, message: 'Client created successfully');
          Navigator.of(context).pop();
          return true;
        },
      );
      return true;
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editClient({
    required ClientModel client,
    required String clientId,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      var response = await _apiService.patchRequest(
          endpoint: "${Constant().updateClient}/$clientId",
          body: client.toJson()
            ..remove('_id')
            ..remove('created_at'),
          fromJson: (json) => json);
      response.fold(
        (failure) {
          CustomToast.showToast(
              context: context, message: "Failed to update client");
          return false;
        },
        (data) {
          final index = clients.indexWhere((c) => c.sId == clientId);
          if (index != -1) {
            clients[index] = client;
            filteredClients[index] = client;
          }
          CustomToast.showToast(
              context: context, message: 'Client updated successfully');
          Navigator.of(context).pop();
          return true;
        },
      );
      return true;
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteClient(BuildContext context, String clientId) async {
    isLoading.value = true;
    try {
      final response = await _apiService.deleteRequest(
          endpoint: "${Constant().deleteClient}/$clientId",
          body: {},
          fromJson: (json) => json);

      response.fold((failure) {
        error?.value = 'Failed to delete client:';
        CustomSnackBar.showMessage(
          "Error",
          "Failed to delete client",
          backgroundColor: AppColors.redSecondaryColor,
        );
      }, (response) {
        //   if (response['success'] == true) {
        clients.removeWhere((element) => element.sId == clientId);
        filteredClients = clients;
        filteredClients.refresh();
        CustomToast.showToast(
            context: context, message: "deleted successfully");
        return true;
        // }
      });
    } catch (ex) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void searchClients(String query) {
    if (query.isEmpty) {
      filteredClients.value = clients;
    } else {
      final q = query.toLowerCase();

      filteredClients.value = clients.where((client) {
        return (client.name?.toLowerCase().contains(q) ?? false) ||
            (client.email?.toLowerCase().contains(q) ?? false) ||
            (client.phone?.toLowerCase().contains(q) ?? false) ||
            (client.alternatePhone?.toLowerCase().contains(q) ?? false) ||
            (client.address?.toLowerCase().contains(q) ?? false) ||
            (client.city?.toLowerCase().contains(q) ?? false) ||
            (client.state?.toLowerCase().contains(q) ?? false) ||
            (client.country?.toLowerCase().contains(q) ?? false) ||
            (client.status?.toLowerCase().contains(q) ?? false);
      }).toList();
    }
  }

  Future<void> fetchProjects() async {
    // Only load if there are projects returned
    if (projects.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
        endpoint: Constant().projectList,
        fromJson: (json) =>
            List<ProjectModel>.from(json.map((e) => ProjectModel.fromJson(e))),
      );

      response.fold(
        (failure) {
          throw Exception("Failed to load projects");
        },
        (loadedProjects) {
          projects.value = loadedProjects;
          filteredProjects.value = loadedProjects;
        },
      );
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Create a new project
  Future<bool> createProject({
    required ProjectModel project,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    final body = project.toJson()
      ..remove('_id')
      ..remove('created_at');

    try {
      var response = await _apiService.postRequest(
        endpoint: Constant().addProject,
        body: body,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: failure != null
                ? failure.toString()
                : "Failed to create project",
          );
          return false;
        },
        (data) {
          project.sId = data;
          projects.insert(projects.length, project);
          filteredProjects.insert(filteredProjects.length, project);
          CustomToast.showToast(
            context: context,
            message: 'Project created successfully',
          );
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Edit an existing project
  Future<bool> editProject({
    required ProjectModel project,
    required String projectId,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      var response = await _apiService.patchRequest(
        endpoint: "${Constant().editProject}/$projectId",
        body: project.toJson()
          ..remove('_id')
          ..remove('created_at'),
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: "Failed to update project",
          );
          return false;
        },
        (data) {
          final index = projects.indexWhere((p) => p.sId == projectId);
          if (index != -1) {
            projects[index] = project;
            filteredProjects[index] = project;
          }
          CustomToast.showToast(
            context: context,
            message: 'Project updated successfully',
          );
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Delete a project
  Future<bool> deleteProject(BuildContext context, String projectId) async {
    isLoading.value = true;
    try {
      final response = await _apiService.deleteRequest(
        endpoint: "${Constant().deleteProject}/$projectId",
        body: {},
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error?.value = 'Failed to delete project:';
          CustomSnackBar.showMessage(
            "Error",
            "Failed to delete project",
            backgroundColor: AppColors.redSecondaryColor,
          );
          return false;
        },
        (response) {
          projects.removeWhere((element) => element.sId == projectId);
          filteredProjects.value = projects;
          filteredProjects.refresh();
          CustomToast.showToast(
            context: context,
            message: "Project deleted successfully",
          );
          return true;
        },
      );
    } catch (ex) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Search projects
  void searchProjects({String? filter, String? query}) {
    final q = query?.toLowerCase() ?? '';
    final f = filter?.toLowerCase() ?? '';

    if (q.isEmpty && f.isEmpty) {
      // If both search and filter are empty/null, show all projects
      filteredProjects.value = projects;
      return;
    }

    filteredProjects.value = projects.where((project) {
      bool matchesQuery = q.isEmpty
          ? true
          : (project.projectName?.toLowerCase().contains(q) ?? false) ||
              (project.organizationCategory?.toLowerCase().contains(q) ??
                  false) ||
              (project.organizationType?.toLowerCase().contains(q) ?? false);

      bool matchesFilter = f.isEmpty
          ? true
          : (project.organizationType?.toLowerCase().contains(f) ?? false) ||
              (project.status?.toLowerCase().contains(f) ?? false);

      return matchesQuery && matchesFilter;
    }).toList();
  }

// Fetch all vacancies
  Future<void> fetchVacancies() async {
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
        endpoint: Constant().vacancyList,
        fromJson: (json) =>
            List<VacancyModel>.from(json.map((e) => VacancyModel.fromJson(e))),
      );
      response.fold(
        (failure) {
          throw Exception("Failed to load vacancies");
        },
        (loadedVacancies) {
          vacancies.value = loadedVacancies;
          filteredVacancies.value = loadedVacancies;
          filteredVacancies.refresh();
        },
      );
      isLoading.value = false;
    } catch (e) {
      throw Exception('Error fetching vacancies: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Create a new vacancy
  Future<bool> createVacancy({
    required Map<String, dynamic> vacancy,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    final body = vacancy
      ..remove('_id')
      ..remove('created_at');

    try {
      var response = await _apiService.postRequest(
        endpoint: Constant().createVacancy,
        body: body,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: failure != null
                ? failure.toString()
                : "Failed to create vacancy",
          );
          return false;
        },
        (data) async {
          // vacancy.id = data;
          // vacancies.insert(vacancies.length, VacancyModel(
          //   id: data,
          //   jobTitle: vacancy['job_title'],
          //   projectId: vacancy['project_id'],
          //   status: vacancy['status'],
          //   description: vacancy['description'],
          //   jobCategory: vacancy['job_category'],
          //   qualifications: List<String>.from(vacancy['qualifications'] ?? []),
          //   lastDateToApply: vacancy['last_date_to_apply'],
          // ));
          // filteredVacancies.insert(filteredVacancies.length, vacancy);
          // CustomToast.showToast(
          //   context: context,
          //   message: 'Vacancy created successfully',
          // );
          // Navigator.of(context).pop();
          await fetchVacancies();
          return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Edit an existing vacancy
  Future<bool> editVacancy({
    required Map<String, dynamic> vacancy,
    required String vacancyId,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      var response = await _apiService.patchRequest(
        endpoint: "${Constant().editVacancy}/$vacancyId",
        body: vacancy,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          CustomToast.showToast(
            context: context,
            message: "Failed to update vacancy",
          );
          return false;
        },
        (data) async {
          final index = vacancies.indexWhere((v) => v.id == vacancyId);
          VacancyModel editedVacnacy = vacancies[index];
          // editedVacnacy.jobTitle = vacancy['job_title'];

          editedVacnacy.jobCategory = vacancy['job_category'];

          editedVacnacy.status = vacancy['status'];
          editedVacnacy.qualifications =
              List<String>.from(vacancy['qualifications'] ?? []);
          editedVacnacy.lastDateToApply = vacancy['lastdatetoapply'];
          editedVacnacy.description = vacancy['description'];
          editedVacnacy.salaryFrom = vacancy['salary_from'];
          editedVacnacy.salaryTo = vacancy['salary_to'];
          editedVacnacy.country = vacancy['country'];
          editedVacnacy.city = vacancy['city'];
          editedVacnacy.skills = vacancy['skills'];
          if (index != -1) {
            vacancies[index] = editedVacnacy;
            filteredVacancies[index] = editedVacnacy;
          }
          // CustomToast.showToast(
          //   context: context,
          //   message: 'Vacancy updated successfully',
          // );
          // Navigator.of(context).pop();
          return true;
          // await fetchVacancies();
          // Navigator.of(context).pop();
          // CustomToast.showToast(
          //   context: context,
          //   message: 'Vacancy updated successfully',
          // );
          // return true;
        },
      );
    } catch (e) {
      CustomToast.showToast(context: context, message: "Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Delete a vacancy
  Future<bool> deleteVacancy(BuildContext context, String vacancyId) async {
    isLoading.value = true;
    try {
      final response = await _apiService.deleteRequest(
        endpoint: "${Constant().deleteVacancy}/$vacancyId",
        body: {},
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error?.value = 'Failed to delete vacancy:';
          CustomSnackBar.showMessage(
            "Error",
            "Failed to delete vacancy",
            backgroundColor: AppColors.redSecondaryColor,
          );
          return false;
        },
        (response) {
          vacancies.removeWhere((element) => element.id == vacancyId);
          filteredVacancies.value = vacancies;
          filteredVacancies.refresh();
          CustomToast.showToast(
            context: context,
            message: "Vacancy deleted successfully",
          );
          return true;
        },
      );
    } catch (ex) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Search vacancies
  void searchVacancies(String query) {
    if (query.isEmpty) {
      filteredVacancies.value = vacancies;
    } else {
      final q = query.toLowerCase();

      filteredVacancies.value = vacancies.where((vacancy) {
        return (vacancy.jobCategory?.toLowerCase().contains(q) ?? false) ||
            (vacancy.qualifications
                    ?.any((element) => element.toLowerCase().contains(q)) ??
                false) ||
            (vacancy.project?.country?.toLowerCase().contains(q) ?? false) ||
            (vacancy.project?.projectName?.toLowerCase().contains(q) ??
                false) ||
            (vacancy.status?.toLowerCase().contains(q) ?? false) ||
            (vacancy.description?.toLowerCase().contains(q) ?? false);
      }).toList();
    }
  }

  // Fetch clients for a specific vacancy
  Future<bool> fetchVacancyClient(String id) async {
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
        endpoint: '${Constant().vacancyClientList}/$id',
        fromJson: (json) => List<VacancyClientDataModel>.from(
          json.map((e) => VacancyClientDataModel.fromJson(e)),
        ),
      );
      return response.fold(
        (failure) => false,
        (data) {
          vacanciesClientList.value = data;
          vacanciesClientList.refresh();
          return true;
        },
      );
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Remove a client from a vacancy
  Future<bool> removeClientFromVacancy(
      String vacancyId, String clientId) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> data = {
        "vacancyId": vacancyId,
        "clientId": clientId,
      };
      final response = await _apiService.deleteRequest(
        endpoint: Constant().removeClientFromVacancy,
        body: data,
        fromJson: (json) => json,
      );
      return response.fold(
        (failure) => false,
        (data) => true,
      );
    } catch (ex) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMatchingClients(
      {Map<String, dynamic>? filterSelected}) async {
    filter = filterSelected ?? {};
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().getMatchingProfiles,
          params: filter,
          fromJson: (json) => LeadListModel.fromJson(json));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          customerMatchingList.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToShortList(String clientId) async {
    if (clients.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.postRequest(
          endpoint: Constant().addClientToFavourites,
          fromJson: (json) => json,
          body: {"clientId": clientId, "vacancyId": selectedVacancyId});
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          fetchMatchingClients(
            filterSelected: filter,
          );
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromShortList(String clientId) async {
    if (clients.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.patchRequest(
          endpoint: Constant().removeClientFromFavourites,
          fromJson: (json) => json,
          body: {"clientId": clientId, "vacancyId": selectedVacancyId});
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          fetchShortListed();
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchShortListed() async {
    if (clients.isNotEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
          endpoint: '${Constant().getFavouriteClients}$selectedVacancyId',
          fromJson: (json) => List<LeadModel>.from(
                json.map((e) => LeadModel.fromJson(e)),
              ));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          favouriteClients.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
