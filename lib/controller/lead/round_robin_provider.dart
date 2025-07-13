import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../../core/services/api_service.dart';
import '../../model/lead/round_robin_group.dart';

class RoundRobinProvider extends ChangeNotifier {

  RoundRobinProvider._privateConstructor();
  static final _instance = RoundRobinProvider._privateConstructor();
  factory RoundRobinProvider() {
    return _instance;
  }

  final ApiService _apiService = ApiService();


  List<RoundRobinGroup> _roundRobinGroups = [];
  bool _isLoading = false;
  String? _error;

  List<RoundRobinGroup> get roundRobinGroups => _roundRobinGroups;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRoundRobinGroups() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
       Constant().roundRobinList
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer $token',
        //   },
        );


      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> jsonList = response.data['data'];
        _roundRobinGroups = jsonList
            .map((e) => RoundRobinGroup.fromJson(e))
            .toList();
      } else {
        _error = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      _error = 'Error fetching data: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
