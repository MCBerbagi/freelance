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
import 'package:handyman/app/controller/language_controller.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Language'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: myBoxDecoration(),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: AppConstants.languages.length,
              shrinkWrap: true,
              itemBuilder: (context, i) => Column(
                children: [
                  ListTile(
                    title: Text(AppConstants.languages[i].languageName),
                    leading: Radio(
                        value: AppConstants.languages[i].languageCode,
                        groupValue: value.languageCode,
                        onChanged: (e) {
                          value.saveLanguages(e.toString());
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
