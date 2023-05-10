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
import 'package:handyman/app/controller/popular_product_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class PopularProductScreen extends StatefulWidget {
  const PopularProductScreen({Key? key}) : super(key: key);

  @override
  State<PopularProductScreen> createState() => _PopularProductScreenState();
}

class _PopularProductScreenState extends State<PopularProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Popular Product'.tr,
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
            Get.find<HomeController>().productList.length,
            (i) {
              return GestureDetector(
                onTap: () {
                  Get.find<HomeController>().onProduct(
                    Get.find<HomeController>().productList[i].id as int,
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: myBoxDecoration(),
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
                                  '${Environments.apiBaseURL}storage/images/${Get.find<HomeController>().productList[i].cover.toString()}'),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Get.find<HomeController>()
                                  .productList[i]
                                  .name
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: ThemeProvider.blackColor,
                                  fontFamily: 'medium',
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .productList[i]
                                                .rating! >=
                                            1
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.greyColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .productList[i]
                                                .rating! >=
                                            2
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.greyColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .productList[i]
                                                .rating! >=
                                            3
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.greyColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .productList[i]
                                                .rating! >=
                                            4
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.greyColor,
                                    size: 12),
                                Icon(Icons.star,
                                    color: Get.find<HomeController>()
                                                .productList[i]
                                                .rating! >=
                                            5
                                        ? ThemeProvider.neutralAppColor1
                                        : ThemeProvider.greyColor,
                                    size: 12),
                                const SizedBox(width: 6),
                                Text(
                                  Get.find<HomeController>()
                                      .productList[i]
                                      .totalRating
                                      .toString(),
                                  style: const TextStyle(
                                      color: ThemeProvider.blackColor,
                                      fontFamily: 'medium',
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  Get.find<HomeController>().currencySide ==
                                          'left'
                                      ? '${Get.find<HomeController>().currencySymbol}${Get.find<HomeController>().productList[i].originalPrice}/hr'
                                      : '${Get.find<HomeController>().productList[i].originalPrice}${Get.find<HomeController>().currencySymbol}/hr',
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: ThemeProvider.greyColor,
                                      fontSize: 12),
                                ),
                                Text(
                                  Get.find<HomeController>().currencySide ==
                                          'left'
                                      ? '${Get.find<HomeController>().currencySymbol}${Get.find<HomeController>().productList[i].sellPrice}/hr'
                                      : '${Get.find<HomeController>().productList[i].sellPrice}${Get.find<HomeController>().currencySymbol}/hr',
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor,
                                      fontFamily: 'bold',
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Get.find<HomeController>()
                                        .productList[i]
                                        .quantity ==
                                    0
                                ? MyElevatedButton(
                                    onPressed: () {
                                      Get.find<HomeController>().addToCart(i);
                                    },
                                    color: ThemeProvider.appColor,
                                    height: 26,
                                    width: 100,
                                    child: Text(
                                      'ADD'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 12,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          MyElevatedButton(
                                            onPressed: () {
                                              Get.find<HomeController>()
                                                  .updateProductQuantityRemove(
                                                      i);
                                            },
                                            color:
                                                ThemeProvider.secondaryAppColor,
                                            height: 24,
                                            width: 24,
                                            child: const Icon(Icons.remove),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: heading4(
                                                Get.find<HomeController>()
                                                    .productList[i]
                                                    .quantity
                                                    .toString()),
                                          ),
                                          MyElevatedButton(
                                            onPressed: () {
                                              Get.find<HomeController>()
                                                  .updateProductQuantity(i);
                                            },
                                            color:
                                                ThemeProvider.secondaryAppColor,
                                            height: 24,
                                            width: 24,
                                            child: const Icon(Icons.add),
                                          )
                                        ],
                                      ),
                                    ],
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
