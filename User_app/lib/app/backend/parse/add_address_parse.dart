/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/helper/shared_pref.dart';

class AddAddressParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddAddressParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> saveAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.saveAddress, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getAddressById(var body) async {
    var response = await apiService.postPrivate(AppConstants.addressById, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
