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
import 'package:handyman/app/controller/services_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            value.title,
            style: ThemeProvider.titleStyle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          value.freelancerList.length.toString() +
                              'Handymans'.tr,
                          style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'medium',
                              color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    elevation: 16,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'rating');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('Popularity'.tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'Popularity'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'l-h');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                  'Price - Low to High'.tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'Price L-H'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'h-l');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                  'Price - Price High to Low'
                                                      .tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'Price H-L'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'a-z');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('A - Z'.tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'A-Z'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'z-a');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('Z - A'.tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'Z-A'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.filterProducts(
                                                context, 'experience');
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text('Experience'.tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          value.selectedFilter ==
                                                                  'Experience'
                                                              ? 'bold'
                                                              : 'regular'),
                                                  textAlign: TextAlign.center)),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.sort_by_alpha,
                              color: Colors.black,
                              size: 18,
                            ),
                            label: Text(
                              'Filter '.tr + value.selectedFilter,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : value.freelancerList.isEmpty
                ? Column(
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
                      Center(
                        child: Text(
                          'No Data Found Near You!'.tr,
                          style: const TextStyle(fontFamily: 'bold'),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: value.freelancerList.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  value.onHandymanProfile(
                                      value.freelancerList[i].uid as int,
                                      value.freelancerList[i].name.toString());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: myBoxDecoration(),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 90,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(22),
                                              ),
                                            ),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.freelancerList[i].cover}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/placeholder.jpeg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/notfound.png',
                                                    width: 90,
                                                    height: 90,
                                                    fit: BoxFit.cover);
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                heading3(
                                                  value.freelancerList[i].name
                                                      .toString(),
                                                ),
                                                const SizedBox(height: 6),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      value.freelancerList[i]
                                                          .webCatesData!.length,
                                                      (index) => smallBoldText(
                                                          value
                                                              .freelancerList[i]
                                                              .webCatesData![
                                                                  index]
                                                              .name
                                                              .toString())),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .freelancerList[
                                                                        i]
                                                                    .rating! >=
                                                                1
                                                            ? ThemeProvider
                                                                .neutralAppColor1
                                                            : ThemeProvider
                                                                .greyColor,
                                                        size: 12),
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .freelancerList[
                                                                        i]
                                                                    .rating! >=
                                                                2
                                                            ? ThemeProvider
                                                                .neutralAppColor1
                                                            : ThemeProvider
                                                                .greyColor,
                                                        size: 12),
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .freelancerList[
                                                                        i]
                                                                    .rating! >=
                                                                3
                                                            ? ThemeProvider
                                                                .neutralAppColor1
                                                            : ThemeProvider
                                                                .greyColor,
                                                        size: 12),
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .freelancerList[
                                                                        i]
                                                                    .rating! >=
                                                                4
                                                            ? ThemeProvider
                                                                .neutralAppColor1
                                                            : ThemeProvider
                                                                .greyColor,
                                                        size: 12),
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .freelancerList[
                                                                        i]
                                                                    .rating! >=
                                                                5
                                                            ? ThemeProvider
                                                                .neutralAppColor1
                                                            : ThemeProvider
                                                                .greyColor,
                                                        size: 12),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      value.freelancerList[i]
                                                          .totalRating
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .blackColor,
                                                          fontFamily: 'medium',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    smallText(
                                                        '${value.freelancerList[i].totalExperience!} ${'year experience'.tr}'),
                                                    Text(
                                                      value.currencySide ==
                                                              'left'
                                                          ? '${value.currencySymbol}${value.freelancerList[i].hourlyPrice}/hr'
                                                          : '${value.freelancerList[i].hourlyPrice}${value.currencySymbol}/hr',
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .appColor,
                                                          fontFamily: 'bold',
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
