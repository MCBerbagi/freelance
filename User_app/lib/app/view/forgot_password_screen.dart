/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/forgot_password_controller.dart';
import 'package:handyman/app/util/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int tabId = 1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          title: Text(
            'Reset Password'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: AbsorbPointer(
          absorbing: value.isLogin.value == false ? false : true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: value.divNumber == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your email address or phone number and we will send a verification code to generate a new password'
                            .tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.emailReset,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Email Address'.tr),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          value.sendMail();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: value.isLogin.value == true
                            ? const CircularProgressIndicator(
                                color: ThemeProvider.whiteColor,
                              )
                            : Text(
                                'Send OTP'.tr,
                                style: const TextStyle(
                                    fontFamily: 'regular', fontSize: 16),
                              ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generate New Password'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.passwordReset,
                        textInputAction: TextInputAction.done,
                        obscureText:
                            value.passwordVisible.value == true ? false : true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'New Password'.tr,
                            suffixIcon: InkWell(
                              onTap: () {
                                value.togglePassword();
                              },
                              child: Icon(
                                value.passwordVisible.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ThemeProvider.appColor,
                              ),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'regular',
                                color: ThemeProvider.blackColor)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.confirmPasswordReset,
                        textInputAction: TextInputAction.done,
                        obscureText:
                            value.passwordVisible.value == true ? false : true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Confirm Password'.tr,
                            suffixIcon: InkWell(
                              onTap: () {
                                value.togglePassword();
                              },
                              child: Icon(
                                value.passwordVisible.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ThemeProvider.appColor,
                              ),
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'regular',
                                color: ThemeProvider.blackColor)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          value.updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ThemeProvider.whiteColor,
                          backgroundColor: ThemeProvider.appColor,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: value.isLogin.value == true
                            ? const CircularProgressIndicator(
                                color: ThemeProvider.whiteColor,
                              )
                            : Text(
                                'Update Password'.tr,
                                style: const TextStyle(
                                    fontFamily: 'regular', fontSize: 16),
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
