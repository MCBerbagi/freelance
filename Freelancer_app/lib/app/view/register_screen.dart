/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handyman_freelancer/app/backend/model/city_model.dart';
import 'package:handyman_freelancer/app/controller/register_controller.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';
import 'package:handyman_freelancer/app/widget/text_button.dart';
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
            child: value.apiCalled == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: myBoxDecoration(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showCupertinoModalPopup<
                                                          void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            CupertinoActionSheet(
                                                          title: Text(
                                                              'Choose From'.tr),
                                                          actions: <
                                                              CupertinoActionSheetAction>[
                                                            CupertinoActionSheetAction(
                                                              child: Text(
                                                                  'Gallery'.tr),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                value.selectFromGallery(
                                                                    'gallery');
                                                              },
                                                            ),
                                                            CupertinoActionSheetAction(
                                                              child: Text(
                                                                  'Camera'.tr),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                value.selectFromGallery(
                                                                    'camera');
                                                              },
                                                            ),
                                                            CupertinoActionSheetAction(
                                                              child: Text(
                                                                'Cancel'.tr,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'bold',
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: FadeInImage(
                                                      height: 100,
                                                      width: 100,
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.cover}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/placeholder.jpeg"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/notfound.png',
                                                          fit: BoxFit.cover,
                                                          height: 100,
                                                          width: 100,
                                                        );
                                                      },
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.emailTextEditor,
                                            readOnly: value.emailVerified,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Email".tr,
                                              suffix: GestureDetector(
                                                  onTap: () {
                                                    value.verifyEmail();
                                                  },
                                                  child: Text(
                                                    value.emailVerified == false
                                                        ? 'Verify'.tr
                                                        : 'Verified'.tr,
                                                    style: TextStyle(
                                                        color: value.emailVerified ==
                                                                true
                                                            ? ThemeProvider
                                                                .appColor
                                                            : ThemeProvider
                                                                .neutralAppColor4,
                                                        fontSize: 12),
                                                  )),
                                            ),
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
                                                    if (value.phoneVerified ==
                                                        false) {
                                                      value.saveCountryCode(
                                                          country.phoneCode
                                                              .toString());
                                                      debugPrint(
                                                          country.phoneCode);
                                                    }
                                                  },
                                                  countryListTheme:
                                                      CountryListThemeData(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40.0),
                                                      topRight:
                                                          Radius.circular(40.0),
                                                    ),
                                                    inputDecoration:
                                                        InputDecoration(
                                                      labelText: 'Search'.tr,
                                                      hintText:
                                                          'Start typing to search'
                                                              .tr,
                                                      prefixIcon: const Icon(
                                                          Icons.search),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: const Color(
                                                                  0xFF8C98A8)
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
                                                  bodyText1(value
                                                      .countryCodeMobile
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                decoration:
                                                    textFieldDecoration(),
                                                child: TextFormField(
                                                  controller:
                                                      value.mobileTextEditor,
                                                  onChanged: (String txt) {},
                                                  readOnly: value.phoneVerified,
                                                  cursorColor:
                                                      ThemeProvider.appColor,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: ThemeProvider
                                                            .greyColor),
                                                    border: InputBorder.none,
                                                    labelText: "Phone".tr,
                                                    suffix: GestureDetector(
                                                        onTap: () {
                                                          value.verifyPhone();
                                                        },
                                                        child: Text(
                                                          value.phoneVerified ==
                                                                  false
                                                              ? 'Verify'.tr
                                                              : 'Verified'.tr,
                                                          style: TextStyle(
                                                              color: value.phoneVerified ==
                                                                      true
                                                                  ? ThemeProvider
                                                                      .appColor
                                                                  : ThemeProvider
                                                                      .neutralAppColor4,
                                                              fontSize: 12),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                decoration:
                                                    textFieldDecoration(),
                                                child: TextFormField(
                                                  controller:
                                                      value.firstNameTextEditor,
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
                                                          "First Name".tr),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                decoration:
                                                    textFieldDecoration(),
                                                child: TextFormField(
                                                  controller:
                                                      value.lastNameTextEditor,
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
                                                          "Last Name".tr),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller:
                                                value.passwordTextEditor,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            obscureText: value.passwordVisible,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
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
                                                  color:
                                                      ThemeProvider.greyColor),
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: DropdownButton<String>(
                                              value: value.selectedGender,
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              onChanged: (String? newValue) {
                                                value.saveGender(
                                                    newValue.toString());
                                              },
                                              items: value.genderList.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.hourlyPrice,
                                            cursorColor: ThemeProvider.appColor,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Hourly Price".tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.experience,
                                            cursorColor: ThemeProvider.appColor,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText:
                                                  "Experience in year".tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller:
                                                value.descriptionsTextEditor,
                                            onChanged: (String txt) {},
                                            cursorColor: ThemeProvider.appColor,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: ThemeProvider
                                                        .greyColor),
                                                border: InputBorder.none,
                                                labelText: "Description".tr),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          value.onCategoriesList();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              smallText('Select Category'.tr),
                                              const SizedBox(height: 4),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    value.servedCategoriesList
                                                        .length,
                                                    (index) => Text(value
                                                        .servedCategoriesList[
                                                            index]
                                                        .name
                                                        .toString())),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: DropdownButton<CityModel>(
                                              underline: const SizedBox(),
                                              isExpanded: true,
                                              value: value.selectedCity,
                                              items: value.cityList
                                                  .map((CityModel value) {
                                                return DropdownMenuItem<
                                                    CityModel>(
                                                  value: value,
                                                  child: Text(
                                                      value.name.toString()),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                value.onCityChanged(
                                                    newValue as CityModel);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.zipcode,
                                            cursorColor: ThemeProvider.appColor,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Zipcode".tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Select Latitude & Longitude from here :'
                                                .tr,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'regular'),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.openLink();
                                            },
                                            child: const Text(
                                                'https://www.mapcoordinates.net/en',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'regular',
                                                    color: Colors.blue)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Please enter valid Latitude & Longitude otherwise app may not work properly.'
                                                .tr,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'regular'),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.lat,
                                            cursorColor: ThemeProvider.appColor,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Your Latitude".tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: textFieldDecoration(),
                                          child: TextFormField(
                                            controller: value.lng,
                                            keyboardType: TextInputType.number,
                                            cursorColor: ThemeProvider.appColor,
                                            decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Your Longitude".tr,
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
                                Get.toNamed(
                                  AppRouter.getLoginRoute(),
                                );
                              },
                              text: 'Login'.tr,
                              colors: ThemeProvider.neutralAppColor1),
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                  ),
          ));
    });
  }
}
