/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/api.dart';
import 'package:handyman_freelancer/app/helper/shared_pref.dart';
import 'package:handyman_freelancer/app/util/constant.dart';

class ProductSubCategoryParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProductSubCategoryParser(
      {required this.sharedPreferencesManager, required this.apiService});

  // Future<Response> getMyProductSubCategory() async {
  //   var response = await apiService.getPrivate(
  //       AppConstants.getMyProductSubCategory,
  //       sharedPreferencesManager.getString('token') ?? '');
  //   return response;
  // }

  Future<Response> getMyProductSubCategory(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.getMyProductSubCategory,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getCategoryrId() {
    return sharedPreferencesManager.getString('cateId') ?? '';
  }
}
