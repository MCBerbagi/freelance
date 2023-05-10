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
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:handyman/app/controller/edit_profile_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.whiteColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Edit Profile'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text('Choose From'.tr),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.selectFromGallery('camera');
                                },
                                child: Text('Camera'.tr),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.selectFromGallery('gallery');
                                },
                                child: Text('Gallery'.tr),
                              ),
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'.tr),
                              )
                            ],
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: FadeInImage(
                          image: NetworkImage(
                              '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                          placeholder: const AssetImage(
                              "assets/images/placeholder.jpeg"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/notfound.png',
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: TextFormField(
                                controller: value.firstNameTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "First Name".tr),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: TextFormField(
                                controller: value.lastNameTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "Last Name".tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text('Gender'.tr),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.updateGender(1);
                                },
                                child: Text('Male'.tr),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.updateGender(0);
                                },
                                child: Text('Female'.tr),
                              ),
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'.tr),
                              )
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: textFieldDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallText('Gender'.tr),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bodyText1(value.selectedGender == 0
                                    ? 'Female'.tr
                                    : 'Male'.tr),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: ThemeProvider.greyColor)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: textFieldDecoration(),
                        child: TextFormField(
                          readOnly: true,
                          controller: value.emailTextEditor,
                          onChanged: (String txt) {},
                          cursorColor: ThemeProvider.appColor,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: ThemeProvider.greyColor),
                              border: InputBorder.none,
                              labelText: "Email".tr),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
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
                                countryListTheme: CountryListThemeData(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search'.tr,
                                    hintText: 'Start typing to search'.tr,
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Code'.tr),
                                const SizedBox(height: 4),
                                bodyText1(value.countryCodeMobile.toString()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: textFieldDecoration(),
                              child: TextFormField(
                                // readOnly: true,
                                controller: value.mobileTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "Phone".tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    MyElevatedButton(
                      onPressed: () {
                        value.onUpdateInfo();
                      },
                      color: ThemeProvider.appColor,
                      height: 45,
                      width: double.infinity,
                      child: Text(
                        'Submit'.tr,
                        style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            color: ThemeProvider.whiteColor,
                            fontFamily: 'bold'),
                      ),
                    ),
                  ],
                )),
      );
    });
  }
}
