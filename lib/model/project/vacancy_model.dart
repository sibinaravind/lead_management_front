import 'package:overseas_front_end/model/project/project_model.dart';

class VacancyModel {
  String? sId;
  String? jobTitle;
  String? jobCategory;
  List<String>? qualifications;
  List<ProjectModel>? projectModels;
  // SpecializedModel? specializedModels;
  String? experience;
  int? salaryFrom;
  int? salaryTo;
  String? lastdatetoapply;
  String? description;
  String? country;
  String? city;
  int? totalVacancies;
  int? totalTargetCv;

  VacancyModel(
      {this.sId,
      this.jobTitle,
      this.jobCategory,
      this.qualifications,
      this.experience,
      this.salaryFrom,
      this.salaryTo,
      this.lastdatetoapply,
      this.description,
      this.country,
      this.city,
      this.totalVacancies,
      this.totalTargetCv});

  // VacancyModel.fromJson(Map<String, dynamic> json) {
  //   sId = json['_id']??'';
  //   jobTitle = json['job_title']??'';
  //   jobCategory = json['job_category']??'';
  //   qualifications = json['qualifications'].cast<String>()??[];
  //   // projectModels = json['project'].cast<ProjectModel>();
  //   // specializedModels = json['specialization_totals'] ?? {};
  //   experience = json['experience']??[];
  //   salaryFrom = json['salary_from']??0;
  //   salaryTo = json['salary_to']??0;
  //   lastdatetoapply = json['lastdatetoapply']??'';
  //   description = json['description']??'';
  //   country = json['country']??'';
  //   city = json['city']??'';
  //   totalVacancies = json['total_vacancies']??0;
  //   totalTargetCv = json['total_target_cv']??0;
  // }
  VacancyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobTitle = json['job_title'];
    jobCategory = json['job_category'];
    qualifications = json['qualifications']?.cast<String>() ?? [];
    experience = json['experience']?.toString();
    salaryFrom = json['salary_from'] is int
        ? json['salary_from']
        : int.tryParse(json['salary_from']?.toString() ?? '');
    salaryTo = json['salary_to'] is int
        ? json['salary_to']
        : int.tryParse(json['salary_to']?.toString() ?? '');
    lastdatetoapply = json['lastdatetoapply'];
    description = json['description'];
    country = json['country'];
    city = json['city'];
    totalVacancies = json['total_vacancies'] is int
        ? json['total_vacancies']
        : int.tryParse(json['total_vacancies']?.toString() ?? '');
    totalTargetCv = json['total_target_cv'] is int
        ? json['total_target_cv']
        : int.tryParse(json['total_target_cv']?.toString() ?? '');
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['job_title'] = this.jobTitle;
    data['job_category'] = this.jobCategory;
    data['qualifications'] = this.qualifications;
    data['experience'] = this.experience;
    data['salary_from'] = this.salaryFrom;
    data['project'] = this.projectModels;
    // data['specialization_totals'] = this.specializedModels;
    data['salary_to'] = this.salaryTo;
    data['lastdatetoapply'] = this.lastdatetoapply;
    data['description'] = this.description;
    data['country'] = this.country;
    data['city'] = this.city;
    data['total_vacancies'] = this.totalVacancies;
    data['total_target_cv'] = this.totalTargetCv;
    return data;
  }
}

class SpecializedModel {
  OT? oT;
  OT? gENERAL;

  SpecializedModel({this.oT, this.gENERAL});

  SpecializedModel.fromJson(Map<String, dynamic> json) {
    oT = json['OT'] != null ? new OT.fromJson(json['OT']) : null;
    gENERAL = json['GENERAL'] != null ? new OT.fromJson(json['GENERAL']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oT != null) {
      data['OT'] = this.oT!.toJson();
    }
    if (this.gENERAL != null) {
      data['GENERAL'] = this.gENERAL!.toJson();
    }
    return data;
  }
}

class OT {
  int? count;
  int? targetCv;

  OT({this.count, this.targetCv});

  OT.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    targetCv = json['target_cv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['target_cv'] = this.targetCv;
    return data;
  }
}
