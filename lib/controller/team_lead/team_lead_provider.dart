// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/officer/officer_model.dart';
// import 'package:overseas_front_end/model/team_lead/team_lead_model.dart';

// import '../../core/services/api_service.dart';
// import '../../core/shared/constants.dart';

// class TeamLeadProvider with ChangeNotifier {
//   TeamLeadProvider._privateConstructor();
//   static final _instance = TeamLeadProvider._privateConstructor();
//   factory TeamLeadProvider() {
//     return _instance;
//   }

//   final ApiService _apiService = ApiService();

//   List<TeamLeadModel>? _teamLeadListData;

//   List<TeamLeadModel>? assignedEmployees = [];

//   List<TeamLeadModel>? remainingEmployees = [];
//   List<TeamLeadModel>? allRemainingEmployees = [];

//   // List<SubOfficerModel> selectedClients = [];

//   bool _isLoading = false;
//   String? _error;

//   // List<OfficersModel>? get officersListModel => _officersListData;
//   List<TeamLeadModel>? get teamListListModel => _teamLeadListData;

//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   // void _filterClients(String query) {
//   //   filteredClients = allClients
//   //       .where((client) =>
//   //           client.name?.toLowerCase().contains(query.toLowerCase()) ||
//   //           client.id.toLowerCase().contains(query.toLowerCase()))
//   //       .where((client) =>
//   //           !selectedClients.any((selected) => selected['id'] == client['id']))
//   //       .toList();
//   //   notifyListeners();
//   // }

//   void setSearchQuery(String query) {
//     // _searchQuery = query.trim().toLowerCase();

//     // if (_teamLeadListData == null) return;

//     // _filteredTeamLeadList = _teamLeadListData!.where((officer) {
//     //   final employeeName = officer.name.toLowerCase() ?? '';
//     //   final phone = officer.phone.toLowerCase() ?? '';
//     //   final employeePhone = officer.companyPhoneNumber.toLowerCase() ?? '';
//     //   return employeeName.contains(_searchQuery) ||
//     //       employeePhone.contains(_searchQuery) ||
//     //       phone.contains(_searchQuery);
//     // }).toList();

//     // _filteredTeamLeadList!.sort((a, b) {
//     //   final aId = int.tryParse(a.officerId ?? '') ?? 0;
//     //   final bId = int.tryParse(b.officerId ?? '') ?? 0;
//     //   return aId.compareTo(bId);
//     // });

//     notifyListeners();
//   }

//   void filterEmployees(String str) {
//     print(str);
//     remainingEmployees = allRemainingEmployees;

//     remainingEmployees = remainingEmployees
//             ?.where(
//               (element) =>
//                   (element.officerId
//                           ?.toLowerCase()
//                           .contains(str.toLowerCase()) ??
//                       false) ||
//                   (element.name?.toLowerCase().contains(str.toLowerCase()) ??
//                       false),
//             )
//             .toList() ??
//         [];

//     notifyListeners();
//   }

//   void clearEmployees() {}

//   Future<void> addOfficerToLead(context,
//       {required String leadOfficerId,
//       required String officerId,
//       required String staffId}) async {
//     _isLoading = true;
//     _error = null;

//     try {
//       final response = await _apiService
//           .patch(context: context, Constant().addOfficerToLead, {
//         "lead_officer_id": leadOfficerId,
//         "officer": {
//           "officer_id": officerId,
//           "staff_id": staffId,
//           "edit_permission": false
//         }
//       });
//       if (response['success'] == true) {
//         fetchTeamLeadList(
//           context,
//         );
//         notifyListeners();
//       }
//     } catch (e) {
//       _error = 'Failed to load permissions: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void deleteOfficerFromLead(context,
//       {required String leadOfficerId, required String officerId}) async {
//     _isLoading = true;
//     _error = null;

//     try {
//       final response = await _apiService
//           .patch(context: context, Constant().deleteOfficerFromLead, {
//         "lead_officer_id": leadOfficerId,
//         "officer_id": officerId,
//       });
//       if (response['success'] == true) {
//         notifyListeners();
//       }
//     } catch (e) {
//       _error = 'Failed to load permissions: $e';
//     } finally {
//       _isLoading = false;
//       fetchTeamLeadList(
//         context,
//       );
//       notifyListeners();
//     }
//   }

//   void getAllRemainingEmpoyees(
//       context, String id, List<TeamLeadModel> officersList) {
//     List listIds = [];
//     listIds = _teamLeadListData
//             ?.where((element) => element.officerId == id)
//             .expand((e) => e.officers?.map((e) => e.sId) ?? [])
//             .toList() ??
//         [];
//     // _teamLeadListData.add(officersList.where((element) => element.id == id,));
//     List<TeamLeadModel> li = officersList
//         .where(
//           (element) => !listIds.contains(element.sId),
//         )
//         .toList();
//     _teamLeadListData?.addAll(officersList.where(
//       (element) => listIds.contains(element.sId),
//     ));
//     remainingEmployees = li;
//     allRemainingEmployees = li;
//     notifyListeners();
//   }

//   Future<void> fetchTeamLeadList(
//     context,
//   ) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       dynamic json =
//           await _apiService.get(context: context, Constant().teamLeadList);

//       if (json['success'] == true && json['data'] != null) {
//         final List<dynamic> dataList = json['data'];
//         _teamLeadListData =
//             dataList.map((e) => TeamLeadModel.fromJson(e)).toList();
//         notifyListeners();
//       } else {
//         _error = 'Invalid response structure';
//       }
//     } catch (e) {
//       _error = "Failed to load lead officers: $e";
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<bool> createOfficer(context, Map<String, dynamic> officer) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _apiService.post(
//           context: context, Constant().officerInsert, officer);

//       if (response['success'] == true) {
//         await fetchTeamLeadList(
//           context,
//         );
//         return true;
//       } else {
//         _error = response['message'] ?? 'Creation failed';
//         return false;
//       }
//     } catch (e) {
//       _error = 'Error creating officer: $e';
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
