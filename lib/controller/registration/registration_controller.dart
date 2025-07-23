import 'package:flutter/widgets.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';

class RegistrationController extends ChangeNotifier {
  RegistrationController._privateConstructor();
  static final RegistrationController _instance =
      RegistrationController._privateConstructor();
  factory RegistrationController() => _instance;

  String selectedCategory = 'all';
  bool isFilterActive = false;
  bool showFilters = false;

  ApiService _apiService = ApiService();

  List<LeadModel> leads = [];

  List<LeadModel> filteredLeads = [];

  void setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setIsFilterActive(bool value) {
    isFilterActive = value;
    notifyListeners();
  }

  void setShowFilters(bool value) {
    showFilters = value;
    notifyListeners();
  }

  Future<void> fetchRegistration(
    context,
  ) async {
    // _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _apiService.get(context: context, Constant().getIncompleteList);

      if (response['success']) {
        final List<LeadModel> loadedLeads = [];

        for (var item in response['data']) {
          loadedLeads.add(LeadModel.fromJson(item));
        }

        leads = loadedLeads;
        filteredLeads = loadedLeads; // Initialize filtered list
      } else {
        throw Exception("Failed to load clients");
      }
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      // _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addAcademicRecords(context,
      {required List<Map<String, dynamic>> educationList,
      required String leadId}) async {
    notifyListeners();
    try {
      final response = await _apiService.post(
          context: context,
          "${Constant().updateAcademicRecords}/$leadId",
          {},
          listData: educationList);
      return response['success'] == true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> editRegistration(context, Map<String, dynamic> updatedData,
      {required String clientId}) async {
    notifyListeners();
    try {
      final response = await _apiService.patch(
        context: context,
        '${Constant().editRegistration}/$clientId',
        updatedData,
      );
      if (response['success'] == true) {
        return true;
      }
    } catch (e) {
      print('Error restoring client officer: $e');
    }
    notifyListeners();
    return false;
  }
}
