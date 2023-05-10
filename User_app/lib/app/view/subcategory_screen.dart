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
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/subcategory_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class SubcategoryScreen extends StatefulWidget {
  const SubcategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubcategoryController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Service Provided'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : value.servicesList.isEmpty
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
                          'No Data Found'.tr,
                          style: const TextStyle(fontFamily: 'bold'),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: value.servicesList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, i) => Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                decoration: myBoxDecoration(),
                                child: Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                '${Environments.apiBaseURL}storage/images/${value.servicesList[i].cover}'),
                                            placeholder: const AssetImage(
                                                "assets/images/placeholder.jpeg"),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/notfound.png',
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: -4,
                                          left: -4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 2),
                                            decoration: const BoxDecoration(
                                                color: ThemeProvider
                                                    .secondaryAppColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            child: Text(
                                              '${value.servicesList[i].discount.toString()} %',
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontFamily: 'medium',
                                                  fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.servicesList[i].name
                                                .toString(),
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontFamily: 'medium',
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            value.servicesList[i].webCatesData!
                                                .name
                                                .toString(),
                                            style: const TextStyle(
                                                color:
                                                    ThemeProvider.blackColor),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                value.currencySide == 'left'
                                                    ? '${value.currencySymbol}${value.servicesList[i].price}'
                                                    : '${value.servicesList[i].price}${value.currencySymbol}',
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color:
                                                        ThemeProvider.greyColor,
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                value.currencySide == 'left'
                                                    ? '${value.currencySymbol}${value.servicesList[i].off}'
                                                    : '${value.servicesList[i].off}${value.currencySymbol}',
                                                style: const TextStyle(
                                                    color:
                                                        ThemeProvider.appColor,
                                                    fontFamily: 'bold'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          smallText(
                                            '${value.servicesList[i].duration} ${'min duration'.tr}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              value.onServicesDetail(value
                                                  .servicesList[i].id as int);
                                            },
                                            child: Text(
                                              'View'.tr,
                                              style: const TextStyle(
                                                  color: ThemeProvider
                                                      .secondaryAppColor,
                                                  fontSize: 11),
                                            ),
                                          ),
                                          Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: ThemeProvider.appColor,
                                            value:
                                                value.servicesList[i].isChecked,
                                            onChanged: (bool? status) {
                                              value.onServiceChange(
                                                  status as bool, i);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        bottomNavigationBar: Get.find<CartController>().savedInCart.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  value.onBooking();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ThemeProvider.appColor,
                    boxShadow: [
                      BoxShadow(
                        color: ThemeProvider.appColor,
                        blurRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          value.currencySide == 'left'
                              ? '${Get.find<CartController>().savedInCart.length} ${'Items'.tr} | ${value.currencySymbol}${Get.find<CartController>().totalPrice}'
                              : '${Get.find<CartController>().savedInCart.length} ${'Items'.tr} | ${Get.find<CartController>().totalPrice}${value.currencySymbol}',
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'medium')),
                      Text(
                        'Book Service'.tr,
                        style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontFamily: 'bold'),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
