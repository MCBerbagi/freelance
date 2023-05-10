/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/login_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/widget/text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (value) {
      return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Sign in'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                heading1('Welcome Back!'.tr),
                                const SizedBox(height: 6),
                                lightText('Email or phone number'.tr),
                                const SizedBox(height: 20),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(16),
                                decoration: myBoxDecoration(),
                                child: value.loginVersion == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller:
                                                    value.emailTextEditor,
                                                onChanged: (String txt) {},
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: ThemeProvider
                                                            .greyColor),
                                                    border: InputBorder.none,
                                                    labelText:
                                                        "Email Address".tr),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller:
                                                    value.passwordTextEditor,
                                                onChanged: (String txt) {},
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                obscureText:
                                                    value.passwordVisible,
                                                decoration: InputDecoration(
                                                  labelStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      value.togglePasswordBtn();
                                                    },
                                                    icon: Icon(
                                                      value.passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: ThemeProvider
                                                          .appColor,
                                                    ),
                                                  ),
                                                  border: InputBorder.none,
                                                  labelText: "Password".tr,
                                                ),
                                              ),
                                            ),
                                          ),
                                          MyTextButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRouter
                                                      .getForgotPasswordRoute(),
                                                );
                                              },
                                              text: 'Forgot Password?'.tr,
                                              colors: ThemeProvider.appColor),
                                          const SizedBox(height: 12),
                                          MyElevatedButton(
                                            onPressed: () {
                                              value.onLogin();
                                            },
                                            color: ThemeProvider.appColor,
                                            height: 45,
                                            width: double.infinity,
                                            child: Text(
                                              'Login'.tr,
                                              style: const TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 16,
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontFamily: 'bold'),
                                            ),
                                          ),
                                        ],
                                      )
                                    : value.loginVersion == 1
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration:
                                                    textFieldDecoration(),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 12),
                                                        child: InkWell(
                                                          onTap: () {
                                                            showCountryPicker(
                                                              context: context,
                                                              exclude: <String>[
                                                                'KN',
                                                                'MF'
                                                              ],
                                                              showPhoneCode:
                                                                  true,
                                                              showWorldWide:
                                                                  false,
                                                              onSelect: (Country
                                                                  country) {
                                                                debugPrint(country
                                                                    .phoneCode);
                                                                value.saveCountryCode(
                                                                    country
                                                                        .phoneCode);
                                                              },
                                                              countryListTheme:
                                                                  CountryListThemeData(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          40.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          40.0),
                                                                ),
                                                                inputDecoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Search'
                                                                          .tr,
                                                                  hintText:
                                                                      'Start typing to search'
                                                                          .tr,
                                                                  prefixIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .search),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: const Color(
                                                                              0xFF8C98A8)
                                                                          .withOpacity(
                                                                              0.2),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(value
                                                              .countryCode),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 10,
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            value.mobileNo,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                labelText:
                                                                    'Phone Number'
                                                                        .tr),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  decoration:
                                                      textFieldDecoration(),
                                                  child: TextFormField(
                                                    controller: value
                                                        .passwordTextEditor,
                                                    onChanged: (String txt) {},
                                                    cursorColor:
                                                        ThemeProvider.appColor,
                                                    obscureText:
                                                        value.passwordVisible,
                                                    decoration: InputDecoration(
                                                      labelStyle: const TextStyle(
                                                          fontSize: 14,
                                                          color: ThemeProvider
                                                              .greyColor),
                                                      suffixIcon: IconButton(
                                                        onPressed: () {
                                                          value
                                                              .togglePasswordBtn();
                                                        },
                                                        icon: Icon(
                                                          value.passwordVisible
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color: ThemeProvider
                                                              .appColor,
                                                        ),
                                                      ),
                                                      border: InputBorder.none,
                                                      labelText: "Password".tr,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              MyTextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      AppRouter
                                                          .getForgotPasswordRoute(),
                                                    );
                                                  },
                                                  text: 'Forgot Password?'.tr,
                                                  colors:
                                                      ThemeProvider.appColor),
                                              const SizedBox(height: 12),
                                              MyElevatedButton(
                                                onPressed: () {
                                                  value
                                                      .loginWithPhonePassword();
                                                },
                                                color: ThemeProvider.appColor,
                                                height: 45,
                                                width: double.infinity,
                                                child: Text(
                                                  'Login'.tr,
                                                  style: const TextStyle(
                                                      letterSpacing: 1,
                                                      fontSize: 16,
                                                      color: ThemeProvider
                                                          .whiteColor,
                                                      fontFamily: 'bold'),
                                                ),
                                              ),
                                            ],
                                          )
                                        : value.loginVersion == 2
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        textFieldDecoration(),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                showCountryPicker(
                                                                  context:
                                                                      context,
                                                                  exclude: <
                                                                      String>[
                                                                    'KN',
                                                                    'MF'
                                                                  ],
                                                                  showPhoneCode:
                                                                      true,
                                                                  showWorldWide:
                                                                      false,
                                                                  onSelect: (Country
                                                                      country) {
                                                                    debugPrint(
                                                                        country
                                                                            .phoneCode);
                                                                    value.saveCountryCode(
                                                                        country
                                                                            .phoneCode);
                                                                  },
                                                                  countryListTheme:
                                                                      CountryListThemeData(
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              40.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              40.0),
                                                                    ),
                                                                    inputDecoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Search'
                                                                              .tr,
                                                                      hintText:
                                                                          'Start typing to search'
                                                                              .tr,
                                                                      prefixIcon:
                                                                          const Icon(
                                                                              Icons.search),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              const Color(0xFF8C98A8).withOpacity(0.2),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(value
                                                                  .countryCode),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child: TextField(
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                value.mobileNo,
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                labelText:
                                                                    'Phone Number'
                                                                        .tr),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  MyTextButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                          AppRouter
                                                              .getForgotPasswordRoute(),
                                                        );
                                                      },
                                                      text:
                                                          'Forgot Password?'.tr,
                                                      colors: ThemeProvider
                                                          .appColor),
                                                  const SizedBox(height: 12),
                                                  MyElevatedButton(
                                                    onPressed: () {
                                                      value.loginWithPhoneOTP();
                                                    },
                                                    color:
                                                        ThemeProvider.appColor,
                                                    height: 45,
                                                    width: double.infinity,
                                                    child: Text(
                                                      'Login'.tr,
                                                      style: const TextStyle(
                                                          letterSpacing: 1,
                                                          fontSize: 16,
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?'.tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: ThemeProvider.blackColor)),
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
          ));
    });
  }
}
