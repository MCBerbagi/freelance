/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/welcome_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/widget/text_button.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(builder: (value) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/images/bob.gif',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * .55,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .45,
                  decoration: const BoxDecoration(
                    color: ThemeProvider.appColor,
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Handyman'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'bold',
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        MyElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRouter.getLoginRoute(),
                                  arguments: ['account']);
                            },
                            color: ThemeProvider.whiteColor,
                            height: 45,
                            width: double.infinity,
                            child: Text(
                              'Continue with Email'.tr,
                              style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  color: ThemeProvider.appColor,
                                  fontFamily: 'bold'),
                            )),
                        const SizedBox(height: 20),
                        MyElevatedButton(
                            onPressed: () {},
                            color: ThemeProvider.secondaryAppColor,
                            height: 45,
                            width: double.infinity,
                            child: Text(
                              'Continue with Phone Number'.tr,
                              style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  color: ThemeProvider.whiteColor,
                                  fontFamily: 'bold'),
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have an account?'.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'medium',
                                    color: ThemeProvider.whiteColor)),
                            MyTextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    AppRouter.getRegisterRoute(),
                                  );
                                },
                                text: 'Register'.tr,
                                colors: ThemeProvider.neutralAppColor1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
