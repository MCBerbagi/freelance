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
import 'package:handyman/app/controller/contactus_controller.dart';
import 'package:handyman/app/util/theme.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Contact Us'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: myBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: textFieldDecoration(),
                        child: TextFormField(
                          controller: value.nameContact,
                          onChanged: (String txt) {},
                          cursorColor: ThemeProvider.appColor,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: ThemeProvider.greyColor),
                              border: InputBorder.none,
                              labelText: "Full Name".tr),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: textFieldDecoration(),
                        child: TextFormField(
                          controller: value.emailContanct,
                          cursorColor: ThemeProvider.appColor,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: ThemeProvider.greyColor),
                              border: InputBorder.none,
                              labelText: "Email Address".tr),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: textFieldDecoration(),
                        child: TextFormField(
                          maxLines: 4,
                          controller: value.messageContanct,
                          cursorColor: ThemeProvider.appColor,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: ThemeProvider.greyColor),
                              border: InputBorder.none,
                              labelText: 'Message'.tr),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 20.0),
                      child: InkWell(
                        onTap: () {
                          value.saveContacts();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              color: ThemeProvider.appColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              value.isLogin.value == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Submit'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'bold'),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
