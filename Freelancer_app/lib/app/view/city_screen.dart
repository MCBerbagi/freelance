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
import 'package:handyman_freelancer/app/controller/city_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CityController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Select City'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: MyElevatedButton(
                    onPressed: () {
                      value.saveAndCloe();
                    },
                    color: ThemeProvider.appColor,
                    height: 40,
                    width: double.infinity,
                    child: Text('Save'.tr)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: ThemeProvider.greyColor,
                    height: 40,
                    width: double.infinity,
                    child: Text('Cancle'.tr)),
              )
            ],
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: myBoxDecoration(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.cityList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) => Column(
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          horizontalTitleGap: 0,
                          leading: Radio(
                            activeColor: ThemeProvider.appColor,
                            value: value.cityList[i].id.toString(),
                            groupValue: value.selectedCityId,
                            onChanged: (data) {
                              value.saveCate(data.toString());
                            },
                          ),
                          title: heading4(value.cityList[i].name.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
