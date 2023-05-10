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
import 'package:handyman_freelancer/app/controller/add_product_controller.dart';
import 'package:handyman_freelancer/app/controller/product_controller.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Product'.tr,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.only(left: 6),
                ),
                onPressed: () {
                  Get.delete<AddProductController>(force: true);
                  Get.toNamed(AppRouter.getAddProductRoute(),
                      arguments: ['new']);
                },
                child: Text(
                  'Add+'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'medium',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: value.productList.isEmpty
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
                              Text(
                                'No Data Found'.tr,
                                style: const TextStyle(
                                  color: ThemeProvider.appColor,
                                ),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: value.productList.length,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, i) => Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 0),
                                    decoration: myBoxDecoration(),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.productList[i].cover}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/notfound.png',
                                                        fit: BoxFit.cover,
                                                        height: 80,
                                                        width: 80,
                                                      );
                                                    },
                                                    fit: BoxFit.fitWidth,
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                                value.productList[i].discount! >
                                                        0
                                                    ? Positioned(
                                                        top: -4,
                                                        left: -4,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      4),
                                                          decoration: const BoxDecoration(
                                                              color: ThemeProvider
                                                                  .secondaryAppColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6))),
                                                          child: Text(
                                                            '${value.productList[i].discount.toString()} %',
                                                            style: const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontFamily:
                                                                    'medium',
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  heading3(value
                                                      .productList[i].name
                                                      .toString()),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    value.productList[i]
                                                        .descriptions
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .greyColor,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${value.productList[i].originalPrice.toString()}'
                                                            : '${value.productList[i].originalPrice.toString()}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${value.productList[i].sellPrice.toString()}'
                                                            : '${value.productList[i].sellPrice.toString()}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            color: ThemeProvider
                                                                .appColor,
                                                            fontFamily: 'bold'),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            value.updateStatus(
                                                                value
                                                                    .productList[
                                                                        i]
                                                                    .id as int,
                                                                value
                                                                    .productList[
                                                                        i]
                                                                    .status as int);
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size.zero,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          child: value
                                                                      .productList[
                                                                          i]
                                                                      .status ==
                                                                  1
                                                              ? const Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  size: 18,
                                                                  color: ThemeProvider
                                                                      .appColor)
                                                              : const Icon(
                                                                  Icons
                                                                      .visibility_off,
                                                                  size: 18,
                                                                  color: ThemeProvider
                                                                      .neutralAppColor4)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.delete<
                                                                    AddProductController>(
                                                                force: true);
                                                            Get.toNamed(
                                                              AppRouter
                                                                  .getAddProductRoute(),
                                                              arguments: [
                                                                'edit'.tr,
                                                                value
                                                                    .productList[
                                                                        i]
                                                                    .id
                                                              ],
                                                            );
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size.zero,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        0),
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          child: const Icon(
                                                              Icons.edit,
                                                              size: 18,
                                                              color: ThemeProvider
                                                                  .appColor)),
                                                      TextButton(
                                                          onPressed: () {
                                                            value.deleteItem(
                                                                value
                                                                    .productList[
                                                                        i]
                                                                    .id as int);
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size.zero,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          child: const Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              color: ThemeProvider
                                                                  .neutralAppColor4)),
                                                    ],
                                                  ),
                                                ],
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
                          ],
                        ),
                ),
        );
      },
    );
  }
}
