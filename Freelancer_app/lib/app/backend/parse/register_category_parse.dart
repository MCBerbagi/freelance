/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:handyman_freelancer/app/backend/api/api.dart';
import 'package:handyman_freelancer/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/util/constant.dart';

class RegisterCategoryParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterCategoryParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getAllServedCategory() async {
    var response = await apiService.getPublic(
      AppConstants.getHomeCategories,
    );
    return response;
  }
}
