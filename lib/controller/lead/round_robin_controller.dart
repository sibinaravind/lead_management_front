import 'package:get/get.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../../core/services/api_service.dart';
import '../../core/services/navigation_service.dart';
import '../../model/lead/round_robin_group.dart';
import '../../model/officer/officer_model.dart';

class RoundRobinController extends GetxController {
  static RoundRobinController get to => Get.find();

  final ApiService _apiService = ApiService();

  var roundRobinGroups = <RoundRobinGroup>[].obs;
  var isLoading = false.obs;
  var error = RxnString();

  /// Fetch from API
  Future<void> fetchRoundRobinGroups() async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await _apiService.getRequest(
        endpoint: Constant().roundRobinList,
        fromJson: (dynamic json) {
          if (json is List) {
            return json.map((e) => RoundRobinGroup.fromJson(e)).toList();
          } else {
            throw Exception('Expected List but got ${json.runtimeType}');
          }
        },
      );

      response.fold(
        (failure) => error.value = 'Something went wrong. Please try again.',
        (data) => roundRobinGroups.value = data,
      );
    } catch (e) {
      error.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Add Officers (update locally)
  Future<bool> addOfficersToRoundRobin({
    required String roundRobinId,
    required List<OfficerModel> officer,
  }) async {
    try {
      // Find the group
      final index = roundRobinGroups.indexWhere((g) => g.id == roundRobinId);

      // If group exists, filter out already-present officers
      List<OfficerModel> officersToAdd = officer;
      if (index != -1) {
        final existingOfficerIds = roundRobinGroups[index]
            .officerDetails
            .map((o) => o.id)
            .whereType<String>()
            .toSet();

        officersToAdd =
            officer.where((o) => !existingOfficerIds.contains(o.id)).toList();
      }

      // If nothing new to add, return true (success)
      if (officersToAdd.isEmpty) {
        return true;
      }

      // Prepare request data
      final data = {
        "round_robin_id": roundRobinId,
        "officers": officersToAdd.map((o) => o.id).toList(),
      };

      // API request
      final response = await _apiService.patchRequest(
        endpoint: Constant().insertOfficersInToRoundRobinList,
        body: data,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error.value = 'Failed to add officers';
          return false;
        },
        (data) {
          // Update local state if group found
          if (index != -1) {
            final group = roundRobinGroups[index];
            final updatedOfficers =
                List<OfficerModel>.from(group.officerDetails)
                  ..addAll(
                    officersToAdd.map((officer) => OfficerModel(
                          id: officer.id,
                          name: officer.name,
                          phone: officer.phone,
                          companyPhoneNumber: officer.companyPhoneNumber,
                          branch: officer.branch,
                          designation: officer.designation,
                        )),
                  );
            roundRobinGroups[index] =
                group.copyWith(officerDetails: updatedOfficers);
          }
          return true;
        },
      );
    } catch (e) {
      error.value = 'Error adding officers: $e';
      return false;
    }
  }

  /// Remove Officers (update locally)
  Future<bool> removeOfficersFromRoundRobin({
    required String roundRobinId,
    required List<String> officerIds,
  }) async {
    try {
      final data = {
        "round_robin_id": roundRobinId,
        "officers": officerIds,
      };

      final response = await _apiService.patchRequest(
        endpoint: Constant().removeOfficersInToRoundRobinList,
        body: data,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error.value = 'Failed to remove officers';
          return false;
        },
        (data) {
          // 🔹 Update locally
          NavigationService.goBack();
          final index =
              roundRobinGroups.indexWhere((g) => g.id == roundRobinId);
          if (index != -1) {
            final group = roundRobinGroups[index];
            final updatedOfficers = group.officerDetails
                .where((o) => !officerIds.contains(o.id))
                .toList();
            roundRobinGroups[index] =
                group.copyWith(officerDetails: updatedOfficers);
          }
          return true;
          // NavigationService.goBack();
          // fetchRoundRobinGroups();
          // return true;
        },
      );
    } catch (e) {
      error.value = 'Error removing officers: $e';
      return false;
    }
  }

  Future<bool> createRoundRobin({
    required String name,
    required String country,
    List<OfficerModel> officers = const [],
  }) async {
    try {
      final data = {
        "name": name,
        "country": country,
        "officers": officers.map((o) => o.id).toList(),
      };

      final response = await _apiService.postRequest(
        endpoint: Constant().insertRoundRobin,
        body: data,
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error.value = 'Failed to create round robin';
          return false;
        },
        (data) {
          roundRobinGroups.add(RoundRobinGroup.fromJson({
            "_id": data['id'] ?? '',
            "name": name,
            "country": country,
            "officer_details": officers.map((o) => o.toJson()).toList(),
          }));

          return true;
        },
      );
    } catch (e) {
      error.value = 'Error creating round robin: $e';
      return false;
    }
  }

  /// Delete Round Robin (update locally)
  Future<bool> deleteRoundRobin(String roundRobinId) async {
    try {
      final response = await _apiService.deleteRequest(
        endpoint: "${Constant().deleteRoundRobin}/$roundRobinId",
        fromJson: (json) => json,
      );

      return response.fold(
        (failure) {
          error.value = 'Failed to delete round robin';
          return false;
        },
        (data) {
          roundRobinGroups.removeWhere((g) => g.id == roundRobinId);
          return true;
        },
      );
    } catch (e) {
      error.value = 'Error deleting round robin: $e';
      return false;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/shared/constants.dart';
// import '../../core/services/api_service.dart';
// import '../../model/lead/round_robin_group.dart';

// class RoundRobinProvider extends ChangeNotifier {
//   RoundRobinProvider._privateConstructor();
//   static final _instance = RoundRobinProvider._privateConstructor();
//   factory RoundRobinProvider() {
//     return _instance;
//   }

//   final ApiService _apiService = ApiService();

//   List<RoundRobinGroup> _roundRobinGroups = [];
//   bool _isLoading = false;
//   String? _error;

//   List<RoundRobinGroup> get roundRobinGroups => _roundRobinGroups;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchRoundRobinGroups(
//     context,
//   ) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       dynamic response =
//           await _apiService.get(context: context, Constant().roundRobinList
//               // options: Options(
//               //   headers: {
//               //     'Authorization': 'Bearer $token',
//               //   },
//               );

//       if (response['success'] && response['data'] != null) {
//         final List<dynamic> jsonList = response['data'];
//         _roundRobinGroups =
//             jsonList.map((e) => RoundRobinGroup.fromJson(e)).toList();
//       } else {
//         _error = 'Something went wrong. Please try again.';
//       }
//     } catch (e) {
//       _error = 'Error fetching data: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<bool> addOfficersToRoundRobin(
//     context, {
//     required String roundRobinId,
//     required List<String> officerIds,
//   }) async {
//     try {
//       final data = {
//         "round_robin_id": roundRobinId,
//         "officers": officerIds,
//       };

//       final response = await _apiService.patch(
//         context: context,
//         Constant().insertOfficersInToRoundRobinList,
//         data,
//       );

//       if (response['success'] == true) {
//         await fetchRoundRobinGroups(
//           context,
//         );
//         return true;
//       } else {
//         _error = 'Failed to add officers';
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _error = 'Error adding officers: $e';
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> removeOfficersFromRoundRobin(
//     context, {
//     required String roundRobinId,
//     required List<String> officerIds,
//   }) async {
//     try {
//       final data = {
//         "round_robin_id": roundRobinId,
//         "officers": officerIds,
//       };

//       final response = await _apiService.patch(
//         context: context,
//         Constant().removeOfficersInToRoundRobinList,
//         data,
//       );

//       if (response['success'] == true) {
//         await fetchRoundRobinGroups(
//           context,
//         );
//         return true;
//       } else {
//         _error = response['message'] ?? 'Failed to remove officers';
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _error = 'Error removing officers: $e';
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> createRoundRobin(
//     context, {
//     required String name,
//     required String country,
//     List<String> officerIds = const [],
//   }) async {
//     try {
//       final data = {
//         "name": name,
//         "country": country,
//         "officers": officerIds,
//       };

//       final response = await _apiService.post(
//         context: context,
//         Constant().insertRoundRobin,
//         data,
//       );

//       if (response['success'] == true) {
//         await fetchRoundRobinGroups(
//           context,
//         );
//         return true;
//       } else {
//         _error = response['message'] ?? 'Failed to create round robin';
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _error = 'Error creating round robin: $e';
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> deleteRoundRobin(context, String roundRobinId) async {
//     try {
//       final response = await _apiService.delete(
//           context: context, "${Constant().deleteRoundRobin}/$roundRobinId", {});

//       if (response['success'] == true) {
//         await fetchRoundRobinGroups(
//           context,
//         );
//         return true;
//       } else {
//         _error = response['message'] ?? 'Failed to delete round robin';
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _error = 'Error deleting round robin: $e';
//       notifyListeners();
//       return false;
//     }
//   }
// }
