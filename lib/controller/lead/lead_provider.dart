import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/client/client_data_list_model.dart';
import '../../model/lead/lead_model.dart';

class LeadProvider extends ChangeNotifier {
  LeadProvider._privateConstructor();
  static final _instance = LeadProvider._privateConstructor();
  factory LeadProvider() => _instance;

  int? selectedIndex;

  TextEditingController searchController = TextEditingController();
  var itemsPerPage = "10";
  var currentPage = 0;
  var selectedFilter = 'all';

  List<LeadModel> leadModel = [];

  bool _isPatching = false;
  String? _error;

  final ApiService _api = ApiService();

  List<LeadModel>? userList = [];
  bool isLoading = false;

  Future<void> getLeadList() async {
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.get(Constant().allLeads);
      leadModel = List.from(response['data'].map((e) => LeadModel.fromJson(e)));
    } catch (e) {
      _error = 'Failed to load permissions: $e';
    } finally {
      // notifyListeners();
    }
    notifyListeners();
  }

  // void updatePageSize(String size) {
  //   itemsPerPage.value = size;
  //   currentPage.value = 0;
  //   fetchData(search: searchController.text);
  // }

  void onPageSelected(int page) {
    currentPage = page;
    // fetchData(search: searchController.text);
  }

  void clearSearch() {
    searchController.clear();
    // fetchData();
  }

  void onSearchSubmitted() {
    currentPage = 0;
    // fetchData(search: searchController.text);
  }

  // UserModel getUserDetails() {
  //   if (userModel != null) {
  //     return userModel ?? const UserModel();
  //   }
  //   userModel = serviceLocator<UserCacheService>().getUser();
  //   return userModel ?? const UserModel();
  // }
}
