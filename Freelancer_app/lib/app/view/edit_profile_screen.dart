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
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/controller/edit_profile_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

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
        backgroundColor: ThemeProvider.backgroundColor,
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
                child: CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: myBoxDecoration(),
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
                        child: SizedBox(
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
                            height: 100,
                            width: 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                horizontal: 8, vertical: 6),
                            decoration: textFieldDecoration(),
                            width: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Code'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: bodyText1(value.countryCodeMobile),
                                    )
                                  ],
                                ),
                              ],
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
                                  readOnly: true,
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
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: heading2('Freelancing Details'),
                      ),
                      GestureDetector(
                        onTap: () {
                          value.onCategoriesList();
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
                              smallText('Select Category'.tr),
                              const SizedBox(height: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    value.profileInfo.webCatesData!.length,
                                    (index) => Text(value
                                        .profileInfo.webCatesData![index].name
                                        .toString())),
                              )
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
                            controller: value.hourlyPriceTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Hourly Price".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.totalExperienceTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Total Experience".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: textFieldDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bodyText1('Have Shop?'.tr),
                                Switch(
                                  value: value.haveShop,
                                  activeColor: ThemeProvider.appColor,
                                  onChanged: (bool status) {
                                    value.toggleShopBtn(status);
                                  },
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          value.onCityList();
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
                              smallText('City ID'.tr),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1(
                                    value.selectedCityName == '' ||
                                            value.selectedCityName.isEmpty
                                        ? 'Select'.tr
                                        : value.selectedCityName,
                                  ),
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
                            controller: value.zipCodeTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Zip Code".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.latTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Latitude".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.longTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Longitude".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.descriptionsTextEditor,
                            onChanged: (String txt) {},
                            cursorColor: ThemeProvider.appColor,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Description".tr),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(4),
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        crossAxisCount: 3,
                        childAspectRatio: 150 / 100,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          value.gallery.length,
                          (index) {
                            return GestureDetector(
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
                                          value.selectFromGalleryOthers(
                                              'camera', index);
                                        },
                                        child: Text('Camera'.tr),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          value.selectFromGalleryOthers(
                                              'gallery', index);
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
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.gallery[index].toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/notfound.png',
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            );
                          },
                        ),
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
                  ),
                ),
              ),
      );
    });
  }
}
