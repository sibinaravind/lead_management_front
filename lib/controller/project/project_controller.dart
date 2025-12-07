import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../core/services/api_service.dart';
import '../../model/project/project_model.dart';
import '../../utils/style/colors/colors.dart';
import '../../view/widgets/custom_snackbar.dart';

class ProjectController extends GetxController {
  final ApiService _apiService = ApiService();
  RxString itemsPerPage = "10".obs;
  RxInt currentPage = 0.obs;
  RxString? error;
  RxBool isLoading = false.obs;
  RxString? responseId;

  RxList<ProjectModel> projects = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;

  Map<String, dynamic> filter = {};
  String? selectedVacancyId;

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
}
