import 'config_model.dart';

class ConfigListModel {
  String? id;
  String? name;
  List<ConfigModel>? branch;
  List<ConfigModel>? educationProgram;
  List<ConfigModel>? knownLanguages;
  List<ConfigModel>? callStatus;
  List<ConfigModel>? university;

  List<ConfigModel>? intake;
  List<ConfigModel>? country;
  // List<ConfigModel>? leadCategory;
  List<ConfigModel>? leadSource;
  List<ConfigModel>? serviceType;
  List<ConfigModel>? profession;
  List<ConfigModel>? medicalProfessionCategory;
  List<ConfigModel>? nonMedical;
  List<ConfigModel>? callType;
  List<ConfigModel>? clientStatus;
  List<ConfigModel>? designation;
  List<ConfigModel>? specialized;
  List<ConfigModel>? qualification;

  List<ConfigModel>? test;

  ConfigListModel({
    this.id,
    this.name,
    this.branch,
    this.educationProgram,
    this.knownLanguages,
    this.callStatus,
    this.university,
    this.intake,
    this.country,
    // this.leadCategory,
    this.leadSource,
    this.serviceType,
    this.profession,
    this.medicalProfessionCategory,
    this.nonMedical,
    this.callType,
    this.clientStatus,
    this.designation,
    this.specialized,
    this.qualification,
    this.test,
  });

  factory ConfigListModel.fromJson(Map<String, dynamic> json) =>
      ConfigListModel(
        id: json["_id"],
        name: json["name"],
        branch: _parseConfigList(json["branch"]),
        educationProgram: _parseConfigList(json["education_program"]),
        knownLanguages: _parseConfigList(json["known_languages"]),
        callStatus: _parseConfigList(json["call_status"]),
        university: _parseConfigList(json["university"]),
        intake: _parseConfigList(json["intake"]),
        country: _parseConfigList(json["country"]),
        // leadCategory: _parseConfigList(json["lead_category"]),
        leadSource: _parseConfigList(json["lead_source"]),
        serviceType: _parseConfigList(json["service_type"]),
        profession: _parseConfigList(json["profession"]),
        medicalProfessionCategory:
            _parseConfigList(json["medical_profession_category"]),
        nonMedical: _parseConfigList(json["non_medical"]),
        callType: _parseConfigList(json["call_type"]),
        qualification: _parseConfigList(json["qualification"]),
        specialized: _parseConfigList(json["specialized"]),

        clientStatus: json["client_status"] == null
            ? []
            : List<ConfigModel>.from(
                json["client_status"].map((x) => ConfigModel.fromMap(x))),
        // designation: _parseConfigList(json["designation"]),
        test: _parseConfigList(json["test"]),
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        // "name": name,
        "branch": _mapList(branch),
        "education_program": _mapList(educationProgram),
        "known_languages": _mapList(knownLanguages),
        "call_status": _mapList(callStatus),
        "university": _mapList(university),
        "intake": _mapList(intake),
        "country": _mapList(country),
        // "lead_category": _mapList(leadCategory),
        "lead_source": _mapList(leadSource),
        "service_type": _mapList(serviceType),
        "profession": _mapList(profession),
        "medical_profession_category": _mapList(medicalProfessionCategory),
        "non_medical": _mapList(nonMedical),
        "call_type": _mapList(callType),
        "client_status":
            clientStatus?.map((x) => x.toMap()).toList() ?? <dynamic>[],
        "designation": _mapList(designation),
        "specialized": _mapList(specialized),
        "qualification": _mapList(qualification),
        "test": _mapList(test),
      };

  static List<ConfigModel>? _parseConfigList(dynamic list) {
    if (list == null) return [];
    return List<ConfigModel>.from(list.map((x) => ConfigModel.fromMap(x)));
  }

  static List<dynamic> _mapList(List<ConfigModel>? list) {
    return list?.map((x) => x.toMap()).toList() ?? <dynamic>[];
  }

  void insertItem(String category, ConfigModel item) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    if (!targetList.any((config) => config.id == item.id)) {
      targetList.add(item);
    }
  }

  List<ConfigModel?> getItems(String category) {
    final map = _asMap();
    return (map[category] ?? []) as List<ConfigModel?>;
  }

  Set<String> getAllKeys() {
    final map = _asMap();
    return map.keys.toSet();
  }

  Map<String, List<ConfigModel>?> _asMap() {
    return {
      "branch": branch,
      "education_program": educationProgram,
      "known_languages": knownLanguages,
      "call_status": callStatus,
      "university": university,
      "intake": intake,
      "country": country,
      // "lead_category": leadCategory,
      "lead_source": leadSource,
      "service_type": serviceType,
      "profession": profession,
      "medical_profession_category": medicalProfessionCategory,
      "non_medical": nonMedical,
      "call_type": callType,
      "client_status": clientStatus,
      "designation": designation,
      "specialized": specialized,
      "qualification": qualification,
      "test": test,
    };
  }

// Update: updates item if exists (matches by id)
  void updateItem(String category, ConfigModel item) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    int index = targetList.indexWhere((config) => config.id == item.id);
    if (index != -1) {
      targetList[index] = item;
    }
  }

// Delete: removes item by id
  void deleteItem(String category, ConfigModel item) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    targetList.removeWhere((config) => config.id == item.id);
  }

  void insertItemList(String category, List<ConfigModel> items) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    for (final item in items) {
      // Prevent duplicates (by ID)
      if (!targetList.any((config) => config.id == item.id)) {
        targetList.add(item);
      }
    }
  }

// Helper to get the list based on category
  List<ConfigModel>? _getListByCategory(String category) {
    switch (category) {
      case 'branch':
        return branch ??= [];
      case 'education_program':
        return educationProgram ??= [];
      case 'known_languages':
        return knownLanguages ??= [];
      case 'call_status':
        return callStatus ??= [];
      case 'intake':
        return intake ??= [];
      case 'country':
        return country ??= [];
      // case 'lead_category':
      //   return leadCategory ??= [];
      case 'lead_source':
        return leadSource ??= [];
      case 'service_type':
        return serviceType ??= [];
      case 'profession':
        return profession ??= [];
      case 'medical_profession_category':
        return medicalProfessionCategory ??= [];
      case 'non_medical':
        return nonMedical ??= [];
      case 'call_type':
        return callType ??= [];
      case 'client_status':
        return clientStatus ??= [];
      case 'designation':
        return designation ??= [];
      case 'test':
        return test ??= [];
      default:
        throw ArgumentError('Unknown category: $category');
    }
  }

  int getTotalKeysCount() {
    return getAllKeys().length;
  }
}
