/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/add_address_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:get/get.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              value.action == 'new'
                  ? 'Add New Address'.tr
                  : 'Update Address'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.addressTextEditor,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Address".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.houseTextEditor,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "House / Flat No".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.landmarkTextEditor,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Landmark".tr),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.zipcodeTextEditor,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.greyColor),
                                border: InputBorder.none,
                                labelText: "Zipcode".tr),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'SAVE AS'.tr,
                        style: const TextStyle(fontFamily: 'bold'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              value.onFilter(0);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.home_outlined),
                              minLeadingWidth: 0,
                              title: Text('Home'.tr),
                              trailing: Icon(
                                value.title == 0
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: value.title == 0
                                    ? ThemeProvider.appColor
                                    : ThemeProvider.greyColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.onFilter(1);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.work_outline),
                              minLeadingWidth: 0,
                              title: Text('Work'.tr),
                              trailing: Icon(
                                value.title == 1
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: value.title == 1
                                    ? ThemeProvider.appColor
                                    : ThemeProvider.greyColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.onFilter(2);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.home_work_outlined),
                              minLeadingWidth: 0,
                              title: Text('Other'.tr),
                              trailing: Icon(
                                value.title == 2
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: value.title == 2
                                    ? ThemeProvider.appColor
                                    : ThemeProvider.greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyElevatedButton(
              onPressed: () {
                value.getLatLngFromAddress();
              },
              color: ThemeProvider.appColor,
              height: 45,
              width: double.infinity,
              child: Text(
                value.action == 'new' ? 'Submit'.tr : 'Update'.tr,
                style: const TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'bold'),
              ),
            ),
          ),
        );
      },
    );
  }
}
