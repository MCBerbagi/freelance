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
import 'package:handyman/app/util/constant.dart';

class ReferParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ReferParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMyCode() async {
    return await apiService.postPrivate(
        AppConstants.getMyReferralCode,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }
}
