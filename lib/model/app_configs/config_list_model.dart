import 'config_model.dart';

class ConfigListModel {
  String? id;
  String? name;
  List<ConfigModel>? branch;
  List<ConfigModel>? callType;
  List<ConfigModel>? callStatus;
  List<ConfigModel>? clientStatus;
  List<ConfigModel>? courseType;
  List<ConfigModel>? program;
  List<ConfigModel>? vehicleBrand;
  List<ConfigModel>? vehicleType;
  List<ConfigModel>? country;
  List<ConfigModel>? leadSource;
  List<ConfigModel>? serviceType;
  List<ConfigModel>? test;
  List<ConfigModel>? jobCategory;
  List<ConfigModel>? subcategory;
  List<ConfigModel>? closedStatus;
  List<ConfigModel>? courses;
  List<ConfigModel>? leadDocuments;
  List<ConfigModel>? documents;
  List<ConfigModel>? priceComponents;
  List<ConfigModel>? tags;
  List<ConfigModel>? serviceIncludes;
  List<ConfigModel>? stepList;

  ConfigListModel({
    this.id,
    this.name,
    this.branch,
    this.callStatus,
    this.country,
    this.leadSource,
    this.serviceType,
    this.callType,
    this.vehicleBrand,
    this.vehicleType,
    this.clientStatus,
    this.subcategory,
    this.test,
    this.courseType,
    this.program,
    this.jobCategory,
    this.closedStatus,
    this.courses,
    this.leadDocuments,
    this.documents,
    this.priceComponents,
    this.tags,
    this.serviceIncludes,
    this.stepList,
  });

  factory ConfigListModel.fromJson(Map<String, dynamic> json) =>
      ConfigListModel(
        id: json["_id"],
        name: json["name"],
        branch: _parseConfigList(json["branch"]),
        callStatus: _parseConfigList(json["call_status"]),
        country: _parseConfigList(json["country"]),
        leadSource: _parseConfigList(json["lead_source"]),
        serviceType: _parseConfigList(json["service_type"]),
        vehicleBrand: _parseConfigList(json["vehicle_brand"]),
        vehicleType: _parseConfigList(json["vehicle_type"]),
        callType: _parseConfigList(json["call_type"]),
        subcategory: _parseConfigList(json["sub_category"]),
        clientStatus: _parseConfigList(json["client_status"]),
        test: _parseConfigList(json["test"]),
        courseType: _parseConfigList(json["course_type"]),
        program: _parseConfigList(json["program"]),
        jobCategory: _parseConfigList(json["job_category"]),
        closedStatus: _parseConfigList(json["closed_status"]),
        courses: _parseConfigList(json["courses"]),
        leadDocuments: _parseConfigList(json["lead_documents"]),
        documents: _parseConfigList(json["documents"]),
        priceComponents: _parseConfigList(json["priceComponents"]),
        tags: _parseConfigList(json["tags"]),
        serviceIncludes: _parseConfigList(json["serviceIncludes"]),
        stepList: _parseConfigList(json["stepList"]),
      );

  Map<String, dynamic> toJson() => {
        "branch": _mapList(branch),
        "call_status": _mapList(callStatus),
        "call_type": _mapList(callType),
        "client_status": _mapList(clientStatus),
        "country": _mapList(country),
        "lead_source": _mapList(leadSource),
        "service_type": _mapList(serviceType),
        "vehicle_brand": _mapList(vehicleBrand),
        "vehicle_type": _mapList(vehicleType),
        "sub_category": _mapList(subcategory),
        "test": _mapList(test),
        "course_type": _mapList(courseType),
        "program": _mapList(program),
        "job_category": _mapList(jobCategory),
        "closed_status": _mapList(closedStatus),
        "courses": _mapList(courses),
        "lead_documents": _mapList(leadDocuments),
        "documents": _mapList(documents),
        "priceComponents": _mapList(priceComponents),
        "tags": _mapList(tags),
        "serviceIncludes": _mapList(serviceIncludes),
        "stepList": _mapList(stepList),
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
      "call_status": callStatus,
      "call_type": callType,
      "client_status": clientStatus,
      "country": country,
      "lead_source": leadSource,
      "service_type": serviceType,
      "vehicle_brand": vehicleBrand,
      "vehicle_type": vehicleType,
      "test": test,
      "course_type": courseType,
      "program": program,
      "job_category": jobCategory,
      "sub_category": subcategory,
      "closed_status": closedStatus,
      "courses": courses,
      "lead_documents": leadDocuments,
      "documents": documents,
      "priceComponents": priceComponents,
      "tags": tags,
      "serviceIncludes": serviceIncludes,
      "stepList": stepList,
    };
  }

  void updateItem(String category, ConfigModel item) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    int index = targetList.indexWhere((config) => config.id == item.id);
    if (index != -1) {
      targetList[index] = item;
    }
  }

  void deleteItem(String category, ConfigModel item) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    targetList.removeWhere((config) => config.id == item.id);
  }

  void insertItemList(String category, List<ConfigModel> items) {
    List<ConfigModel>? targetList = _getListByCategory(category);
    if (targetList == null) return;

    for (final item in items) {
      if (!targetList.any((config) => config.id == item.id)) {
        targetList.add(item);
      }
    }
  }

  List<ConfigModel>? _getListByCategory(String category) {
    switch (category) {
      case 'branch':
        return branch ??= [];
      case 'call_status':
        return callStatus ??= [];
      case 'call_type':
        return callType ??= [];
      case 'client_status':
        return clientStatus ??= [];
      case 'country':
        return country ??= [];
      case 'vehicle_brand':
        return vehicleBrand ??= [];
      case 'vehicle_type':
        return vehicleType ??= [];
      case 'lead_source':
        return leadSource ??= [];
      case 'service_type':
        return serviceType ??= [];
      case 'test':
        return test ??= [];
      case 'course_type':
        return courseType ??= [];
      case 'program':
        return program ??= [];
      case 'job_category':
        return jobCategory ??= [];
      case 'sub_category':
        return subcategory ??= [];
      case 'closed_status':
        return closedStatus ??= [];
      case 'courses':
        return courses ??= [];
      case 'lead_documents':
        return leadDocuments ??= [];

      case 'documents':
        return documents ??= [];
      case 'priceComponents':
        return priceComponents ??= [];
      case 'tags':
        return tags ??= [];
      case 'serviceIncludes':
        return serviceIncludes ??= [];
      case 'stepList':
        return stepList ??= [];
      default:
        throw ArgumentError('Unknown category: $category');
    }
  }

  int getTotalKeysCount() {
    return getAllKeys().length;
  }
}
