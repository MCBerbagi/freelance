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
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_category_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/navbar.dart';
import 'package:skeletons/skeletons.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCategoryController>(builder: (value) {
      return Scaffold(
        drawer: const NavBar(),
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Product Category'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? SkeletonListView()
            : GridView.count(
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 3,
                childAspectRatio: 90 / 100,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  value.productCategoryList.length,
                  (i) {
                    return SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          value.onProductList(
                              value.productCategoryList[i].id as int,
                              value.productCategoryList[i].name.toString());
                        },
                        child: Container(
                            decoration: myBoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: FadeInImage(
                                    width: 60,
                                    height: 60,
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.productCategoryList[i].cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/notfound.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    value.productCategoryList[i].name
                                        .toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'medium'),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
        bottomNavigationBar:
            Get.find<ProductCartController>().savedInCart.isNotEmpty
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
                            borderRadius: BorderRadius.circular(0),
                          )),
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
                : const SizedBox(),
      );
    });
  }
}
