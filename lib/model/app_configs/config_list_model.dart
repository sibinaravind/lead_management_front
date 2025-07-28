import 'config_model.dart';

class ConfigListModel {
  String? id;
  String? name;
  List<ConfigModel>? branch;
  List<ConfigModel>? callType;
  List<ConfigModel>? callStatus;
  List<ConfigModel>? clientStatus;
  List<ConfigModel>? programType; // New field
  List<ConfigModel>? program; // New field
  List<ConfigModel>? country;
  List<ConfigModel>? leadSource;
  List<ConfigModel>? serviceType;
  List<ConfigModel>? test;
  List<ConfigModel>? jobCategory; // New field
  List<ConfigModel>? specialized;
  List<ConfigModel>? closedStatus; // New field

  ConfigListModel({
    this.id,
    this.name,
    this.branch,
    this.callStatus,
    this.country,
    this.leadSource,
    this.serviceType,
    this.callType,
    this.clientStatus,
    this.specialized,
    this.test,
    this.programType,
    this.program,
    this.jobCategory,
    this.closedStatus,
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

        callType: _parseConfigList(json["call_type"]),

        specialized: _parseConfigList(json["specialized"]),
        clientStatus: _parseConfigList(json["client_status"]),
        test: _parseConfigList(json["test"]),
        programType: _parseConfigList(json["program_type"]), // New field
        program: _parseConfigList(json["program"]), // New field
        jobCategory: _parseConfigList(json["job_category"]), // New field
        closedStatus: _parseConfigList(json["closed_status"]), // New field
      );

  Map<String, dynamic> toJson() => {
        "branch": _mapList(branch),

        "call_status": _mapList(callStatus),
        "call_type": _mapList(callType),
        "client_status": _mapList(clientStatus),

        "country": _mapList(country),
        "lead_source": _mapList(leadSource),
        "service_type": _mapList(serviceType),

        "specialized": _mapList(specialized),

        "test": _mapList(test),
        "program_type": _mapList(programType), // New field
        "program": _mapList(program), // New field
        "job_category": _mapList(jobCategory), // New field
        "closed_status": _mapList(closedStatus), // New field
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

      "test": test,
      "program_type": programType, // New field
      "program": program, // New field
      "job_category": jobCategory, // New field
      "specialized": specialized,
      "closed_status": closedStatus, // New field
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
      case 'lead_source':
        return leadSource ??= [];
      case 'service_type':
        return serviceType ??= [];
      case 'test':
        return test ??= [];
      case 'program_type': // New case
        return programType ??= [];
      case 'program': // New case
        return program ??= [];
      case 'job_category': // New case
        return jobCategory ??= [];
      case 'specialized':
        return specialized ??= [];
      case 'closed_status': // New case
        return closedStatus ??= [];
      default:
        throw ArgumentError('Unknown category: $category');
    }
  }

  int getTotalKeysCount() {
    return getAllKeys().length;
  }
}
