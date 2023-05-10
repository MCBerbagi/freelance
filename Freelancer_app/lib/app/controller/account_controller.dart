/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/parse/account_parse.dart';
import 'package:handyman_freelancer/app/controller/app_page_controller.dart';
import 'package:handyman_freelancer/app/controller/product_controller.dart';
import 'package:handyman_freelancer/app/controller/service_controller.dart';
import 'package:handyman_freelancer/app/controller/slot_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/util/theme.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParser parser;

  String cover = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  bool apiCalled = false;

  AccountController({required this.parser});

  void onEdit() {
    Get.toNamed(AppRouter.getEditProfileRoute());
  }

  @override
  void onInit() {
    super.onInit();
    cover = parser.getUserCover();
    firstName = parser.getUserFirstName();
    lastName = parser.getUserLastName();
    email = parser.getUserEmail();
  }

  void changeData() {
    cover = parser.getUserCover();
    firstName = parser.getUserFirstName();
    lastName = parser.getUserLastName();
    email = parser.getUserEmail();
    update();
  }

  void cleanData() {
    parser.clearAccount();
  }

  void onServices() {
    Get.delete<ServiceController>(force: true);
    Get.toNamed(AppRouter.getServiceRoute());
  }

  void onProducts() {
    Get.delete<ProductController>(force: true);
    Get.toNamed(AppRouter.getProductRoute());
  }

  void onSlots() {
    Get.delete<SlotController>(force: true);
    Get.toNamed(AppRouter.getSlotRoute());
  }

  void onAppPages(String name, String id) {
    Get.delete<AppPageController>(force: true);
    Get.toNamed(AppRouter.getAppPageRoute(),
        arguments: [name, id], preventDuplicates: false);
  }

  Future<void> logout() async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    Response response = await parser.logout();
    Get.back();
    if (response.statusCode == 200) {
      parser.clearAccount();
      Get.offAllNamed(AppRouter.getLoginRoute());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
