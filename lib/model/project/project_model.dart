class ProjectModel {
  String? sId;
  String? projectName;
  String? organizationType;
  String? organizationCategory;
  String? organizationName;
  String? country;
  String? city;
  String? status;
  String? createdAt;

  ProjectModel({
    this.sId,
    this.projectName,
    this.organizationType,
    this.organizationCategory,
    this.organizationName,
    this.country,
    this.city,
    this.status,
    this.createdAt,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['project_name'];
    organizationType = json['organization_type'];
    organizationCategory = json['organization_category'];
    organizationName = json['organization_name'];
    country = json['country'];
    city = json['city'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['project_name'] = projectName;
    data['organization_type'] = organizationType;
    data['organization_category'] = organizationCategory;
    data['organization_name'] = organizationName;
    data['country'] = country;
    data['city'] = city;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }

  // Helper method to add a project to a list
  static void addProject(List<ProjectModel> projects, ProjectModel project) {
    projects.add(project);
  }

  // Helper method to add a project at specific index
  static void insertProject(
      List<ProjectModel> projects, int index, ProjectModel project) {
    if (index >= 0 && index <= projects.length) {
      projects.insert(index, project);
    }
  }

  // Helper method to remove a project by object reference
  static bool removeProject(List<ProjectModel> projects, ProjectModel project) {
    return projects.remove(project);
  }

  // Helper method to remove a project by ID
  static bool removeProjectById(List<ProjectModel> projects, String id) {
    int initialLength = projects.length;
    projects.removeWhere((project) => project.sId == id);
    return projects.length < initialLength;
  }

  // Helper method to remove a project at specific index
  static ProjectModel? removeProjectAt(List<ProjectModel> projects, int index) {
    if (index >= 0 && index < projects.length) {
      return projects.removeAt(index);
    }
    return null;
  }

  // Helper method to update a project in the list
  static bool updateProject(
      List<ProjectModel> projects, String id, ProjectModel updatedProject) {
    int index = projects.indexWhere((project) => project.sId == id);
    if (index != -1) {
      projects[index] = updatedProject;
      return true;
    }
    return false;
  }

  // Helper method to find a project by ID
  static ProjectModel? findProjectById(List<ProjectModel> projects, String id) {
    try {
      return projects.firstWhere((project) => project.sId == id);
    } catch (e) {
      return null;
    }
  }

  // Helper method to clear all projects
  static void clearProjects(List<ProjectModel> projects) {
    projects.clear();
  }

  // Override equality operator for better comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel && other.sId == sId;
  }

  @override
  int get hashCode => sId.hashCode;
}
