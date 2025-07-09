import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';

class OfficersControllerProvider with ChangeNotifier {
  OfficersControllerProvider._privateConstructor();
  static final _instance = OfficersControllerProvider._privateConstructor();
  factory OfficersControllerProvider() {
    return _instance;
  }

  final ApiService _apiService = ApiService();

  List<OfficersModel>? _officersListData;
  List<OfficersModel>? _filteredOfficersList;

  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // List<OfficersModel>? get officersListModel => _officersListData;
  List<OfficersModel>? get officersListModel =>
      _searchQuery.isEmpty ? _officersListData : _filteredOfficersList;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();

    if (_officersListData == null) return;

    _filteredOfficersList = _officersListData!.where((officer) {
      final employeeName = officer.name.toLowerCase() ?? '';
      final phone = officer.phone.toLowerCase() ?? '';
      final employeePhone = officer.companyPhoneNumber.toLowerCase() ?? '';
      return employeeName.contains(_searchQuery) ||employeePhone.contains(_searchQuery)||
          phone.contains(_searchQuery);
    }).toList();

    _filteredOfficersList!.sort((a, b) {
      final aId = int.tryParse(a.officerId ?? '') ?? 0;
      final bId = int.tryParse(b.officerId ?? '') ?? 0;
      return aId.compareTo(bId);
    });

    notifyListeners();
  }

  Future<List<OfficersModel>?> fetchOfficersList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      dynamic json = await _apiService.get(Constant().officerList);

      if (json['success'] == true && json['data'] != null) {
        final List<dynamic> dataList = json['data'];
        _officersListData =
            dataList.map((e) => OfficersModel.fromJson(e)).toList();

        _officersListData!.sort((a, b) {
          final aId = int.tryParse(a.officerId ?? '') ?? 0;
          final bId = int.tryParse(b.officerId ?? '') ?? 0;
          return aId.compareTo(bId);
        });

        return _officersListData;
      } else {
        _error = 'Invalid response structure';
        return [];
      }
    } catch (e) {
      _error = "Failed to load officers: $e";
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOfficer(Map<String,dynamic> officer) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
      await _apiService.post(Constant().officerInsert, officer);

      if (response['success'] == true) {
        await fetchOfficersList();
        return true;
      } else {
        _error = response['message'] ?? 'Creation failed';
        return false;
      }
    } catch (e) {
      _error = 'Error creating officer: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> updateOfficer(String officerId, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.patch(
        "${Constant().officerUpdate}/$officerId",
        updatedData,
      );

      if (response['success'] == true) {
        await fetchOfficersList();
        return true;
      } else {
        _error = response['message'] ?? 'Update failed';
        return false;
      }
    } catch (e) {
      _error = 'Error updating officer: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Future<bool> updateOfficerPassword(String officerId, Map<String, dynamic> updatedData) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final response = await _apiService.patch(
  //       "${Constant().officerUpdate}/$officerId",
  //       updatedData,
  //     );
  //
  //     if (response['success'] == true) {
  //       await fetchOfficersList();
  //       return true;
  //     } else {
  //       _error = response['message'] ?? 'Update failed';
  //       return false;
  //     }
  //   } catch (e) {
  //     _error = 'Error updating officer: $e';
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  Future<bool> deleteOfficer(String officerId,) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic>  data= {
        "status": "active",
  };
      final response = await _apiService.delete(
        "${Constant().officerDelete}/$officerId",
       data
      );

      if (response['success'] == true) {
        await fetchOfficersList(); // refresh list after deletion
        return true;
      } else {
        _error = response['message'] ?? 'Delete failed';
        return false;
      }
    } catch (e) {
      _error = 'Error deleting officer: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}
