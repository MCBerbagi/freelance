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
import 'package:handyman/app/controller/refer_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Refer & Earn'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : Container(
                  decoration: myBoxDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value.referralData.title.toString(),
                        style: const TextStyle(
                            color: ThemeProvider.appColor,
                            fontFamily: 'bold',
                            fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        value.referralData.message.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 14),
                      ),
                      const SizedBox(height: 14),
                      Image.asset('assets/images/invite.jpg',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.fitHeight),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: ThemeProvider.greyColor.shade400),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: value.myCode.toString(),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  value.copyToClipBoard();
                                },
                                icon: const Icon(Icons.copy))
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyElevatedButton(
                          onPressed: () {
                            value.share();
                          },
                          height: 45,
                          width: double.infinity,
                          color: ThemeProvider.appColor,
                          child: Text(
                            'Invite Now'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'medium',
                                fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
