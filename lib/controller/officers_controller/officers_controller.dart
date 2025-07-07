

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/contants.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';

import '../../core/services/api_service.dart';

class OfficersControllerProvider with ChangeNotifier{
  OfficersControllerProvider._privateConstructor();
  static final _instance=OfficersControllerProvider._privateConstructor();
  factory OfficersControllerProvider(){
    return _instance;
  }

  final ApiService _apiService=ApiService();

  OfficersList? _officersListModel;
  bool _isLoading =false;
  String? _error;

  OfficersList? get officersListModel=>_officersListModel;
  bool get isLoading=>_isLoading;
  String? get error=>_error;

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
  //       // _officersListModel=OfficersList.fromJson(response.data);
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
  Future fetchOfficersList() async {
    _isLoading = true;
    _error = null;

    try {
      final json = await _apiService.get(Constant().officerList);
print(OfficersList.fromJson(json));
      if (json['success'] == true && json['data'] != null) {
        print("............");
        _officersListModel=OfficersList.fromJson(json);
        // final officersList =OfficersList.fromJson(json);
        // _officersListModel
        // return officersList.data;
      } else {
        _error = 'Invalid response structure';
        return [];
      }
    } catch (e) {
      _error = "failed to load permission $e";
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}