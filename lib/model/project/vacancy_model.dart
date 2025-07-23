// import 'package:overseas_front_end/model/project/project_model.dart';
//
// class VacancyModel {
//   String? sId;
//   String? jobTitle;
//   String? jobCategory;
//   List<String>? qualifications;
//   List<ProjectModel>? projectModels;
//   // SpecializedModel? specializedModels;
//   String? experience;
//   int? salaryFrom;
//   int? salaryTo;
//   String? lastdatetoapply;
//   String? description;
//   String? country;
//   String? city;
//   int? totalVacancies;
//   int? totalTargetCv;
//
//   VacancyModel(
//       {this.sId,
//       this.jobTitle,
//       this.jobCategory,
//       this.qualifications,
//       this.experience,
//       this.salaryFrom,
//       this.salaryTo,
//       this.lastdatetoapply,
//       this.description,
//       this.country,
//       this.city,
//       this.totalVacancies,
//       this.totalTargetCv});
//
//   // VacancyModel.fromJson(Map<String, dynamic> json) {
//   //   sId = json['_id']??'';
//   //   jobTitle = json['job_title']??'';
//   //   jobCategory = json['job_category']??'';
//   //   qualifications = json['qualifications'].cast<String>()??[];
//   //   // projectModels = json['project'].cast<ProjectModel>();
//   //   // specializedModels = json['specialization_totals'] ?? {};
//   //   experience = json['experience']??[];
//   //   salaryFrom = json['salary_from']??0;
//   //   salaryTo = json['salary_to']??0;
//   //   lastdatetoapply = json['lastdatetoapply']??'';
//   //   description = json['description']??'';
//   //   country = json['country']??'';
//   //   city = json['city']??'';
//   //   totalVacancies = json['total_vacancies']??0;
//   //   totalTargetCv = json['total_target_cv']??0;
//   // }
//   VacancyModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     jobTitle = json['job_title'];
//     jobCategory = json['job_category'];
//     qualifications = json['qualifications']?.cast<String>() ?? [];
//     experience = json['experience']?.toString();
//     salaryFrom = json['salary_from'] is int
//         ? json['salary_from']
//         : int.tryParse(json['salary_from']?.toString() ?? '');
//     salaryTo = json['salary_to'] is int
//         ? json['salary_to']
//         : int.tryParse(json['salary_to']?.toString() ?? '');
//     lastdatetoapply = json['lastdatetoapply'];
//     description = json['description'];
//     country = json['country'];
//     city = json['city'];
//     totalVacancies = json['total_vacancies'] is int
//         ? json['total_vacancies']
//         : int.tryParse(json['total_vacancies']?.toString() ?? '');
//     totalTargetCv = json['total_target_cv'] is int
//         ? json['total_target_cv']
//         : int.tryParse(json['total_target_cv']?.toString() ?? '');
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['job_title'] = this.jobTitle;
//     data['job_category'] = this.jobCategory;
//     data['qualifications'] = this.qualifications;
//     data['experience'] = this.experience;
//     data['salary_from'] = this.salaryFrom;
//     data['project'] = this.projectModels;
//     // data['specialization_totals'] = this.specializedModels;
//     data['salary_to'] = this.salaryTo;
//     data['lastdatetoapply'] = this.lastdatetoapply;
//     data['description'] = this.description;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     data['total_vacancies'] = this.totalVacancies;
//     data['total_target_cv'] = this.totalTargetCv;
//     return data;
//   }
// }
//
// class SpecializedModel {
//   OT? oT;
//   OT? gENERAL;
//
//   SpecializedModel({this.oT, this.gENERAL});
//
//   SpecializedModel.fromJson(Map<String, dynamic> json) {
//     oT = json['OT'] != null ? new OT.fromJson(json['OT']) : null;
//     gENERAL = json['GENERAL'] != null ? new OT.fromJson(json['GENERAL']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.oT != null) {
//       data['OT'] = this.oT!.toJson();
//     }
//     if (this.gENERAL != null) {
//       data['GENERAL'] = this.gENERAL!.toJson();
//     }
//     return data;
//   }
// }
//
// class OT {
//   int? count;
//   int? targetCv;
//
//   OT({this.count, this.targetCv});
//
//   OT.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     targetCv = json['target_cv'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['target_cv'] = this.targetCv;
//     return data;
//   }
// }

import 'package:overseas_front_end/model/project/project_model.dart';

class VacancyModel {
  String? id;
  String? jobTitle;
  String? jobCategory;
  List<String>? qualifications;
  String? experience;
  dynamic salaryFrom;
  dynamic salaryTo;
  String? lastDateToApply;
  String? description;
  String? country;
  String? city;
  String? status;
  ProjectModel? project;
  List<SpecializationTotal>? specializationTotals;
  int? totalVacancies;
  int? totalTargetCv;

  VacancyModel({
    this.id,
    this.jobTitle,
    this.jobCategory,
    this.qualifications,
    this.experience,
    this.salaryFrom,
    this.salaryTo,
    this.lastDateToApply,
    this.description,
    this.country,
    this.city,
    this.status,
    this.project,
    this.specializationTotals,
    this.totalVacancies,
    this.totalTargetCv,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      id: json['_id'],
      jobTitle: json['job_title'],
      jobCategory: json['job_category'],
      qualifications: List<String>.from(json['qualifications'] ?? []),
      experience: json['experience'],
      salaryFrom: json['salary_from'],
      salaryTo: json['salary_to'],
      lastDateToApply: json['lastdatetoapply'],
      description: json['description'],
      country: json['country'],
      city: json['city'],
      status: json['status'],
      project: json['project'] != null ? ProjectModel.fromJson(json['project']) : null,
      specializationTotals: (json['specialization_totals'] as List<dynamic>?)
          ?.map((e) => SpecializationTotal.fromJson(e))
          .toList(),
      totalVacancies: json['total_vacancies'],
      totalTargetCv: json['total_target_cv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'job_title': jobTitle,
      'job_category': jobCategory,
      'qualifications': qualifications,
      'experience': experience,
      'salary_from': salaryFrom,
      'salary_to': salaryTo,
      'lastdatetoapply': lastDateToApply,
      'description': description,
      'country': country,
      'city': city,
      'status': status,
      'project': project?.toJson(),
      'specialization_totals':
      specializationTotals?.map((e) => e.toJson()).toList(),
      'total_vacancies': totalVacancies,
      'total_target_cv': totalTargetCv,
    };
  }
}

// class Project {
//   String? id;
//   String? projectName;
//   String? organizationType;
//   String? organizationCategory;
//   String? organizationName;
//   String? country;
//   String? city;
//
//   Project({
//     this.id,
//     this.projectName,
//     this.organizationType,
//     this.organizationCategory,
//     this.organizationName,
//     this.country,
//     this.city,
//   });
//
//   factory Project.fromJson(Map<String, dynamic> json) {
//     return Project(
//       id: json['_id'],
//       projectName: json['project_name'],
//       organizationType: json['organization_type'],
//       organizationCategory: json['organization_category'],
//       organizationName: json['organization_name'],
//       country: json['country'],
//       city: json['city'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'project_name': projectName,
//       'organization_type': organizationType,
//       'organization_category': organizationCategory,
//       'organization_name': organizationName,
//       'country': country,
//       'city': city,
//     };
//   }
// }

class SpecializationTotal {
  String? specialization;
  int? count;
  int? targetCv;

  SpecializationTotal({
    this.specialization,
    this.count,
    this.targetCv,
  });

  factory SpecializationTotal.fromJson(Map<String, dynamic> json) {
    return SpecializationTotal(
      specialization: json['specialization'],
      count: json['count'],
      targetCv: json['target_cv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization': specialization,
      'count': count,
      'target_cv': targetCv,
    };
  }
  // ===== Helper Methods =====

  static void addVacancy(List<VacancyModel> list, VacancyModel vacancy) {
    list.add(vacancy);
  }

  static void insertVacancy(List<VacancyModel> list, int index, VacancyModel vacancy) {
    if (index >= 0 && index <= list.length) {
      list.insert(index, vacancy);
    }
  }

  static bool removeVacancy(List<VacancyModel> list, VacancyModel vacancy) {
    return list.remove(vacancy);
  }

  static bool removeVacancyById(List<VacancyModel> list, String id) {
    int initialLength = list.length;
    list.removeWhere((vacancy) => vacancy.id == id);
    return list.length < initialLength;
  }

  static VacancyModel? removeVacancyAt(List<VacancyModel> list, int index) {
    if (index >= 0 && index < list.length) {
      return list.removeAt(index);
    }
    return null;
  }

  static bool updateVacancy(List<VacancyModel> list, String id, VacancyModel updated) {
    int index = list.indexWhere((vacancy) => vacancy.id == id);
    if (index != -1) {
      list[index] = updated;
      return true;
    }
    return false;
  }

  // static VacancyModel? findVacancyById(List<VacancyModel> list, String id) {
  //   try {
  //     return list.firstWhere((vacancy) => vacancy.id == id);
  //   } catch (e) {
  //     return null;
  //   }
  // }
  //
  // static void clearVacancies(List<VacancyModel> list) {
  //   list.clear();
  // }

  // // Equality override
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is VacancyModel && other.id == id;
  // }
  //
  // @override
  // int get hashCode => id.hashCode;

}



