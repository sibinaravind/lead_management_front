import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/services/api_service.dart';
import 'package:overseas_front_end/model/campaign/campaign_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../core/shared/constants.dart';

class CampaignController extends GetxController {
  final ApiService _api = ApiService();

  RxList<CampaignModel> campaignList = <CampaignModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isPatching = false.obs;
  RxString? error = RxString('');

  Uint8List? imageBytes;
  String? file64;

  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController docNameController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getCampaignList();
  }

  Future<void> getCampaignList() async {
    isLoading.value = true;

    try {
      final response = await _api.getRequest(
        endpoint: Constant().camapignList,
        fromJson: (dynamic json) {
          if (json is List) {
            return json.map((e) => CampaignModel.fromJson(e)).toList();
          } else {
            throw Exception('Expected List but got ${json.runtimeType}');
          }
        },
      );
      response.fold(
        (failure) {
          error?.value = 'Failed to load campaigns:';
          CustomSnackBar.showMessage(
            "Error",
            "Failed to load campaigns",
            backgroundColor: AppColors.redSecondaryColor,
          );
        },
        (data) {
          campaignList.value = data;
        },
      );
    } catch (e) {
      error?.value = 'Failed to load campaigns: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void previewFile() {
    update();
  }

  Future<bool> deleteCampaign(BuildContext context, String id) async {
    isLoading.value = true;

    try {
      dynamic response = await _api.deleteRequest(
        endpoint: "${Constant().deleteCampaign}$id",
        body: {},
        fromJson: (json) => json,
      );
      response.fold(
        (failure) {
          error?.value = 'Failed to delete campaign:';
          CustomSnackBar.showMessage(
            "Error",
            "Failed to delete campaign",
            backgroundColor: AppColors.redSecondaryColor,
          );
          return false;
        },
        (data) {
          CustomSnackBar.showMessage(
            "Success",
            "Campaign deleted successfully",
            backgroundColor: AppColors.greenSecondaryColor,
          );
          return true;
        },
      );
      return false;
    } catch (e) {
      error?.value = 'Failed to delete campaign: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addCampaign(BuildContext context) async {
    final String title = titleController.text.trim();
    final String startDate = startDateController.text.trim();
    final String docName = docNameController.text.trim();

    try {
      final response = await _api.postRequest(
        endpoint: Constant().addCampaign,
        body: {
          "title": title,
          "startDate": startDate,
          "doc_file": {
            "name": docName,
            "base64": file64,
          },
        },
        fromJson: (json) => json,
      );
      response.fold(
        (failure) {
          error?.value = 'Failed to add campaign:';
          CustomSnackBar.showMessage(
            "Error",
            "Failed to add campaign",
            backgroundColor: AppColors.redSecondaryColor,
          );
          return false;
        },
        (data) {
          CustomSnackBar.showMessage(
            "Success",
            "Campaign added successfully",
            backgroundColor: AppColors.greenSecondaryColor,
          );
          return true;
        },
      );
      return false;
    } catch (e) {
      error?.value = 'Failed to add campaign: $e';
      return false;
    }
  }
}






// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/services/api_service.dart';
// import 'package:overseas_front_end/model/campaign/campaign_model.dart';

// import '../../core/shared/constants.dart';

// class CampaignProvider extends ChangeNotifier {
//   CampaignProvider._privateConstructor();
//   static final _instance = CampaignProvider._privateConstructor();

//   factory CampaignProvider() {
//     return _instance;
//   }

//   final ApiService _api = ApiService();

//   Uint8List? imageBytes;
//   List<CampaignModel>? _campaignModel;
//   bool _isLoading = false;
//   final bool _isPatching = false;
//   String? _error;

//   List<CampaignModel>? get campaignModelList => _campaignModel;
//   bool get isLoading => _isLoading;
//   bool get isPatching => _isPatching;
//   String? get error => _error;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController docNameController = TextEditingController();
//   String? file64;
//   // TextEditingController titleController = TextEditingController();

//   Future<void> getCampaignList(context) async {
//     _isLoading = true;
//     // _error = null;
//     // notifyListeners();

//     try {
//       final response = await _api.get(
//         context: context,
//         Constant().camapignList,
//       );
//       _campaignModel =
//           List.from(response['data'].map((e) => CampaignModel.fromJson(e)));
//     } catch (e) {
//       _error = 'Failed to load permissions: $e';
//     } finally {
//       _isLoading = false;
//       // notifyListeners();
//     }
//     notifyListeners();
//   }

//   void previewFile() {
//     notifyListeners();
//   }

//   Future<bool> deleteCampaign(
//     context,
//     String id,
//   ) async {
//     _isLoading = true;
//     // _error = null;
//     notifyListeners();
//     try {
//       final response = await _api
//           .delete(context: context, "${Constant().deleteCampaign}$id", {});
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       _error = 'Failed to load permissions: $e';
//       return false;
//     } finally {
//       _isLoading = false;
//       getCampaignList(context);
//       notifyListeners();
//     }
//   }

//   Future<bool> addCampaign(context,
//       {required String title,
//       required String startDate,
//       required String docName,
//       required String image64}) async {
//     // _isLoading = true;
//     // _error = null;
//     notifyListeners();

//     print("req");

//     try {
//       final response =
//           await _api.post(context: context, Constant().addCampaign, {
//         "title": title,
//         "startDate": startDate,
//         "doc_file": {"name": docName, "base64": image64}
//       });
//       print("postReq");
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       return response['success'] == true;
//     } catch (e) {
//       print(e);
//       // _error = 'Failed to load permissions: $e';
//       return false;
//     } finally {
//       _isLoading = false;
//       getCampaignList(context);
//       notifyListeners();
//     }
//   }

  // Future<bool> editCampaign(context,
  //     {required String title,
  //     required String startDate,
  //     required String docName,
  //     required String image64}) async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final response =
  //         await _api.post(context: context, Constant().addCampaign, {
  //       "title": title,
  //       "startDate": startDate,
  //       "doc_file": {"name": docName, "base64": image64}
  //     });
  //     // _campaignModel = CampaignModel.fromJson(response.data);
  //     return response['success'] == true;
  //   } catch (e) {
  //     _error = 'Failed to load permissions: $e';
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     getCampaignList(context);
  //     notifyListeners();
  //   }
  // }
// }
