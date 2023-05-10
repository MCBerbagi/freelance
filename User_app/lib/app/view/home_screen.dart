/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/widget/navbar.dart';
import 'package:handyman/app/widget/text_button.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
      return Scaffold(
        drawer: const NavBar(),
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: false,
          title: GestureDetector(
            onTap: () {
              Get.toNamed(AppRouter.getChooseLocationRoute());
            },
            child: Text(value.title.toString(),
                overflow: TextOverflow.ellipsis,
                style: ThemeProvider.titleStyle),
          ),
          bottom: value.haveData == true
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRouter.getSearchRoute());
                            },
                            child: Container(
                              height: 45,
                              margin: const EdgeInsets.all(10),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: 'Search'.tr,
                                  prefixIcon: const Icon(Icons.search),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : null,
        ),
        body: value.apiCalled == false
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 30,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 12),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 50,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(height: 12),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 8,
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 30,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(8)),
                    ),
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
                    const SizedBox(height: 12),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 30,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 160,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 160,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: value.haveData == false
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          value.bannersList.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  height: 140,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: false,
                                      viewportFraction: 1.0,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                    ),
                                    items: value.bannersList
                                        .map<Widget>((item) => GestureDetector(
                                              onTap: () {
                                                value.onBannerClick(
                                                    item.type as int,
                                                    item.value.toString());
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 140,
                                                decoration:
                                                    squareImage(item.cover),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 300,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 40),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    150,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                    child: Text(
                                                      item.title.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily: 'medium'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                )
                              : const SizedBox(),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 12, right: 16, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading2('Categories'.tr),
                                MyTextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRouter.getCategoryRoute(),
                                      );
                                    },
                                    text: 'See All'.tr,
                                    colors: ThemeProvider.greyColor)
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: List.generate(
                                  value.categoryList.length,
                                  (i) => GestureDetector(
                                    onTap: () {
                                      value.onCategory(
                                          value.categoryList[i].id as int,
                                          value.categoryList[i].name
                                              .toString());
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      clipBehavior: Clip.antiAlias,
                                      height: 120,
                                      width: 100,
                                      decoration: myBoxDecoration(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: FadeInImage(
                                              width: 60,
                                              height: 60,
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${value.categoryList[i].cover.toString()}'),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 8),
                                            child: Text(
                                              value.categoryList[i].name
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading2('Recomended'.tr),
                                MyTextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRouter.getPopularRoute(),
                                      );
                                    },
                                    text: 'See All'.tr,
                                    colors: ThemeProvider.greyColor)
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: List.generate(
                                  value.freelancerList.length,
                                  (i) => GestureDetector(
                                    onTap: () {
                                      value.onHandymanProfile(
                                          value.freelancerList[i].uid as int,
                                          value.freelancerList[i].name
                                              .toString());
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          right: 10, bottom: 16),
                                      width: 150,
                                      decoration: const BoxDecoration(
                                          color: ThemeProvider.appColor,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.16),
                                            )
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
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
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
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
                                                      color: ThemeProvider
                                                          .whiteColor,
                                                      fontFamily: 'bold',
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  '${value.freelancerList[i].totalExperience} ${'year experience'.tr}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .whiteColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                                .backgroundColor,
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
                                                                .backgroundColor,
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
                                                                .backgroundColor,
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
                                                                .backgroundColor,
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
                                                      ? '${value.currencySymbol}${value.freelancerList[i].hourlyPrice}/${'hr'.tr}'
                                                      : '${value.freelancerList[i].hourlyPrice}${value.currencySymbol}/${'hr'.tr}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      color: ThemeProvider
                                                          .whiteColor,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading2('Products'.tr),
                                MyTextButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRouter.getPopularProductRoute(),
                                      );
                                    },
                                    text: 'See All'.tr,
                                    colors: ThemeProvider.greyColor)
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: List.generate(
                                  value.productList.length,
                                  (i) {
                                    return GestureDetector(
                                      onTap: () {
                                        value.onProduct(
                                          value.productList[i].id as int,
                                        );
                                      },
                                      child: Container(
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
                                                        '${Environments.apiBaseURL}storage/images/${value.productList[i].cover.toString()}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/images/notfound.png',
                                                          width:
                                                              double.infinity,
                                                          height: 120,
                                                          fit:
                                                              BoxFit.fitHeight);
                                                    },
                                                    width: double.infinity,
                                                    height: 120,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                  Positioned(
                                                    top: 8,
                                                    left: 0,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      color: ThemeProvider
                                                          .secondaryAppColor
                                                          .withOpacity(.2),
                                                      child: Text(
                                                        '${value.productList[i].discount} %',
                                                        style: const TextStyle(
                                                            color: ThemeProvider
                                                                .secondaryAppColor,
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    value.productList[i].name
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontFamily: 'medium',
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                        value.productList[i]
                                                            .totalRating
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: ThemeProvider
                                                                .blackColor,
                                                            fontFamily:
                                                                'medium',
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
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${value.productList[i].originalPrice}'
                                                            : '${value.productList[i].originalPrice}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${value.productList[i].sellPrice}'
                                                            : '${value.productList[i].sellPrice}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            color: ThemeProvider
                                                                .appColor,
                                                            fontFamily: 'bold',
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 6),
                                                  value.productList[i]
                                                              .quantity ==
                                                          0
                                                      ? MyElevatedButton(
                                                          onPressed: () {
                                                            value.addToCart(i);
                                                          },
                                                          color: ThemeProvider
                                                              .appColor,
                                                          height: 26,
                                                          width: 100,
                                                          child: Text(
                                                            'ADD'.tr,
                                                            style: const TextStyle(
                                                                letterSpacing:
                                                                    1,
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
                                                                  onPressed:
                                                                      () {
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
                                                                  onPressed:
                                                                      () {
                                                                    value
                                                                        .updateProductQuantity(
                                                                            i);
                                                                  },
                                                                  color: ThemeProvider
                                                                      .secondaryAppColor,
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: const Icon(
                                                                      Icons
                                                                          .add),
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
                            ),
                          ),
                        ],
                      ),
              ),
      );
    });
  }

  squareImage(val) {
    return BoxDecoration(
        image: DecorationImage(
            image:
                NetworkImage('${Environments.apiBaseURL}storage/images/$val'),
            fit: BoxFit.cover,
            alignment: Alignment.center));
  }
}
