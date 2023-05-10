/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/choose_location_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:get/get.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/widget/text_button.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseLocationController>(builder: (value) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              lightText('Access Your'.tr),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Location'.tr,
                style: const TextStyle(
                    color: ThemeProvider.appColor,
                    fontSize: 20,
                    fontFamily: 'medium'),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/location.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                onPressed: () {
                  value.getLocation();
                },
                color: ThemeProvider.appColor,
                height: 45,
                width: double.infinity,
                child: Text(
                  'Use Current Location'.tr,
                  style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 16,
                      color: ThemeProvider.whiteColor,
                      fontFamily: 'bold'),
                ),
              ),
              MyTextButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRouter.getFindLocationRoute(),
                    );
                  },
                  text: 'Choose Location'.tr,
                  colors: ThemeProvider.appColor)
            ],
          ),
        ),
      );
    });
  }
}
