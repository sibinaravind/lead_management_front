// import 'package:get/get.dart';

// import '../../core/services/api_service.dart';
// import '../../core/services/optimized_http_service.dart';
// import '../../core/shared/constants.dart';
// import '../../model/lead/academic_record_model.dart';
// import '../../model/lead/call_event_model.dart';
// import '../../model/lead/document_record_model.dart';
// import '../../model/lead/exam_record_model.dart';
// import '../../model/lead/lead_list_model.dart';
// import '../../model/lead/lead_model.dart';
// import '../../model/lead/travel_record_model.dart';
// import '../../model/lead/work_record_model.dart';
// import '../../view/widgets/custom_toast.dart';

// class RegistrationController extends GetxController {
//   final ApiService _apiService = ApiService();
//   Rx<LeadListModel> customerMatchingList = LeadListModel().obs;
//   RxBool isLoading = false.obs;
//   String? errorMessage;

//   Map<String, dynamic> filter = {};
//   RxList<CallEventModel> callEvents = <CallEventModel>[].obs;
//   String? selectedVacancyId;
//   Rx<LeadModel> leadDetails = LeadModel().obs;
//   String currentClientId = "";

//   Future<void> fetchMatchingClients(
//       {Map<String, dynamic>? filterSelected}) async {
//     filter = filterSelected ?? {};
//     isLoading.value = true;
//     try {
//       final response = await _apiService.getRequest(
//           endpoint: Constant().getIncompleteList,
//           params: filter,
//           fromJson: (json) => LeadListModel.fromJson(json));
//       response.fold(
//         (failure) {
//           throw Exception("Failed to load clients");
//         },
//         (loadedClients) {
//           customerMatchingList.value = loadedClients;
//         },
//       );
//     } catch (e) {
//       throw Exception('Error fetching clients: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> getCustomerDetails(context, String leadId) async {
//     try {
//       leadDetails.value = LeadModel();
//       final response = await _apiService.getRequest(
//           endpoint: "${Constant().getLeadDetail}/$leadId",
//           fromJson: (json) => LeadModel.fromJson(json));
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedLeadDetails) {
//           leadDetails.value = loadedLeadDetails;
//           currentClientId = loadedLeadDetails.id ?? '';
//           refresh();
//         },
//       );
//     } catch (e) {
//       CustomToast.showToast(
//         context: context,
//         message: 'Error : $e',
//       );
//     } finally {
//       // notifyListeners();
//     }
//   }

//   Future<bool> updatePersonalDetails(
//       {required LeadModel lead, required String customerId}) async {
//     try {
//       // final response = await _apiService.patchRequest(
//       //     endpoint: '${Constant().updatePersonalDetails}/$customerId',
//       //     body: lead.toPersonalDetailsJson(),
//       //     fromJson: (json) => json);
//       // response.fold(
//       //   (failure) {
//       //     throw Exception(failure);
//       //   },
//       //   (loadedClients) {
//       //     leadDetails.value.name = lead.name;
//       //     leadDetails.value.email = lead.email;
//       //     leadDetails.value.emailPassword = lead.emailPassword;
//       //     leadDetails.value.phone = lead.phone;
//       //     leadDetails.value.countryCode = lead.countryCode;
//       //     leadDetails.value.emergencyContact = lead.emergencyContact;
//       //     leadDetails.value.alternatePhone = lead.alternatePhone;
//       //     leadDetails.value.whatsapp = lead.whatsapp;
//       //     leadDetails.value.gender = lead.gender;
//       //     leadDetails.value.dob = lead.dob;
//       //     leadDetails.value.maritalStatus = lead.maritalStatus;
//       //     leadDetails.value.country = lead.country;
//       //     leadDetails.value.address = lead.address;
//       //     leadDetails.value.birthPlace = lead.birthPlace;
//       //     leadDetails.value.birthCountry = lead.birthCountry;
//       //     leadDetails.value.religion = lead.religion;
//       //     leadDetails.value.passportNumber = lead.passportNumber;
//       //     leadDetails.value.passportExpiryDate = lead.passportExpiryDate;
//       //     leadDetails.value.note = lead.note;
//       //     leadDetails.value.onCallCommunication = lead.onCallCommunication;
//       //     leadDetails.value.whatsappCommunication = lead.whatsappCommunication;
//       //     leadDetails.value.emailCommunication = lead.emailCommunication;
//       //     leadDetails.value.countryInterested = lead.countryInterested;
//       //     // Add more fields as needed based on your LeadModel

//       //     return true;
//       //   },
//       // );
//     } catch (e) {
//       errorMessage = 'Error : $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<bool> updateAcademicDetails(
//       {required List<AcademicRecordModel> data,
//       required String customerId}) async {
//     try {
//       final response = await _apiService.postRequest(
//           endpoint: '${Constant().updateAcademicRecords}/$customerId',
//           body: data.map((e) => e.toJson()).toList(),
//           fromJson: (json) => json);
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedClients) {
//           leadDetails.value.academicRecords = data;
//           // customerMatchingList.value = loadedClients;
//           return true;
//         },
//       );
//     } catch (e) {
//       errorMessage = 'Error : $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<bool> updateExamRecords(
//       {required List<ExamRecordModel> data, required String customerId}) async {
//     try {
//       final response = await _apiService.postRequest(
//           endpoint: '${Constant().updateExamRecords}/$customerId',
//           body: data.map((e) => e.toJson()).toList(),
//           fromJson: (json) => json);
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedClients) {
//           leadDetails.value.examRecords = data;
//           // customerMatchingList.value = loadedClients;
//           return true;
//         },
//       );
//     } catch (e) {
//       errorMessage = ': $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<bool> updateWorkRecords(
//       {required List<WorkRecordModel> data, required String customerId}) async {
//     try {
//       final response = await _apiService.postRequest(
//           endpoint: '${Constant().updateWorkRecords}/$customerId',
//           body: data.map((e) => e.toJson()).toList(),
//           fromJson: (json) => json);
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedClients) {
//           leadDetails.value.workRecords = data;
//           // customerMatchingList.value = loadedClients;
//           return true;
//         },
//       );
//     } catch (e) {
//       errorMessage = 'Error : $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<bool> updateTravelHistory(
//       {required List<TravelRecordModel> data,
//       required String customerId}) async {
//     try {
//       final response = await _apiService.postRequest(
//           endpoint: '${Constant().updateTravelHistory}/$customerId',
//           body: data.map((e) => e.toJson()).toList(),
//           fromJson: (json) => json);
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedClients) {
//           leadDetails.value.travelRecords = data;
//           // customerMatchingList.value = loadedClients;
//           return true;
//         },
//       );
//     } catch (e) {
//       errorMessage = 'Error : $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<bool> setRequiredDocuments({
//     required List<DocumentRecordModel> data,
//   }) async {
//     try {
//       final response = await _apiService.postRequest(
//           endpoint: '${Constant().setRequiredDocuments}/$currentClientId',
//           body: data.map((e) => e.toJson()).toList(),
//           fromJson: (json) => json);
//       response.fold(
//         (failure) {
//           throw Exception(failure);
//         },
//         (loadedClients) {
//           leadDetails.value.documents = data;
//           // customerMatchingList.value = loadedClients;
//           return true;
//         },
//       );
//     } catch (e) {
//       errorMessage = 'Error : $e';
//       return false;
//       // throw Exception('Error fetching clients: $e');
//     }
//     return true;
//   }

//   Future<String> updateClientRequiredDocuments({
//     required String docType,
//     required String base64String,
//   }) async {
//     try {
//       print("📤 Uploading document => $docType");

//       final response = await OptimizedHttpService().postDocumentUpload(
//         endpoint:
//             '${Constant().updateClientRequiredDocuments}/$currentClientId',
//         body: {"doc_type": docType, "base64": base64String},
//         fromJson: (json) => json,
//       );

//       print("📥 Raw API response: $response");

//       // Ensure fold result is actually returned
//       return response.fold(
//         (failure) {
//           return "false";
//         },
//         (loadedClients) {
//           // If your API returns the filePath, pass that instead of just "true"
//           return loadedClients["file_path"];
//         },
//       );
//     } catch (e, st) {
//       // print("🔥 Exception during upload: $e");
//       // print(st);
//       errorMessage = 'Error : $e';
//       return "false";
//     }
//   }
// }

// // import 'package:flutter/widgets.dart';

// // import 'package:overseas_front_end/model/lead/lead_model.dart';

// // import '../../core/services/api_service.dart';
// // import '../../core/shared/constants.dart';

// // class RegistrationController extends ChangeNotifier {
// //   RegistrationController._privateConstructor();
// //   static final RegistrationController _instance =
// //       RegistrationController._privateConstructor();
// //   factory RegistrationController() => _instance;

// //   String selectedCategory = 'all';
// //   bool isFilterActive = false;
// //   bool showFilters = false;

// //   ApiService _apiService = ApiService();

// //   List<LeadModel> leads = [];

// //   List<LeadModel> filteredLeads = [];

// //   void setSelectedCategory(String category) {
// //     selectedCategory = category;
// //     notifyListeners();
// //   }

// //   void setIsFilterActive(bool value) {
// //     isFilterActive = value;
// //     notifyListeners();
// //   }

// //   void setShowFilters(bool value) {
// //     showFilters = value;
// //     notifyListeners();
// //   }

// //   Future<void> fetchRegistration(
// //     context,
// //   ) async {
// //     // _isLoading = true;
// //     notifyListeners();
// //     try {
// //       final response =
// //           await _apiService.get(context: context, Constant().getIncompleteList);

// //       if (response['success']) {
// //         final List<LeadModel> loadedLeads = [];

// //         for (var item in response['data']) {
// //           loadedLeads.add(LeadModel.fromJson(item));
// //         }

// //         leads = loadedLeads;
// //         filteredLeads = loadedLeads; // Initialize filtered list
// //       } else {
// //         throw Exception("Failed to load clients");
// //       }
// //     } catch (e) {
// //       throw Exception('Error fetching clients: $e');
// //     } finally {
// //       // _isLoading = false;
// //       notifyListeners();
// //     }
// //   }

// //   Future<bool> addAcademicRecords(context,
// //       {required List<Map<String, dynamic>> educationList,
// //       required String leadId}) async {
// //     notifyListeners();
// //     try {
// //       final response = await _apiService.post(
// //           context: context,
// //           "${Constant().updateAcademicRecords}/$leadId",
// //           {},
// //           listData: educationList);
// //       return response['success'] == true;
// //     } catch (e) {
// //       return false;
// //     } finally {
// //       notifyListeners();
// //     }
// //   }

// //   Future<bool> editRegistration(context, Map<String, dynamic> updatedData,
// //       {required String clientId}) async {
// //     notifyListeners();
// //     try {
// //       final response = await _apiService.patch(
// //         context: context,
// //         '${Constant().editRegistration}/$clientId',
// //         updatedData,
// //       );
// //       if (response['success'] == true) {
// //         return true;
// //       }
// //     } catch (e) {
// //       print('Error restoring client officer: $e');
// //     }
// //     notifyListeners();
// //     return false;
// //   }
// // }
