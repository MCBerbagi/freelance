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
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/controller/popular_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Popular'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          childAspectRatio: 60 / 100,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
            Get.find<HomeController>().freelancerList.length,
            (i) {
              return GestureDetector(
                onTap: () {
                  value.onHandymanProfile(
                      Get.find<HomeController>().freelancerList[i].uid as int,
                      Get.find<HomeController>()
                          .freelancerList[i]
                          .name
                          .toString());
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      color: ThemeProvider.appColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 6,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${Get.find<HomeController>().freelancerList[i].cover.toString()}'),
                              placeholder: const AssetImage(
                                  "assets/images/placeholder.jpeg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/notfound.png',
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover);
                              },
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Get.find<HomeController>()
                                  .freelancerList[i]
                                  .name
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontFamily: 'bold',
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${Get.find<HomeController>().freelancerList[i].totalExperience} ${'year experience'.tr}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .freelancerList[i]
                                                .rating! >=
                                            1
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.backgroundColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .freelancerList[i]
                                                .rating! >=
                                            2
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.backgroundColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .freelancerList[i]
                                                .rating! >=
                                            3
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.backgroundColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .freelancerList[i]
                                                .rating! >=
                                            4
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.backgroundColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .freelancerList[i]
                                                .rating! >=
                                            5
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.backgroundColor,
                                    size: 12),
                                const SizedBox(width: 6),
                                Text(
                                  Get.find<HomeController>()
                                      .freelancerList[i]
                                      .totalRating
                                      .toString(),
                                  style: const TextStyle(
                                      color: ThemeProvider.whiteColor,
                                      fontFamily: 'medium',
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              Get.find<HomeController>().currencySide == 'left'
                                  ? '${Get.find<HomeController>().currencySymbol}${Get.find<HomeController>().freelancerList[i].hourlyPrice}/hr'
                                  : '${Get.find<HomeController>().freelancerList[i].hourlyPrice}${Get.find<HomeController>().currencySymbol}/hr',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'bold',
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
