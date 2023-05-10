/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/controller/edit_profile_controller.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => EditProfileController(parser: Get.find()),
    );
  }
}
