import 'package:flutter/material.dart';
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

  Future<void> fetchRoundRobinGroups(
    context,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      dynamic response =
          await _apiService.get(context: context, Constant().roundRobinList
              // options: Options(
              //   headers: {
              //     'Authorization': 'Bearer $token',
              //   },
              );

      if (response['success'] && response['data'] != null) {
        final List<dynamic> jsonList = response['data'];
        _roundRobinGroups =
            jsonList.map((e) => RoundRobinGroup.fromJson(e)).toList();
      } else {
        _error = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      _error = 'Error fetching data: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addOfficersToRoundRobin(
    context, {
    required String roundRobinId,
    required List<String> officerIds,
  }) async {
    try {
      final data = {
        "round_robin_id": roundRobinId,
        "officers": officerIds,
      };

      final response = await _apiService.patch(
        context: context,
        Constant().insertOfficersInToRoundRobinList,
        data,
      );

      if (response['success'] == true) {
        await fetchRoundRobinGroups(
          context,
        );
        return true;
      } else {
        _error = 'Failed to add officers';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Error adding officers: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeOfficersFromRoundRobin(
    context, {
    required String roundRobinId,
    required List<String> officerIds,
  }) async {
    try {
      final data = {
        "round_robin_id": roundRobinId,
        "officers": officerIds,
      };

      final response = await _apiService.patch(
        context: context,
        Constant().removeOfficersInToRoundRobinList,
        data,
      );

      if (response['success'] == true) {
        await fetchRoundRobinGroups(
          context,
        );
        return true;
      } else {
        _error = response['message'] ?? 'Failed to remove officers';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Error removing officers: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createRoundRobin(
    context, {
    required String name,
    required String country,
    List<String> officerIds = const [],
  }) async {
    try {
      final data = {
        "name": name,
        "country": country,
        "officers": officerIds,
      };

      final response = await _apiService.post(
        context: context,
        Constant().insertRoundRobin,
        data,
      );

      if (response['success'] == true) {
        await fetchRoundRobinGroups(
          context,
        );
        return true;
      } else {
        _error = response['message'] ?? 'Failed to create round robin';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Error creating round robin: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteRoundRobin(context, String roundRobinId) async {
    try {
      final response = await _apiService.delete(
          context: context, "${Constant().deleteRoundRobin}/$roundRobinId", {});

      if (response['success'] == true) {
        await fetchRoundRobinGroups(
          context,
        );
        return true;
      } else {
        _error = response['message'] ?? 'Failed to delete round robin';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Error deleting round robin: $e';
      notifyListeners();
      return false;
    }
  }
}
