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
import 'package:handyman/app/controller/add_product_review_controller.dart';
import 'package:handyman/app/controller/product_order_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';

class AddProductReviewScreen extends StatefulWidget {
  const AddProductReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddProductReviewScreen> createState() => _AddProductReviewScreenState();
}

class _AddProductReviewScreenState extends State<AddProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductReviewController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Add Product Review'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                      Get.find<ProductOrderDetailController>()
                          .orderDetail
                          .orders!
                          .length,
                      (i) {
                        return GestureDetector(
                          onTap: () {
                            value.onProductReview(
                              Get.find<ProductOrderDetailController>()
                                  .orderDetail
                                  .orders![i]
                                  .id as int,
                              Get.find<ProductOrderDetailController>()
                                  .orderDetail
                                  .orders![i]
                                  .cover
                                  .toString(),
                              Get.find<ProductOrderDetailController>()
                                  .orderDetail
                                  .orders![i]
                                  .name
                                  .toString(),
                            );
                          },
                          child: Container(
                            decoration: myBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${Get.find<ProductOrderDetailController>().orderDetail.orders![i].cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    Get.find<ProductOrderDetailController>()
                                        .orderDetail
                                        .orders![i]
                                        .name
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'medium',
                                        color: ThemeProvider.blackColor),
                                  ),
                                ),
                                const Icon(Icons.chevron_right,
                                    size: 20, color: ThemeProvider.greyColor)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
