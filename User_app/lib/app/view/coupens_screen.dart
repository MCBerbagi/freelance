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
import 'package:handyman/app/controller/coupens_controller.dart';
import 'package:skeletons/skeletons.dart';
import 'package:handyman/app/util/theme.dart';

class CoupensScreen extends StatefulWidget {
  const CoupensScreen({Key? key}) : super(key: key);

  @override
  State<CoupensScreen> createState() => _CoupensScreenState();
}

class _CoupensScreenState extends State<CoupensScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoupensController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Select Coupon'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: value.offersList.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                "assets/images/no-data.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          for (var item in value.offersList)
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: myBoxDecoration(),
                              child: GestureDetector(
                                onTap: () {
                                  value.selectOffer(
                                      item.id.toString(), item.name.toString());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Use coupon code'.tr +
                                                item.name.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                              item.shortDescriptions
                                                      .toString() +
                                                  ' - Valid until'.tr +
                                                  item.expire.toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      value.offerId == item.id.toString()
                                          ? Icons.radio_button_checked
                                          : Icons.circle_outlined,
                                      color: value.offerId == item.id.toString()
                                          ? ThemeProvider.appColor
                                          : ThemeProvider.greyColor,
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
              ),
        bottomNavigationBar: value.offersList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    value.addCoupen();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ThemeProvider.whiteColor,
                    backgroundColor: ThemeProvider.appColor,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Apply'.tr,
                    style: const TextStyle(
                      color: ThemeProvider.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
