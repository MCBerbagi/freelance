/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:get/get.dart';

class FindLocationParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  FindLocationParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveLatLng(var lat, var lng, var address) {
    sharedPreferencesManager.putDouble('lat', lat);
    sharedPreferencesManager.putDouble('lng', lng);
    sharedPreferencesManager.putString('address', address);
  }

  Future<Response> getPlacesList(url) async {
    var response = await apiService.getOther(url);
    return response;
  }
}
