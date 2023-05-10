/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/product_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Product Detail'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          minHeight: MediaQuery.of(context).size.height / 3,
                          maxHeight: MediaQuery.of(context).size.height / 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            alignment: Alignment.center,
                            height: 40,
                            width: 200,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      Row(children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 110,
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 110,
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 110,
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                        ),
                      ]),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.productDetail.cover.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/notfound.png',
                                        width: double.infinity,
                                        // height: 200,
                                        fit: BoxFit.fitHeight);
                                  },
                                  width: double.infinity,
                                  // height: 200,
                                  fit: BoxFit.fitHeight,
                                ),
                                Positioned(
                                    top: 12,
                                    left: 16,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                          color: ThemeProvider.appColorTint,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Text(
                                        '${value.productDetail.discount} %',
                                        style: const TextStyle(
                                            color: ThemeProvider.appColor,
                                            fontFamily: 'bold',
                                            fontSize: 12),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading3(value.productDetail.name.toString()),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          value.currencySide == 'left'
                                              ? '${value.currencySymbol}${value.productDetail.originalPrice}'
                                              : '${value.productDetail.originalPrice}${value.currencySymbol}',
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: ThemeProvider.greyColor,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          value.currencySide == 'left'
                                              ? '${value.currencySymbol}${value.productDetail.sellPrice}'
                                              : '${value.productDetail.sellPrice}${value.currencySymbol}',
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontFamily: 'bold',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    value.productDetail.quantity == 0
                                        ? MyElevatedButton(
                                            onPressed: () {
                                              value.addToCart();
                                            },
                                            color: ThemeProvider.appColor,
                                            height: 26,
                                            width: 100,
                                            child: Text(
                                              'ADD'.tr,
                                              style: const TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontFamily: 'bold'),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  MyElevatedButton(
                                                    onPressed: () {
                                                      value
                                                          .updateProductQuantityRemove();
                                                    },
                                                    color: ThemeProvider
                                                        .secondaryAppColor,
                                                    height: 24,
                                                    width: 24,
                                                    child: const Icon(
                                                        Icons.remove),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: heading4(value
                                                        .productDetail.quantity
                                                        .toString()),
                                                  ),
                                                  MyElevatedButton(
                                                    onPressed: () {
                                                      value
                                                          .updateProductQuantity();
                                                    },
                                                    color: ThemeProvider
                                                        .secondaryAppColor,
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        const Icon(Icons.add),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: value.productDetail.rating! >= 1
                                            ? ThemeProvider.neutralAppColor1
                                            : ThemeProvider.greyColor,
                                        size: 18),
                                    Icon(Icons.star,
                                        color: value.productDetail.rating! >= 2
                                            ? ThemeProvider.neutralAppColor1
                                            : ThemeProvider.greyColor,
                                        size: 18),
                                    Icon(Icons.star,
                                        color: value.productDetail.rating! >= 3
                                            ? ThemeProvider.neutralAppColor1
                                            : ThemeProvider.greyColor,
                                        size: 18),
                                    Icon(Icons.star,
                                        color: value.productDetail.rating! >= 4
                                            ? ThemeProvider.neutralAppColor1
                                            : ThemeProvider.greyColor,
                                        size: 18),
                                    Icon(Icons.star,
                                        color: value.productDetail.rating! >= 5
                                            ? ThemeProvider.neutralAppColor1
                                            : ThemeProvider.greyColor,
                                        size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      value.productDetail.totalRating
                                          .toString(),
                                      style: const TextStyle(
                                          color: ThemeProvider.blackColor,
                                          fontFamily: 'medium',
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: heading4('Sold By'.tr),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    value.onFreelancerProducts(
                                        value.soldByDetail.uid as int,
                                        value.soldByDetail.name.toString());
                                  },
                                  child: Text(
                                    value.soldByDetail.name.toString(),
                                    style: const TextStyle(
                                        height: 1,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: heading4('Descriptions'.tr),
                                ),
                                Text(
                                  value.productDetail.descriptions.toString(),
                                  style: const TextStyle(
                                      height: 1,
                                      color: ThemeProvider.greyColor,
                                      fontSize: 14),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: heading4('Highlight'.tr),
                                ),
                                Text(
                                  value.productDetail.keyFeatures.toString(),
                                  style: const TextStyle(
                                      height: 1,
                                      color: ThemeProvider.greyColor,
                                      fontSize: 14),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: heading4('Disclaimer'.tr),
                                ),
                                Text(
                                  value.productDetail.disclaimer.toString(),
                                  style: const TextStyle(
                                      height: 1,
                                      color: ThemeProvider.greyColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: heading2('Related Products'.tr),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: List.generate(
                              value.relatedProductsList.length,
                              (i) {
                                return Container(
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 16),
                                  width: 150,
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
                                                  '${Environments.apiBaseURL}storage/images/${value.relatedProductsList[i].cover.toString()}'),
                                              placeholder: const AssetImage(
                                                  "assets/images/placeholder.jpeg"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
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
                                            Positioned(
                                              top: 8,
                                              left: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                color: ThemeProvider
                                                    .secondaryAppColor
                                                    .withOpacity(.2),
                                                child: Text(
                                                  '${value.relatedProductsList[i].discount} %',
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .secondaryAppColor,
                                                      fontFamily: 'medium',
                                                      fontSize: 12),
                                                ),
                                              ),
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
                                              value.relatedProductsList[i].name
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontFamily: 'medium',
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star,
                                                    color: value
                                                                .relatedProductsList[
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
                                                                .relatedProductsList[
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
                                                                .relatedProductsList[
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
                                                                .relatedProductsList[
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
                                                                .relatedProductsList[
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
                                                  value.relatedProductsList[i]
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      value.currencySide ==
                                                              'left'
                                                          ? '${value.currencySymbol}${value.relatedProductsList[i].originalPrice}'
                                                          : '${value.relatedProductsList[i].originalPrice}${value.currencySymbol}',
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Text(
                                                      value.currencySide ==
                                                              'left'
                                                          ? '${value.currencySymbol}${value.relatedProductsList[i].sellPrice}'
                                                          : '${value.relatedProductsList[i].sellPrice}${value.currencySymbol}',
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .appColor,
                                                          fontFamily: 'bold',
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            MyElevatedButton(
                                              onPressed: () {
                                                value.onRelatedProduct(
                                                  value.relatedProductsList[i]
                                                      .id as int,
                                                );
                                              },
                                              color: ThemeProvider.appColor,
                                              height: 26,
                                              width: 60,
                                              child: Text(
                                                'View'.tr,
                                                style: const TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .whiteColor,
                                                    fontFamily: 'bold'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: CupertinoSlidingSegmentedControl(
                          groupValue: value.selectedTab,
                          backgroundColor: Colors.black12,
                          children: {
                            0: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: heading4('Images'.tr),
                            ),
                            1: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: heading4('Review'.tr),
                            ),
                          },
                          onValueChanged: (i) {
                            value.updateSegment(i as int);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            if (value.selectedTab == 0)
                              GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(4),
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                crossAxisCount: 3,
                                childAspectRatio: 150 / 100,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: List.generate(
                                  value.images.length,
                                  (i) {
                                    return GestureDetector(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: FadeInImage(
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${value.images[i].toString()}'),
                                          placeholder: const AssetImage(
                                              "assets/images/placeholder.jpeg"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/notfound.png',
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            else if (value.selectedTab == 1)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: value.reviewList.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: myBoxDecoration(),
                                          padding: const EdgeInsets.all(16),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.reviewList[i].user!.cover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/placeholder.jpeg"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/placeholder.jpeg',
                                                          fit: BoxFit.cover,
                                                          height: 50,
                                                          width: 50,
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        heading3(
                                                            '${value.reviewList[i].user!.firstName.toString()} ${value.reviewList[i].user!.lastName.toString()}'),
                                                        const SizedBox(
                                                            height: 4),
                                                        smallText(value
                                                            .reviewList[i]
                                                            .createdAt!
                                                            .substring(0, 10))
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.star,
                                                          color: ThemeProvider
                                                              .neutralAppColor1,
                                                          size: 12),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        value.reviewList[i]
                                                            .rating
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: ThemeProvider
                                                                .greyColor,
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              lightText(value
                                                  .reviewList[i].notes
                                                  .toString())
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
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
