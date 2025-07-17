import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:overseas_front_end/core/shared/constants.dart';

import '../../core/services/api_service.dart';
class VacancyProvider with ChangeNotifier {
  VacancyProvider._privateConstructor();
  static final _instance = VacancyProvider._privateConstructor();
  factory VacancyProvider() => _instance;

  final ApiService _apiService = ApiService();

  bool isLoading = false;
  String? responseId;

  List<Map<String, dynamic>> vacancyList = [];

  // Create Vacancy
  Future<void> createVacancy(Map<String, dynamic> vacancyData) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(
        Constant().createVacancy,
        vacancyData,
      );

      if (response.data['data'] != null && response.data['success'] == true) {
        responseId = response.data['data'];
      } else {
        responseId = null;
      }
    } catch (e) {
      print('Error creating vacancy: $e');
      responseId = null;
    }

    isLoading = false;
    notifyListeners();
  }

  // Edit Vacancy
  Future<void> editVacancy(String vacancyId, Map<String, dynamic> updatedData) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.patch(
        '${Constant().editVacancy}/$vacancyId',
        updatedData,
      );

      if (response.data['success'] == true) {
        print('Vacancy updated successfully');
      } else {
        print('Failed to update vacancy');
      }
    } catch (e) {
      print('Error editing vacancy: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Delete Vacancy
  Future<void> deleteVacancy(String vacancyId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.delete(
        '${Constant().deleteVacancy}/$vacancyId',{}
      );

      if (response.data['success'] == true) {
        print('Vacancy deleted successfully');
        vacancyList.removeWhere((vacancy) => vacancy['_id'] == vacancyId);
      } else {
        print('Failed to delete vacancy');
      }
    } catch (e) {
      print('Error deleting vacancy: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Get Vacancy List
  Future<void> getVacancyList() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(Constant().vacancyList);

      if (response.data['success'] == true) {
        vacancyList = List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        vacancyList = [];
      }
    } catch (e) {
      print('Error fetching vacancy list: $e');
      vacancyList = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
