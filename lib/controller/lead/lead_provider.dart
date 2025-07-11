import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/client/client_data_list_model.dart';
import '../../model/lead/lead_model.dart';

class LeadProvider extends ChangeNotifier {
  LeadProvider._privateConstructor();
  static final _instance = LeadProvider._privateConstructor();
  factory LeadProvider() => _instance;
  bool showFilters = false;
  int? selectedIndex;
  bool isFilterActive = false;

  TextEditingController searchController = TextEditingController();
  var itemsPerPage = "10";
  var currentPage = 0;
  var selectedFilter = 'all';

  void setShowFilter(val) {
    showFilters = val;
    notifyListeners();
  }

  void setFilterActive(val) {
    isFilterActive = val;
    notifyListeners();
  }

  List<LeadModel> leadModel = [];
  List<LeadModel> allLeadModel = [];

  bool _isPatching = false;
  String? _error;

  final ApiService _api = ApiService();

  List<LeadModel>? userList = [];
  bool isLoading = false;

  bool _isLoading = false;

  // void filterEmployees(String str) {
  //   print(str);
  //   if (str.isEmpty) {
  //     leadModel = allLeadModel;
  //   }

  //   leadModel = leadModel
  //           ?.where(
  //             (element) =>
  //                 (element.email?.toLowerCase().contains(str.toLowerCase()) ??
  //                     false) ||
  //                 (element.name?.toLowerCase().contains(str.toLowerCase()) ??
  //                     false),
  //           )
  //           .toList() ??
  //       [];

  //   notifyListeners();
  // }

  Future<void> getLeadList() async {
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.get(Constant().allLeads);
      leadModel = List.from(response['data'].map((e) => LeadModel.fromJson(e)));
      allLeadModel =
          List.from(response['data'].map((e) => LeadModel.fromJson(e)));
    } catch (e) {
      _error = 'Failed to load permissions: $e';
    } finally {
      // notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> addLead({
    required String name,
    required String email,
    required String phone,
    required String alternatePhone,
    required String whatsapp,
    required String gender,
    required String dob,
    required String matrialStatus,
    required String address,
    required String city,
    required String state,
    required String country,
    required List<String> jobInterests,
    required List<String> countryInterested,
    required int expectedSalary,
    required String qualification,
    required String university,
    required String passingYear,
    required int experience,
    required List<String> skills,
    required String profession,
    required String specializedIn,
    required String leadSource,
    required String comment,
    required bool onCallCommunication,
    required bool onWhatsappCommunication,
    required bool onEmailCommunication,
    required String status,
    required String serviceType,
    required String branchName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _api.post(Constant().addLead, {
        "name": name,
        "email": email,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "whatsapp": whatsapp,
        "gender": gender,
        "dob": dob,
        "matrial_status": matrialStatus,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "job_interests": jobInterests,
        "country_interested": countryInterested,
        "expected_salary": expectedSalary,
        "qualification": qualification,
        "university": university,
        "passing_year": passingYear,
        "experience": experience,
        "skills": skills,
        "profession": profession,
        "specialized_in": specializedIn,
        "lead_source": leadSource,
        "comment": comment,
        "on_call_communication": onCallCommunication,
        "on_whatsapp_communication": onWhatsappCommunication,
        "on_email_communication": onEmailCommunication,
        "status": status,
        "service_type": serviceType,
        "branch_name": branchName,
      });
      // _campaignModel = CampaignModel.fromJson(response.data);
      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
