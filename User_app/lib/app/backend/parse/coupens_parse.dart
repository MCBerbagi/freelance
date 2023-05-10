/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get_connect.dart';
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:handyman/app/util/constant.dart';

class CoupensParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CoupensParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getActiveOffers() async {
    var response = await apiService.getPublic(
      AppConstants.getActiveOffers,
    );
    return response;
  }
}
