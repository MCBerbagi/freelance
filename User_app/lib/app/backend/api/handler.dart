/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/controller/account_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/toast.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showToast('Session expired!'.tr);
      Get.find<AccountController>().cleanData();
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
    } else {
      showToast(response.statusText.toString().tr);
    }
  }
}
