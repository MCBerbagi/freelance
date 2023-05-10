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
import 'package:handyman/app/controller/freelancer_product_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:skeletons/skeletons.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';

class FreelancerProductScreen extends StatefulWidget {
  const FreelancerProductScreen({Key? key}) : super(key: key);

  @override
  State<FreelancerProductScreen> createState() =>
      _FreelancerProductScreenState();
}

class _FreelancerProductScreenState extends State<FreelancerProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreelancerProductController>(builder: (value) {
      return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Freelancer Products'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : value.productList.isEmpty
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
                          GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(2),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 2,
                            childAspectRatio: 60 / 100,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                              value.productList.length,
                              (i) {
                                return SizedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      value.onProductDetail(
                                          value.productList[i].id as int,
                                          value.productList[i].name.toString());
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: myBoxDecoration(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 120,
                                            width: double.infinity,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                FadeInImage(
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.productList[i].cover.toString()}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/notfound.png',
                                                        width: double.infinity,
                                                        height: 120,
                                                        fit: BoxFit.fitHeight);
                                                  },
                                                  width: double.infinity,
                                                  height: 120,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  value.productList[i].name
                                                      .toString(),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .blackColor,
                                                      fontFamily: 'bold',
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: value
                                                                    .productList[
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
                                                                    .productList[
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
                                                                    .productList[
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
                                                                    .productList[
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
                                                                    .productList[
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
                                                      value
                                                          .productList[i].rating
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
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${value.productList[i].originalPrice}'
                                                              : '${value.productList[i].originalPrice}${value.currencySymbol}',
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  ThemeProvider
                                                                      .greyColor,
                                                              fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                            width: 16),
                                                        Text(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${value.productList[i].sellPrice}'
                                                              : '${value.productList[i].sellPrice}${value.currencySymbol}',
                                                          style: const TextStyle(
                                                              color:
                                                                  ThemeProvider
                                                                      .appColor,
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                value.productList[i].quantity ==
                                                        0
                                                    ? MyElevatedButton(
                                                        onPressed: () {
                                                          value.addToCart(i);
                                                        },
                                                        color: ThemeProvider
                                                            .appColor,
                                                        height: 24,
                                                        width: 100,
                                                        child: Text(
                                                          'ADD'.tr,
                                                          style: const TextStyle(
                                                              letterSpacing: 1,
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .whiteColor,
                                                              fontFamily:
                                                                  'bold'),
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              MyElevatedButton(
                                                                onPressed: () {
                                                                  value
                                                                      .updateProductQuantityRemove(
                                                                          i);
                                                                },
                                                                color: ThemeProvider
                                                                    .secondaryAppColor,
                                                                height: 24,
                                                                width: 24,
                                                                child: const Icon(
                                                                    Icons
                                                                        .remove),
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: heading4(value
                                                                    .productList[
                                                                        i]
                                                                    .quantity
                                                                    .toString()),
                                                              ),
                                                              MyElevatedButton(
                                                                onPressed: () {
                                                                  value
                                                                      .updateProductQuantity(
                                                                          i);
                                                                },
                                                                color: ThemeProvider
                                                                    .secondaryAppColor,
                                                                height: 24,
                                                                width: 24,
                                                                child: const Icon(
                                                                    Icons.add),
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
          bottomNavigationBar: Get.find<ProductCartController>()
                  .savedInCart
                  .isNotEmpty
              ? SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      value.onProductCheckout();
                    },
                    style: ElevatedButton.styleFrom(
                        shadowColor: ThemeProvider.blackColor,
                        foregroundColor: ThemeProvider.whiteColor,
                        backgroundColor: ThemeProvider.appColor,
                        elevation: 3,
                        shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                        padding: const EdgeInsets.symmetric(horizontal: 16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            value.currencySide == 'left'
                                ? '${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} | ${value.currencySymbol}${Get.find<ProductCartController>().totalPrice}'
                                : '${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} | ${Get.find<ProductCartController>().totalPrice}${value.currencySymbol}',
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'medium')),
                        Text(
                          'Checkout'.tr,
                          style: const TextStyle(
                              color: ThemeProvider.whiteColor,
                              fontFamily: 'medium'),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox());
    });
  }
}
