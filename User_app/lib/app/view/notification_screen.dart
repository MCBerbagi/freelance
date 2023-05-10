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
import 'package:handyman/app/controller/notification_controller.dart';
import 'package:handyman/app/util/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Notification'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 20,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) => Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: myBoxDecoration(),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: ThemeProvider.appColor,
                            radius: 20,
                            child: Icon(
                              Icons.check_circle_outline_sharp,
                              color: ThemeProvider.whiteColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading3('Booking Cancel'),
                                const SizedBox(height: 4),
                                const Text(
                                  'Thank You! Your transaction is completed. tis is test',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'medium',
                                      color: ThemeProvider.greyColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      );
    });
  }
}
