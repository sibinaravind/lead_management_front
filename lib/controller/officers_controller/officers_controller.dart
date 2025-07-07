import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/contants.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';

import '../../core/services/api_service.dart';

class OfficersControllerProvider with ChangeNotifier {
  OfficersControllerProvider._privateConstructor();
  static final _instance = OfficersControllerProvider._privateConstructor();
  factory OfficersControllerProvider() {
    return _instance;
  }

  final ApiService _apiService = ApiService();

  List<OfficersModel>? _officersListData;
  bool _isLoading = false;
  String? _error;

  List<OfficersModel>? get officersListModel => _officersListData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Future fetchOfficersList()async{
  //   _isLoading=true;
  //   _error=null;
  //   notifyListeners();
  //
  //   try{
  //     final response=await _apiService.get(Constant().officerList);
  //     if(response.statusCode==200){
  //       final officersList = await OfficersList.fromJson(jsonDecode(response.body));
  //
  //
  //       // _officersListData=OfficersList.fromJson(response.data);
  //       return officersList.data;
  //
  //     } else{
  //       return [];
  //     }
  //   }catch(e){
  //     _error="failed to load permission $e";
  //   }finally{
  //     _isLoading=false;
  //     notifyListeners();
  //   }
  // }
  Future<List<OfficersModel>?> fetchOfficersList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      dynamic json = await _apiService.get(Constant().officerList);

      if (json['success'] == true && json['data'] != null) {
        final List<dynamic> dataList = json['data']; // ✅ cast to List
        _officersListData =
            dataList.map((e) => OfficersModel.fromJson(e)).toList();
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
}
