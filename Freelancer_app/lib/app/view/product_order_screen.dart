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
import 'package:handyman_freelancer/app/controller/product_order_controller.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/navbar.dart';
import 'package:skeletons/skeletons.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({Key? key}) : super(key: key);

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  final ScrollController _scrollControllerNew = ScrollController();
  final ScrollController _scrollControllerOngoing = ScrollController();
  final ScrollController _scrollControllerOld = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOngoing =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOld =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _scrollControllerNew.addListener(() {
      if (_scrollControllerNew.position.pixels ==
          _scrollControllerNew.position.maxScrollExtent) {
        Get.find<ProductOrderController>().increment();
      }
    });

    _scrollControllerOngoing.addListener(() {
      if (_scrollControllerOngoing.position.pixels ==
          _scrollControllerOngoing.position.maxScrollExtent) {
        Get.find<ProductOrderController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<ProductOrderController>().increment();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductOrderController>(
      builder: (value) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: const NavBar(),
            backgroundColor: ThemeProvider.backgroundColor,
            appBar: AppBar(
              backgroundColor: ThemeProvider.appColor,
              iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Product Order History'.tr,
                style: ThemeProvider.titleStyle,
              ),
              bottom: TabBar(
                unselectedLabelColor: ThemeProvider.blackColor,
                labelColor: ThemeProvider.appColor,
                indicatorColor: ThemeProvider.appColor,
                labelStyle: const TextStyle(
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: ThemeProvider.whiteColor),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'medium',
                    fontSize: 16,
                    color: ThemeProvider.whiteColor),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.all(8),
                tabs: [
                  Text('New'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor)),
                  Text('Ongoing'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor)),
                  Text('Past'.tr,
                      style: const TextStyle(color: ThemeProvider.whiteColor)),
                ],
              ),
            ),
            body: value.apiCalled == false
                ? SkeletonListView()
                : TabBarView(
                    children: [
                      RefreshIndicator(
                        key: refreshKeyNew,
                        onRefresh: () async {
                          await value.onRefresh();
                        },
                        child: SingleChildScrollView(
                          controller: _scrollControllerNew,
                          child: value.orderList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          "assets/images/no-data.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'No New Orders Found'.tr,
                                        style: const TextStyle(
                                          color: ThemeProvider.appColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: value.orderList.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          value.onOrderDetail(
                                            value.orderList[i].id as int,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: myBoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    width: 36,
                                                    height: 36,
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.orderList[i].userInfo?.cover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/placeholder.jpeg"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/notfound.png',
                                                            width: 36,
                                                            height: 36,
                                                            fit: BoxFit.cover);
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: 36,
                                                      height: 36,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      heading4(
                                                          '${value.orderList[i].userInfo!.firstName.toString()} '
                                                          '${value.orderList[i].userInfo!.lastName.toString()} '),
                                                      const SizedBox(height: 4),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: Text(
                                                          '${value.orderList[i].address!.house.toString()}, '
                                                          '${value.orderList[i].address!.address.toString()},'
                                                          '${value.orderList[i].address!.landmark.toString()}, '
                                                          '${value.orderList[i].address!.pincode}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'medium'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 2,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${'ORDER'.tr} #${value.orderList[i].id}',
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontSize: 14,
                                                        fontFamily: 'medium'),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: ThemeProvider
                                                          .appColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      value
                                                          .statusName[value
                                                              .orderList[i]
                                                              .status as int]
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 1,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  value.orderList[i].orders!
                                                      .length,
                                                  (itemIndex) => Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${value.orderList[i].orders![itemIndex].name.toString()} x ${value.orderList[i].orders![itemIndex].quantity.toString()}',
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          smallBoldText(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? '${value.currencySymbol}${value.orderList[i].orders![itemIndex].sellPrice.toString()}'
                                                                : '${value.orderList[i].orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color: ThemeProvider
                                                              .backgroundColor),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        size: 14,
                                                        color: ThemeProvider
                                                            .secondaryAppColor,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      smallBoldText(value
                                                          .orderList[i].dateTime
                                                          .toString()),
                                                    ],
                                                  ),
                                                  heading4(
                                                    value.currencySide == 'left'
                                                        ? '${value.currencySymbol}${value.orderList[i].grandTotal.toString()}'
                                                        : '${value.orderList[i].grandTotal.toString()}${value.currencySymbol}',
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
                        ),
                      ),
                      RefreshIndicator(
                        key: refreshKeyOngoing,
                        onRefresh: () async {
                          await value.onRefresh();
                        },
                        child: SingleChildScrollView(
                          controller: _scrollControllerOngoing,
                          child: value.orderListOngoing.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          "assets/images/no-data.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'No Ongoing Orders Found'.tr,
                                        style: const TextStyle(
                                          color: ThemeProvider.appColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: value.orderListOngoing.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          value.onOrderDetail(
                                            value.orderListOngoing[i].id as int,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: myBoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    width: 36,
                                                    height: 36,
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.orderListOngoing[i].userInfo?.cover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/placeholder.jpeg"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/notfound.png',
                                                            width: 36,
                                                            height: 36,
                                                            fit: BoxFit.cover);
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: 36,
                                                      height: 36,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      heading4(
                                                          '${value.orderListOngoing[i].userInfo!.firstName.toString()} '
                                                          '${value.orderListOngoing[i].userInfo!.lastName.toString()} '),
                                                      const SizedBox(height: 4),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: Text(
                                                          '${value.orderListOngoing[i].address!.house.toString()}, '
                                                          '${value.orderListOngoing[i].address!.address.toString()}, '
                                                          '${value.orderListOngoing[i].address!.landmark.toString()}, '
                                                          '${value.orderListOngoing[i].address!.pincode}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'medium'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 2,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${'ORDER'.tr} #${value.orderListOngoing[i].id}',
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontSize: 14,
                                                        fontFamily: 'medium'),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: ThemeProvider
                                                          .appColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      value
                                                          .statusName[value
                                                              .orderListOngoing[
                                                                  i]
                                                              .status as int]
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 1,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  value.orderListOngoing[i]
                                                      .orders!.length,
                                                  (itemIndex) => Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${value.orderListOngoing[i].orders![itemIndex].name.toString()} x ${value.orderListOngoing[i].orders![itemIndex].quantity.toString()}',
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          smallBoldText(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? '${value.currencySymbol}${value.orderListOngoing[i].orders![itemIndex].sellPrice.toString()}'
                                                                : '${value.orderListOngoing[i].orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color: ThemeProvider
                                                              .backgroundColor),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        size: 14,
                                                        color: ThemeProvider
                                                            .secondaryAppColor,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      smallBoldText(value
                                                          .orderListOngoing[i]
                                                          .dateTime
                                                          .toString()),
                                                    ],
                                                  ),
                                                  heading4(
                                                    value.currencySide == 'left'
                                                        ? '${value.currencySymbol}${value.orderListOngoing[i].grandTotal.toString()}'
                                                        : '${value.orderListOngoing[i].grandTotal.toString()}${value.currencySymbol}',
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
                        ),
                      ),
                      RefreshIndicator(
                        key: refreshKeyOld,
                        onRefresh: () async {
                          await value.onRefresh();
                        },
                        child: SingleChildScrollView(
                          controller: _scrollControllerOld,
                          child: value.orderListPast.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          "assets/images/no-data.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'No Old Orders Found'.tr,
                                        style: const TextStyle(
                                          color: ThemeProvider.appColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: value.orderListPast.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          value.onOrderDetail(
                                            value.orderListPast[i].id as int,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: myBoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    height: 36,
                                                    width: 36,
                                                    child: FadeInImage(
                                                      image: NetworkImage(
                                                          '${Environments.apiBaseURL}storage/images/${value.orderListPast[i].userInfo?.cover.toString()}'),
                                                      placeholder: const AssetImage(
                                                          "assets/images/placeholder.jpeg"),
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/notfound.png',
                                                            width: 36,
                                                            height: 36,
                                                            fit: BoxFit.cover);
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: 36,
                                                      height: 36,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      heading4(
                                                          '${value.orderListPast[i].userInfo!.firstName.toString()} '
                                                          '${value.orderListPast[i].userInfo!.lastName.toString()} '),
                                                      const SizedBox(height: 4),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: Text(
                                                          '${value.orderListPast[i].address!.house.toString()}, '
                                                          '${value.orderListPast[i].address!.address.toString()}, '
                                                          '${value.orderListPast[i].address!.landmark.toString()}, '
                                                          '${value.orderListPast[i].address!.pincode}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'medium'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 2,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${'ORDER'.tr} #${value.orderListPast[i].id}',
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .blackColor,
                                                        fontSize: 14,
                                                        fontFamily: 'medium'),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: ThemeProvider
                                                          .appColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      value
                                                          .statusName[value
                                                              .orderListPast[i]
                                                              .status as int]
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 1,
                                                  color: ThemeProvider
                                                      .backgroundColor),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  value.orderListPast[i].orders!
                                                      .length,
                                                  (itemIndex) => Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${value.orderListPast[i].orders![itemIndex].name.toString()} x ${value.orderListPast[i].orders![itemIndex].quantity.toString()}',
                                                            style:
                                                                const TextStyle(
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          smallBoldText(
                                                            value.currencySide ==
                                                                    'left'
                                                                ? '${value.currencySymbol}${value.orderListPast[i].orders![itemIndex].sellPrice.toString()}'
                                                                : '${value.orderListPast[i].orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color: ThemeProvider
                                                              .backgroundColor),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        size: 14,
                                                        color: ThemeProvider
                                                            .secondaryAppColor,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      smallBoldText(value
                                                          .orderListPast[i]
                                                          .dateTime
                                                          .toString()),
                                                    ],
                                                  ),
                                                  heading4(
                                                    value.currencySide == 'left'
                                                        ? '${value.currencySymbol}${value.orderListPast[i].grandTotal.toString()}'
                                                        : '${value.orderListPast[i].grandTotal.toString()}${value.currencySymbol}',
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
