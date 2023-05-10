/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handyman/app/util/theme.dart';

void showToast(String message, {bool isError = true}) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.black,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

void successToast(String message) {
  HapticFeedback.lightImpact();
  Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.green,
    message: message.tr,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

Future<bool> clearCartAlert() async {
  HapticFeedback.lightImpact();
  bool clean = false;
  await Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
            title: Text('Warning'.tr),
            content: Text(
                "We already have service in cart with another freelancer".tr),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = false;
                },
                child: Text(
                  'Cancel'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.blackColor, fontFamily: 'medium'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  clean = true;
                },
                child: Text(
                  'Clear Cart'.tr,
                  style: const TextStyle(
                      color: ThemeProvider.appColor, fontFamily: 'bold'),
                ),
              )
            ],
          ));
  return clean;
}
