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
import 'package:handyman/app/controller/top_freelancers_controller.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/util/theme.dart';

class TopFreelancerScreen extends StatefulWidget {
  const TopFreelancerScreen({Key? key}) : super(key: key);

  @override
  State<TopFreelancerScreen> createState() => _TopFreelancerScreenState();
}

class _TopFreelancerScreenState extends State<TopFreelancerScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopFreelancersController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Top Freelancers'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: SingleChildScrollView(
            child: value.apiCalled == false
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.appColor,
                    ),
                  )
                : value.freelancerList.isEmpty
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
                    : GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(16),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2,
                        childAspectRatio: 60 / 100,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          value.freelancerList.length,
                          (i) {
                            return GestureDetector(
                              onTap: () {
                                value.onHandymanProfile(
                                    value.freelancerList[i].uid as int,
                                    value.freelancerList[i].name.toString());
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
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
                                                '${Environments.apiBaseURL}storage/images/${value.freelancerList[i].cover.toString()}'),
                                            placeholder: const AssetImage(
                                                "assets/images/placeholder.jpeg"),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/notfound.png',
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            value.freelancerList[i].name
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.whiteColor,
                                                fontFamily: 'bold',
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${value.freelancerList[i].totalExperience} year experience',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: ThemeProvider.whiteColor,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star,
                                                  color: value.freelancerList[i]
                                                              .rating! >=
                                                          1
                                                      ? ThemeProvider
                                                          .neutralAppColor1
                                                      : ThemeProvider
                                                          .backgroundColor,
                                                  size: 12),
                                              Icon(Icons.star,
                                                  color: value.freelancerList[i]
                                                              .rating! >=
                                                          2
                                                      ? ThemeProvider
                                                          .neutralAppColor1
                                                      : ThemeProvider
                                                          .backgroundColor,
                                                  size: 12),
                                              Icon(Icons.star,
                                                  color: value.freelancerList[i]
                                                              .rating! >=
                                                          3
                                                      ? ThemeProvider
                                                          .neutralAppColor1
                                                      : ThemeProvider
                                                          .backgroundColor,
                                                  size: 12),
                                              Icon(Icons.star,
                                                  color: value.freelancerList[i]
                                                              .rating! >=
                                                          4
                                                      ? ThemeProvider
                                                          .neutralAppColor1
                                                      : ThemeProvider
                                                          .backgroundColor,
                                                  size: 12),
                                              Icon(Icons.star,
                                                  color: value.freelancerList[i]
                                                              .rating! >=
                                                          5
                                                      ? ThemeProvider
                                                          .neutralAppColor1
                                                      : ThemeProvider
                                                          .backgroundColor,
                                                  size: 12),
                                              const SizedBox(width: 6),
                                              Text(
                                                value.freelancerList[i]
                                                    .totalRating
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'medium',
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            value.currencySide == 'left'
                                                ? '${value.currencySymbol}${value.freelancerList[i].hourlyPrice}/hr'
                                                : '${value.freelancerList[i].hourlyPrice}${value.currencySymbol}/hr',
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
                      )),
      );
    });
  }
}
