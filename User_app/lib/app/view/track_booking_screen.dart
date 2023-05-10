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
import 'package:handyman/app/controller/track_booking_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class TrackBookingScreen extends StatefulWidget {
  const TrackBookingScreen({Key? key}) : super(key: key);

  @override
  State<TrackBookingScreen> createState() => _TrackBookingScreenState();
}

class _TrackBookingScreenState extends State<TrackBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackBookingController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Track Booking'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: myBoxDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      heading3('Your Booking Code: #8000000'),
                      heading3('3 Services: \$270.00'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRouter.getAddReviewRoute(),
                    );
                  },
                  color: ThemeProvider.appColor,
                  height: 45,
                  width: double.infinity,
                  child: Text(
                    'Back to Home'.tr,
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
        );
      },
    );
  }
}
