import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/services/api_service.dart';
import 'package:overseas_front_end/model/campaign/campaign_model.dart';

import '../../core/shared/constants.dart';

class CampaignProvider extends ChangeNotifier {
  CampaignProvider._privateConstructor();
  static final _instance = CampaignProvider._privateConstructor();

  factory CampaignProvider() {
    return _instance;
  }

  final ApiService _api = ApiService();

  Uint8List? imageBytes;
  CampaignModel? _campaignModel;
  bool _isLoading = false;
  bool _isPatching = false;
  String? _error;

  CampaignModel? get campaignModel => _campaignModel;
  bool get isLoading => _isLoading;
  bool get isPatching => _isPatching;
  String? get error => _error;
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController docNameController = TextEditingController();
  String? file64;
  // TextEditingController titleController = TextEditingController();

  Future<void> getCampaignList() async {
    _isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      print("req");

      final response = await _api.get(Constant().camapignList);
      print(response);
      _campaignModel = CampaignModel.fromJson(response);
      print("post req");
    } catch (e) {
      _error = 'Failed to load permissions: $e';
    } finally {
      _isLoading = false;
      // notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> deleteCampaign(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _api.delete("${Constant().deleteCampaign}$id", {});
      // _campaignModel = CampaignModel.fromJson(response.data);
      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      _isLoading = false;
      getCampaignList();
      notifyListeners();
    }
  }

  Future<bool> addCampaign(
      {required String title,
      required String startDate,
      required String docName,
      required String image64}) async {
    _isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.post(Constant().addCampaign, {
        "title": title,
        "startDate": startDate,
        "doc_file": {"name": docName, "base64": image64}
      });
      // _campaignModel = CampaignModel.fromJson(response.data);
      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      _isLoading = false;
      getCampaignList();
      notifyListeners();
    }
  }
}
