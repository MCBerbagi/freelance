/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/register_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/widget/text_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (value) {
      return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Sign up'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              heading1('Welcome'.tr),
                              const SizedBox(height: 6),
                              lightText('Please enter valid details'.tr),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: myBoxDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller:
                                                value.firstNameTextEditor,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: ThemeProvider
                                                        .greyColor),
                                                border: InputBorder.none,
                                                labelText: "First Name".tr),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller:
                                                value.lastNameTextEditor,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: ThemeProvider
                                                        .greyColor),
                                                border: InputBorder.none,
                                                labelText: "Last Name".tr),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: textFieldDecoration(),
                                    child: TextFormField(
                                      controller: value.emailTextEditor,
                                      onChanged: (String txt) {},
                                      cursorColor: ThemeProvider.appColor,
                                      decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: ThemeProvider.greyColor),
                                          border: InputBorder.none,
                                          labelText: "Email".tr),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      decoration: textFieldDecoration(),
                                      width: 60,
                                      child: GestureDetector(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            favorite: <String>['IN'],
                                            showPhoneCode: true,
                                            onSelect: (Country country) {
                                              value.saveCountryCode(
                                                  country.phoneCode.toString());
                                              debugPrint(country.phoneCode);
                                            },
                                            countryListTheme:
                                                CountryListThemeData(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                              ),
                                              inputDecoration: InputDecoration(
                                                labelText: 'Search'.tr,
                                                hintText:
                                                    'Start typing to search'.tr,
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        const Color(0xFF8C98A8)
                                                            .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            smallText('Code'.tr),
                                            const SizedBox(height: 4),
                                            bodyText1(value.countryCodeMobile
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.mobileTextEditor,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: ThemeProvider
                                                        .greyColor),
                                                border: InputBorder.none,
                                                labelText: "Phone".tr),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: textFieldDecoration(),
                                    child: TextFormField(
                                      controller: value.referalCodeTextEditor,
                                      onChanged: (String txt) {},
                                      cursorColor: ThemeProvider.appColor,
                                      decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: ThemeProvider.greyColor),
                                          border: InputBorder.none,
                                          labelText:
                                              "Referal Code (Optional)".tr),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: textFieldDecoration(),
                                    child: TextFormField(
                                      controller: value.passwordTextEditor,
                                      onChanged: (String txt) {},
                                      cursorColor: ThemeProvider.appColor,
                                      obscureText: value.passwordVisible,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            value.togglePasswordBtn();
                                          },
                                          icon: Icon(
                                            value.passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        labelText: "Password".tr,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: textFieldDecoration(),
                                    child: TextFormField(
                                      controller:
                                          value.confirmPasswordTextEditor,
                                      onChanged: (String txt) {},
                                      cursorColor: ThemeProvider.appColor,
                                      obscureText: value.passwordVisible,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            value.togglePasswordBtn();
                                          },
                                          icon: Icon(
                                            value.passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: ThemeProvider.appColor,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        labelText: "Confirm Password".tr,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                MyElevatedButton(
                                    onPressed: () {
                                      value.onRegister();
                                    },
                                    color: ThemeProvider.appColor,
                                    height: 45,
                                    width: double.infinity,
                                    child: Text(
                                      'Sign up'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Alredy have an account?'.tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'medium',
                            color: ThemeProvider.blackColor)),
                    MyTextButton(
                        onPressed: () {
                          value.onBack();
                        },
                        text: 'Login'.tr,
                        colors: ThemeProvider.neutralAppColor1),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
