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
import 'package:handyman/app/controller/product_history_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class ProductHistoryScreen extends StatefulWidget {
  const ProductHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductHistoryScreen> createState() => _ProductHistoryScreenState();
}

class _ProductHistoryScreenState extends State<ProductHistoryScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollControllerNew = ScrollController();
  final ScrollController _scrollControllerOngoing = ScrollController();
  final ScrollController _scrollControllerOld = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshKeyNew =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOngoing =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshKeyOld =
      GlobalKey<RefreshIndicatorState>();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      tabController.animateTo(tabController.index,
          duration: const Duration(seconds: 3));
      debugPrint(tabController.index.toString());
    });

    _scrollControllerNew.addListener(() {
      if (_scrollControllerNew.position.pixels ==
          _scrollControllerNew.position.maxScrollExtent) {
        Get.find<ProductHistoryController>().increment();
      }
    });

    _scrollControllerOngoing.addListener(() {
      if (_scrollControllerOngoing.position.pixels ==
          _scrollControllerOngoing.position.maxScrollExtent) {
        Get.find<ProductHistoryController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<ProductHistoryController>().increment();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductHistoryController>(
      builder: (value) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
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
                controller: tabController,
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
                  Text(
                    'New'.tr,
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ),
                  Text(
                    'Ongoing'.tr,
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ),
                  Text(
                    'Past'.tr,
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ),
                ],
              ),
            ),
            body: value.login == true
                ? value.apiCalled == false
                    ? SkeletonListView()
                    : TabBarView(
                        controller: tabController,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
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
                                              'No New Order Found'.tr,
                                              style: const TextStyle(
                                                color: ThemeProvider.appColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var item in value.orderList)
                                            GestureDetector(
                                              onTap: () {
                                                value.onOrderDetail(
                                                  item.id as int,
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                decoration: myBoxDecoration(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        heading4(
                                                          '#${item.id}',
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: ThemeProvider
                                                                .appColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  6),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            value
                                                                .statusName[
                                                                    item.status
                                                                        as int]
                                                                .tr,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontFamily:
                                                                    'bold'),
                                                          ),
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
                                                        smallBoldText(
                                                            'Sold By'),
                                                        smallBoldText(
                                                            '${item.freelancerInfo?.firstName.toString()} '
                                                            ' ${item.freelancerInfo?.lastName.toString()} '),
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 1,
                                                        color: ThemeProvider
                                                            .backgroundColor),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                        item.orders!.length,
                                                        (itemIndex) => Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '${item.orders![itemIndex].name.toString()} x ${item.orders![itemIndex].quantity.toString()}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'medium',
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                smallBoldText(
                                                                  value.currencySide ==
                                                                          'left'
                                                                      ? '${value.currencySymbol}${item.orders![itemIndex].sellPrice.toString()}'
                                                                      : '${item.orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                                ),
                                                              ],
                                                            ),
                                                            const Divider(
                                                                thickness: 2,
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
                                                        smallText(item.dateTime
                                                            .toString()),
                                                        Text(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${item.grandTotal.toString()}'
                                                              : '${item.grandTotal.toString()}${value.currencySymbol}',
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'medium',
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          value.loadMore == true
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        ThemeProvider.appColor,
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                              )),
                          RefreshIndicator(
                            key: refreshKeyOngoing,
                            onRefresh: () async {
                              await value.onRefresh();
                            },
                            child: SingleChildScrollView(
                              controller: _scrollControllerNew,
                              child: value.orderListOngoing.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
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
                                            'No Ongoing Order Found'.tr,
                                            style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var item in value.orderListOngoing)
                                          GestureDetector(
                                            onTap: () {
                                              value.onOrderDetail(
                                                item.id as int,
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                              decoration: myBoxDecoration(),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      heading4(
                                                        '#${item.id}',
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
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
                                                              .statusName[
                                                                  item.status
                                                                      as int]
                                                              .tr,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .whiteColor,
                                                              fontFamily:
                                                                  'bold'),
                                                        ),
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
                                                      smallBoldText('Sold By'),
                                                      smallBoldText(
                                                          '${item.freelancerInfo?.firstName.toString()} '
                                                          ' ${item.freelancerInfo?.lastName.toString()} '),
                                                    ],
                                                  ),
                                                  const Divider(
                                                      thickness: 1,
                                                      color: ThemeProvider
                                                          .backgroundColor),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      item.orders!.length,
                                                      (itemIndex) => Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${item.orders![itemIndex].name.toString()} x ${item.orders![itemIndex].quantity.toString()}',
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              smallBoldText(
                                                                value.currencySide ==
                                                                        'left'
                                                                    ? '${value.currencySymbol}${item.orders![itemIndex].sellPrice.toString()}'
                                                                    : '${item.orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 2,
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
                                                      smallText(item.dateTime
                                                          .toString()),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${item.grandTotal.toString()}'
                                                            : '${item.grandTotal.toString()}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        value.loadMore == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: ThemeProvider.appColor,
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                            ),
                          ),
                          RefreshIndicator(
                            key: refreshKeyOld,
                            onRefresh: () async {
                              await value.onRefresh();
                            },
                            child: SingleChildScrollView(
                              controller: _scrollControllerNew,
                              child: value.orderListPast.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
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
                                            'No Past Order Found'.tr,
                                            style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var item in value.orderListPast)
                                          GestureDetector(
                                            onTap: () {
                                              value.onOrderDetail(
                                                item.id as int,
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                              decoration: myBoxDecoration(),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      heading4(
                                                        '#${item.id}',
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
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
                                                              .statusName[
                                                                  item.status
                                                                      as int]
                                                              .tr,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .whiteColor,
                                                              fontFamily:
                                                                  'bold'),
                                                        ),
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
                                                      smallBoldText('Sold By'),
                                                      smallBoldText(
                                                          '${item.freelancerInfo?.firstName.toString()} '
                                                          ' ${item.freelancerInfo?.lastName.toString()} '),
                                                    ],
                                                  ),
                                                  const Divider(
                                                      thickness: 1,
                                                      color: ThemeProvider
                                                          .backgroundColor),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      item.orders!.length,
                                                      (itemIndex) => Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${item.orders![itemIndex].name.toString()} x ${item.orders![itemIndex].quantity.toString()}',
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'medium',
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              smallBoldText(
                                                                value.currencySide ==
                                                                        'left'
                                                                    ? '${value.currencySymbol}${item.orders![itemIndex].sellPrice.toString()}'
                                                                    : '${item.orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 2,
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
                                                      smallText(item.dateTime
                                                          .toString()),
                                                      Text(
                                                        value.currencySide ==
                                                                'left'
                                                            ? '${value.currencySymbol}${item.grandTotal.toString()}'
                                                            : '${item.grandTotal.toString()}${value.currencySymbol}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        value.loadMore == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: ThemeProvider.appColor,
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/search.png',
                            width: 60, height: 60),
                        Text(
                          'Opps, Please Login or Register first!'.tr,
                          style: const TextStyle(fontFamily: 'bold'),
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
