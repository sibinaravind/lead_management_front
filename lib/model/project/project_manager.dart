import 'project_model.dart';

class ProjectManager {
  List<ProjectModel>? organizationTypeProjects;
  List<ProjectModel>? organizationCategoryProjects;
  List<ProjectModel>? countryProjects;
  List<ProjectModel>? cityProjects;
  List<ProjectModel>? statusProjects;
  List<ProjectModel>? allProjects;

  /// Insert items into a specific category list
  void insertItemList(String category, List<ProjectModel> items) {
    List<ProjectModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    for (final item in items) {
      // Prevent duplicates (by ID)
      if (!targetList.any((project) => project.sId == item.sId)) {
        targetList.add(item);
      }
    }
  }

  /// Insert a single item into a specific category list
  void insertItem(String category, ProjectModel item) {
    insertItemList(category, [item]);
  }

  /// Remove an item from a specific category list
  void removeItem(String category, String projectId) {
    List<ProjectModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    targetList.removeWhere((project) => project.sId == projectId);
  }

  /// Get items from a specific category list
  List<ProjectModel>? getItemsByCategory(String category) {
    return _getListByCategory(category);
  }

  /// Clear all items from a specific category list
  void clearCategory(String category) {
    List<ProjectModel>? targetList = _getListByCategory(category);
    targetList?.clear();
  }

  /// Get projects filtered by a specific field value
  List<ProjectModel> getProjectsByField(String fieldName, String fieldValue) {
    List<ProjectModel> filteredProjects = [];

    // Search in all relevant lists
    final allLists = [
      allProjects,
      organizationTypeProjects,
      organizationCategoryProjects,
      countryProjects,
      cityProjects,
      statusProjects,
    ];

    for (final list in allLists) {
      if (list != null) {
        filteredProjects.addAll(list.where((project) =>
            _getProjectFieldValue(project, fieldName) == fieldValue));
      }
    }

    // Remove duplicates based on project ID
    final uniqueProjects = <String, ProjectModel>{};
    for (final project in filteredProjects) {
      if (project.sId != null) {
        uniqueProjects[project.sId!] = project;
      }
    }

    return uniqueProjects.values.toList();
  }

  /// Helper to get the list based on category
  List<ProjectModel>? _getListByCategory(String category) {
    switch (category) {
      case 'organization_type':
        return organizationTypeProjects ??= [];
      case 'organization_category':
        return organizationCategoryProjects ??= [];
      case 'country':
        return countryProjects ??= [];
      case 'city':
        return cityProjects ??= [];
      case 'status':
        return statusProjects ??= [];
      case 'all':
        return allProjects ??= [];
      default:
        throw ArgumentError('Unknown category: $category');
    }
  }

  /// Helper to get field value from project based on field name
  String? _getProjectFieldValue(ProjectModel project, String fieldName) {
    switch (fieldName) {
      case 'organization_type':
        return project.organizationType;
      case 'organization_category':
        return project.organizationCategory;
      // case 'organization_name':
      //   return project.o;
      case 'country':
        return project.country;
      case 'city':
        return project.city;
      case 'status':
        return project.status;
      case 'project_name':
        return project.projectName;
      default:
        return null;
    }
  }
}
