import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/model/lead/count_model.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import 'package:overseas_front_end/view/screens/leads/lead_data_display.dart';
import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/lead/lead_list_model.dart';

class LeadController extends GetxController {
  final ApiService _apiService = ApiService();
  RxString selectedBusinessType = ''.obs;
  RxString filterStatus = ''.obs;
  RxString leadStatistics = ''.obs;
  RxString filterPriority = ''.obs;
  RxList<Lead> filteredLeads = <Lead>[].obs;
  Rx<LeadListModel> customerMatchingList = LeadListModel().obs;
  RxBool isLoading = false.obs;
  RxString selectedFilter = ''.obs;
  Map<String, dynamic> filter = {};
  Rx<CountModel> leadCount = CountModel().obs;

  Future<void> fetchMatchingClients(
      {Map<String, dynamic>? filterSelected}) async {
    filter = filterSelected ?? {};
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().getAllFilterdLeads,
          params: filter,
          fromJson: (json) => LeadListModel.fromJson(json));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          customerMatchingList.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMatchingHistoricalClients(
      {Map<String, dynamic>? filterSelected}) async {
    filter = filterSelected ?? {};
    isLoading.value = true;
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().getAllFilterdHistory,
          params: filter,
          fromJson: (json) => LeadListModel.fromJson(json));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          customerMatchingList.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLeadCount({String? category, String? employeeid}) async {
    try {
      final response = await _apiService.getRequest(
          endpoint: Constant().getLeadCount,
          params: filter,
          fromJson: (json) => CountModel.fromJson(json));
      response.fold(
        (failure) {
          throw Exception("Failed to load clients");
        },
        (loadedClients) {
          leadCount.value = loadedClients;
        },
      );
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createLead(BuildContext context, LeadModel leads) async {
    try {
      final response = await _apiService.postRequest(
        endpoint: Constant().addLead,
        body: leads.toJson()..removeWhere((key, value) => value == null),
        fromJson: (json) => json,
      );
      return response.fold(
        (failure) {
          throw Exception("Failed to create Lead: $failure");
        },
        (createdLead) {
          leads.sId = createdLead;
          if (selectedFilter.value == '' || selectedFilter.value == 'NEW') {
            customerMatchingList.value.leads?.add(leads);
            refresh();
          }
          Navigator.of(context).pop();
          CustomSnackBar.showMessage("Success", "Lead created successfully",
              backgroundColor: Colors.green);

          return true;
        },
      );
    } catch (e) {
      CustomSnackBar.showMessage("Error", "Failed to create Lead: $e",
          backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}












// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/lead/call_event_model.dart';

// import '../../core/services/api_service.dart';
// import '../../core/services/user_cache_service.dart';
// import '../../core/shared/constants.dart';
// import '../../model/lead/lead_model.dart';

// class LeadProvider extends ChangeNotifier {
//   LeadProvider._privateConstructor();
//   static final _instance = LeadProvider._privateConstructor();
//   factory LeadProvider() => _instance;

//   bool showFilters = false;
//   int? selectedIndex;
//   bool isFilterActive = false;
//   String currentClientId = "";

//   TextEditingController searchController = TextEditingController();
//   var itemsPerPage = "10";
//   var currentPage = 0;
//   String selectedFilter = 'all';

//   void setShowFilter(val) {
//     showFilters = val;
//     notifyListeners();
//   }

//   void setFilterActive(val) {
//     isFilterActive = val;
//     notifyListeners();
//   }

//   List<LeadModel> leadModel = [];
//   List<LeadModel> deadLeadModel = [];

//   List<LeadModel> allLeadModel = [];
//   List<LeadModel> allDeadLeadModel = [];

//   LeadModel? leadDetails;

//   final ApiService _api = ApiService();

//   List<LeadModel>? userList = [];
//   bool isLoading = false;

//   List<CallEventModel> callEvents = [];

//   setSelectedFilter(String filter) {
//     selectedFilter = filter;
//     notifyListeners();
//   }

//   // void filterEmployees(String str) {
//   //   print(str);
//   //   if (str.isEmpty) {
//   //     leadModel = allLeadModel;
//   //   }

//   //   leadModel = leadModel
//   //           ?.where(
//   //             (element) =>
//   //                 (element.email?.toLowerCase().contains(str.toLowerCase()) ??
//   //                     false) ||
//   //                 (element.name?.toLowerCase().contains(str.toLowerCase()) ??
//   //                     false),
//   //           )
//   //           .toList() ??
//   //       [];

//   //   notifyListeners();
//   // }

//   Future<void> getLeadList(context) async {
//     // notifyListeners();

//     try {
//       final response = await _api.get(context: context, Constant().allLeads);
//       leadModel = List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//       allLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//     } catch (e) {
//       print('Error fetching lead list: $e');
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<void> getDeadLeadList(context) async {
//     // notifyListeners();

//     try {
//       final response =
//           await _api.get(context: context, Constant().getDeadLeads);
//       deadLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//       allDeadLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//     } catch (e) {
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<void> getLeadDetails(context, String leadId) async {
//     // notifyListeners();

//     try {
//       final response = await _api.get(
//           context: context, "${Constant().getLeadDetail}/$leadId");
//       leadDetails = LeadModel.fromJson(response['data']);
//       currentClientId = leadDetails?.sId ?? '';
//       fetchCallEvents(
//         context,
//       );
//     } catch (e) {
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<bool> addLead(
//     context, {
//     required String name,
//     required String email,
//     required String phone,
//     required String alternatePhone,
//     required String whatsapp,
//     required String gender,
//     required String dob,
//     required String matrialStatus,
//     required String address,
//     required String city,
//     required String state,
//     required String country,
//     required List<String> jobInterests,
//     required List<String> countryInterested,
//     required int expectedSalary,
//     required String qualification,
//     required String university,
//     required String passingYear,
//     required int experience,
//     required List<String> skills,
//     required String profession,
//     required List<String> specializedIn,
//     required String leadSource,
//     required String comment,
//     required bool onCallCommunication,
//     required bool onWhatsappCommunication,
//     required bool onEmailCommunication,
//     required String status,
//     required String serviceType,
//     required String branchName,
//     required String countryPhoneCode,
//   }) async {
//     notifyListeners();
//     String officerId = (await UserCacheService().getUser())?.id ?? "";
//     try {
//       final response = await _api.post(context: context, Constant().addLead, {
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "alternate_phone": alternatePhone,
//         "whatsapp": whatsapp,
//         "gender": gender,
//         "dob": dob,
//         "country_code": countryPhoneCode,
//         "matrial_status": matrialStatus,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country": country,
//         "job_interests": jobInterests,
//         "country_interested": countryInterested,
//         "expected_salary": expectedSalary,
//         "qualification": qualification,
//         // "university": university,
//         // "passing_year": passingYear,
//         "experience": experience,
//         "skills": skills,
//         "profession": profession,
//         "specialized_in": specializedIn,
//         "lead_source": leadSource,
//         "note": comment,
//         "on_call_communication": onCallCommunication,
//         "on_whatsapp_communication": onWhatsappCommunication,
//         "on_email_communication": onEmailCommunication,
//         "status": status,
//         "service_type": serviceType,
//         "branch": branchName,
//         "officer_id": officerId
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       getLeadList(
//         context,
//       );
//       notifyListeners();
//     }
//   }

//   Future<bool> updateLead(
//     context, {
//     required String countryPhoneCode,
//     required String leadId,
//     required String name,
//     required String email,
//     required String phone,
//     required String alternatePhone,
//     required String whatsapp,
//     required String gender,
//     required String dob,
//     required String matrialStatus,
//     required String address,
//     required String city,
//     required String state,
//     required String country,
//     required List<String> jobInterests,
//     required List<String> countryInterested,
//     required int expectedSalary,
//     required String qualification,
//     required String university,
//     required String passingYear,
//     required int experience,
//     required List<String> skills,
//     required String profession,
//     required List<String> specializedIn,
//     required String leadSource,
//     required String comment,
//     required bool onCallCommunication,
//     required bool onWhatsappCommunication,
//     required bool onEmailCommunication,
//     required String status,
//     required String serviceType,
//     required String branchName,
//   }) async {
//     notifyListeners();

//     try {
//       final response = await _api
//           .patch(context: context, "${Constant().updateLead}/$leadId", {
//         "name": name,
//         "country_code": countryPhoneCode,
//         "email": email,
//         "phone": phone,
//         "alternate_phone": alternatePhone,
//         "whatsapp": whatsapp,
//         "gender": gender,
//         "dob": dob,
//         "matrial_status": matrialStatus,
//         "address": address,
//         "city": city,
//         "state": state,

//         "country": country,
//         "job_interests": jobInterests,
//         "country_interested": countryInterested,
//         "expected_salary": expectedSalary,
//         "qualification": qualification,
//         // "university": university,
//         // "passing_year": passingYear,
//         "experience": experience,
//         "skills": skills,
//         "profession": profession,
//         "specialized_in": specializedIn,
//         "lead_source": leadSource,
//         "note": comment,
//         "on_call_communication": onCallCommunication,
//         "on_whatsapp_communication": onWhatsappCommunication,
//         "on_email_communication": onEmailCommunication,
//         "status": status,
//         "service_type": serviceType,
//         "branch": branchName,
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<bool> addFeedback(
//     context, {
//     required String clientId,
//     required String duration,
//     required String nextScheduleDate,
//     required String nextScheduleTime,
//     required String clientStatus,
//     required String comment,
//     required String callType,
//     required String callStatus,
//   }) async {
//     String officerId = (await UserCacheService().getUser())?.id ?? '';
//     notifyListeners();

//     try {
//       final response =
//           await _api.post(context: context, Constant().addFeedback, {
//         // "officer_id": officerId,
//         "client_id": clientId,
//         "duration": duration,
//         "next_schedule": nextScheduleDate,
//         "next_shedule_time": nextScheduleTime,
//         "client_status": clientStatus,
//         "comment": comment,
//         "call_type": callType,
//         "call_status": callStatus
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       getLeadList(context);
//       notifyListeners();
//     }
//   }

//   Future<void> restoreDeadLead(
//       context, Map<String, dynamic> updatedData) async {
//     try {
//       final response = await _api.patch(
//         context: context,
//         '${Constant().restoreDeadLead}',
//         updatedData,
//       );
//       if (response['success'] == true) {}
//     } catch (e) {
//       print('Error restoring client officer: $e');
//     }
//     getDeadLeadList(context);
//     notifyListeners();
//   }

//   Future<void> fetchCallEvents(
//     context,
//   ) async {
//     notifyListeners();
//     // var officerId = (await OfficerCacheService().officer)?.id ?? "";
//     try {
//       final response = await _api.get(
//           context: context, "${Constant().callEventList}/$currentClientId");

//       if (response['success']) {
//         callEvents =
//             List.from(response['data'].map((e) => CallEventModel.fromJson(e)));
//       } else {
//         throw Exception("Failed to load projects");
//       }
//     } catch (e) {
//       throw Exception('Error fetching projects: $e');
//     } finally {
//       notifyListeners();
//     }
//   }

//   // void updatePageSize(String size) {
//   //   itemsPerPage.value = size;
//   //   currentPage.value = 0;
//   //   fetchData(search: searchController.text);
//   // }

//   void onPageSelected(int page) {
//     currentPage = page;
//     // fetchData(search: searchController.text);
//   }

//   void clearSearch() {
//     searchController.clear();
//     // fetchData();
//   }

//   void onSearchSubmitted() {
//     currentPage = 0;
//     // fetchData(search: searchController.text);
//   }

//   // UserModel getUserDetails() {
//   //   if (userModel != null) {
//   //     return userModel ?? const UserModel();
//   //   }
//   //   userModel = serviceLocator<UserCacheService>().getUser();
//   //   return userModel ?? const UserModel();
//   // }
// }





// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/model/lead/call_event_model.dart';

// import '../../core/services/api_service.dart';
// import '../../core/services/user_cache_service.dart';
// import '../../core/shared/constants.dart';
// import '../../model/lead/lead_model.dart';

// class LeadProvider extends ChangeNotifier {
//   LeadProvider._privateConstructor();
//   static final _instance = LeadProvider._privateConstructor();
//   factory LeadProvider() => _instance;

//   bool showFilters = false;
//   int? selectedIndex;
//   bool isFilterActive = false;
//   String currentClientId = "";

//   TextEditingController searchController = TextEditingController();
//   var itemsPerPage = "10";
//   var currentPage = 0;
//   String selectedFilter = 'all';

//   void setShowFilter(val) {
//     showFilters = val;
//     notifyListeners();
//   }

//   void setFilterActive(val) {
//     isFilterActive = val;
//     notifyListeners();
//   }

//   List<LeadModel> leadModel = [];
//   List<LeadModel> deadLeadModel = [];

//   List<LeadModel> allLeadModel = [];
//   List<LeadModel> allDeadLeadModel = [];

//   LeadModel? leadDetails;

//   final ApiService _api = ApiService();

//   List<LeadModel>? userList = [];
//   bool isLoading = false;

//   List<CallEventModel> callEvents = [];

//   setSelectedFilter(String filter) {
//     selectedFilter = filter;
//     notifyListeners();
//   }

//   // void filterEmployees(String str) {
//   //   print(str);
//   //   if (str.isEmpty) {
//   //     leadModel = allLeadModel;
//   //   }

//   //   leadModel = leadModel
//   //           ?.where(
//   //             (element) =>
//   //                 (element.email?.toLowerCase().contains(str.toLowerCase()) ??
//   //                     false) ||
//   //                 (element.name?.toLowerCase().contains(str.toLowerCase()) ??
//   //                     false),
//   //           )
//   //           .toList() ??
//   //       [];

//   //   notifyListeners();
//   // }

//   Future<void> getLeadList(context) async {
//     // notifyListeners();

//     try {
//       final response = await _api.get(context: context, Constant().allLeads);
//       leadModel = List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//       allLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//     } catch (e) {
//       print('Error fetching lead list: $e');
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<void> getDeadLeadList(context) async {
//     // notifyListeners();

//     try {
//       final response =
//           await _api.get(context: context, Constant().getDeadLeads);
//       deadLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//       allDeadLeadModel =
//           List.from(response['data'].map((e) => LeadModel.fromJson(e)));
//     } catch (e) {
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<void> getLeadDetails(context, String leadId) async {
//     // notifyListeners();

//     try {
//       final response = await _api.get(
//           context: context, "${Constant().getLeadDetail}/$leadId");
//       leadDetails = LeadModel.fromJson(response['data']);
//       currentClientId = leadDetails?.sId ?? '';
//       fetchCallEvents(
//         context,
//       );
//     } catch (e) {
//     } finally {
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   Future<bool> addLead(
//     context, {
//     required String name,
//     required String email,
//     required String phone,
//     required String alternatePhone,
//     required String whatsapp,
//     required String gender,
//     required String dob,
//     required String matrialStatus,
//     required String address,
//     required String city,
//     required String state,
//     required String country,
//     required List<String> jobInterests,
//     required List<String> countryInterested,
//     required int expectedSalary,
//     required String qualification,
//     required String university,
//     required String passingYear,
//     required int experience,
//     required List<String> skills,
//     required String profession,
//     required List<String> specializedIn,
//     required String leadSource,
//     required String comment,
//     required bool onCallCommunication,
//     required bool onWhatsappCommunication,
//     required bool onEmailCommunication,
//     required String status,
//     required String serviceType,
//     required String branchName,
//     required String countryPhoneCode,
//   }) async {
//     notifyListeners();
//     String officerId = (await UserCacheService().getUser())?.id ?? "";
//     try {
//       final response = await _api.post(context: context, Constant().addLead, {
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "alternate_phone": alternatePhone,
//         "whatsapp": whatsapp,
//         "gender": gender,
//         "dob": dob,
//         "country_code": countryPhoneCode,
//         "matrial_status": matrialStatus,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country": country,
//         "job_interests": jobInterests,
//         "country_interested": countryInterested,
//         "expected_salary": expectedSalary,
//         "qualification": qualification,
//         // "university": university,
//         // "passing_year": passingYear,
//         "experience": experience,
//         "skills": skills,
//         "profession": profession,
//         "specialized_in": specializedIn,
//         "lead_source": leadSource,
//         "note": comment,
//         "on_call_communication": onCallCommunication,
//         "on_whatsapp_communication": onWhatsappCommunication,
//         "on_email_communication": onEmailCommunication,
//         "status": status,
//         "service_type": serviceType,
//         "branch": branchName,
//         "officer_id": officerId
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       getLeadList(
//         context,
//       );
//       notifyListeners();
//     }
//   }

//   Future<bool> updateLead(
//     context, {
//     required String countryPhoneCode,
//     required String leadId,
//     required String name,
//     required String email,
//     required String phone,
//     required String alternatePhone,
//     required String whatsapp,
//     required String gender,
//     required String dob,
//     required String matrialStatus,
//     required String address,
//     required String city,
//     required String state,
//     required String country,
//     required List<String> jobInterests,
//     required List<String> countryInterested,
//     required int expectedSalary,
//     required String qualification,
//     required String university,
//     required String passingYear,
//     required int experience,
//     required List<String> skills,
//     required String profession,
//     required List<String> specializedIn,
//     required String leadSource,
//     required String comment,
//     required bool onCallCommunication,
//     required bool onWhatsappCommunication,
//     required bool onEmailCommunication,
//     required String status,
//     required String serviceType,
//     required String branchName,
//   }) async {
//     notifyListeners();

//     try {
//       final response = await _api
//           .patch(context: context, "${Constant().updateLead}/$leadId", {
//         "name": name,
//         "country_code": countryPhoneCode,
//         "email": email,
//         "phone": phone,
//         "alternate_phone": alternatePhone,
//         "whatsapp": whatsapp,
//         "gender": gender,
//         "dob": dob,
//         "matrial_status": matrialStatus,
//         "address": address,
//         "city": city,
//         "state": state,

//         "country": country,
//         "job_interests": jobInterests,
//         "country_interested": countryInterested,
//         "expected_salary": expectedSalary,
//         "qualification": qualification,
//         // "university": university,
//         // "passing_year": passingYear,
//         "experience": experience,
//         "skills": skills,
//         "profession": profession,
//         "specialized_in": specializedIn,
//         "lead_source": leadSource,
//         "note": comment,
//         "on_call_communication": onCallCommunication,
//         "on_whatsapp_communication": onWhatsappCommunication,
//         "on_email_communication": onEmailCommunication,
//         "status": status,
//         "service_type": serviceType,
//         "branch": branchName,
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<bool> addFeedback(
//     context, {
//     required String clientId,
//     required String duration,
//     required String nextScheduleDate,
//     required String nextScheduleTime,
//     required String clientStatus,
//     required String comment,
//     required String callType,
//     required String callStatus,
//   }) async {
//     String officerId = (await UserCacheService().getUser())?.id ?? '';
//     notifyListeners();

//     try {
//       final response =
//           await _api.post(context: context, Constant().addFeedback, {
//         // "officer_id": officerId,
//         "client_id": clientId,
//         "duration": duration,
//         "next_schedule": nextScheduleDate,
//         "next_shedule_time": nextScheduleTime,
//         "client_status": clientStatus,
//         "comment": comment,
//         "call_type": callType,
//         "call_status": callStatus
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       getLeadList(context);
//       notifyListeners();
//     }
//   }

//   Future<void> restoreDeadLead(
//       context, Map<String, dynamic> updatedData) async {
//     try {
//       final response = await _api.patch(
//         context: context,
//         '${Constant().restoreDeadLead}',
//         updatedData,
//       );
//       if (response['success'] == true) {}
//     } catch (e) {
//       print('Error restoring client officer: $e');
//     }
//     getDeadLeadList(context);
//     notifyListeners();
//   }

//   Future<void> fetchCallEvents(
//     context,
//   ) async {
//     notifyListeners();
//     // var officerId = (await OfficerCacheService().officer)?.id ?? "";
//     try {
//       final response = await _api.get(
//           context: context, "${Constant().callEventList}/$currentClientId");

//       if (response['success']) {
//         callEvents =
//             List.from(response['data'].map((e) => CallEventModel.fromJson(e)));
//       } else {
//         throw Exception("Failed to load projects");
//       }
//     } catch (e) {
//       throw Exception('Error fetching projects: $e');
//     } finally {
//       notifyListeners();
//     }
//   }

//   // void updatePageSize(String size) {
//   //   itemsPerPage.value = size;
//   //   currentPage.value = 0;
//   //   fetchData(search: searchController.text);
//   // }

//   void onPageSelected(int page) {
//     currentPage = page;
//     // fetchData(search: searchController.text);
//   }

//   void clearSearch() {
//     searchController.clear();
//     // fetchData();
//   }

//   void onSearchSubmitted() {
//     currentPage = 0;
//     // fetchData(search: searchController.text);
//   }

//   // UserModel getUserDetails() {
//   //   if (userModel != null) {
//   //     return userModel ?? const UserModel();
//   //   }
//   //   userModel = serviceLocator<UserCacheService>().getUser();
//   //   return userModel ?? const UserModel();
//   // }
// }
