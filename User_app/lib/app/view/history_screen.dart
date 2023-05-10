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
import 'package:handyman/app/controller/history_controller.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/navbar.dart';
import 'package:skeletons/skeletons.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
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
        Get.find<HistoryController>().increment();
      }
    });

    _scrollControllerOngoing.addListener(() {
      if (_scrollControllerOngoing.position.pixels ==
          _scrollControllerOngoing.position.maxScrollExtent) {
        Get.find<HistoryController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<HistoryController>().increment();
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
    return GetBuilder<HistoryController>(
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
                'Booking History'.tr,
                style: ThemeProvider.titleStyle,
              ),
              bottom: value.parser.isLogin() == true
                  ? TabBar(
                      controller: tabController,
                      unselectedLabelColor: ThemeProvider.blackColor,
                      labelColor: ThemeProvider.whiteColor,
                      indicatorColor: ThemeProvider.whiteColor,
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
                          style:
                              const TextStyle(color: ThemeProvider.whiteColor),
                        ),
                        Text(
                          'Ongoing'.tr,
                          style:
                              const TextStyle(color: ThemeProvider.whiteColor),
                        ),
                        Text(
                          'Past'.tr,
                          style:
                              const TextStyle(color: ThemeProvider.whiteColor),
                        ),
                      ],
                    )
                  : null,
            ),
            body: value.parser.isLogin() == true
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
                                  child: value.appointmentList.isEmpty
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
                                                'No New Appointments Found'.tr,
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
                                            for (var item
                                                in value.appointmentList)
                                              GestureDetector(
                                                onTap: () {
                                                  value.onAppointmentDetail(
                                                    item.id as int,
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  decoration: myBoxDecoration(),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: FadeInImage(
                                                              image: NetworkImage(
                                                                  '${Environments.apiBaseURL}storage/images/${item.freelancer?.cover.toString()}'),
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/images/placeholder.jpeg"),
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image.asset(
                                                                    'assets/images/notfound.png',
                                                                    width: 32,
                                                                    height: 32,
                                                                    fit: BoxFit
                                                                        .cover);
                                                              },
                                                              fit: BoxFit.cover,
                                                              width: 32,
                                                              height: 32,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    heading4(
                                                                      item.freelancer
                                                                          ?.name
                                                                          .toString(),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8,
                                                                          vertical:
                                                                              4),
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: ThemeProvider
                                                                            .appColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              6),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        value
                                                                            .statusName[item.status
                                                                                as int]
                                                                            .tr,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontFamily: 'bold'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                          item.items!.length,
                                                          (itemIndex) => Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    item
                                                                        .items![
                                                                            itemIndex]
                                                                        .name
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'medium',
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  smallBoldText(
                                                                    value.currencySide ==
                                                                            'left'
                                                                        ? '${value.currencySymbol}${item.items![itemIndex].off.toString()}'
                                                                        : '${item.items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                        children: [
                                                          const Icon(
                                                            Icons.location_on,
                                                            size: 14,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                            child: smallText(
                                                                '${item.address!.house.toString()}, '
                                                                '${item.address!.address.toString()}, '
                                                                '${item.address!.landmark.toString()}, '
                                                                '${item.address!.pincode}'),
                                                          )
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color: ThemeProvider
                                                              .backgroundColor),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.access_time,
                                                            size: 14,
                                                            color: ThemeProvider
                                                                .greyColor,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          smallText(item.slot
                                                              .toString()),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          color: ThemeProvider
                                                              .backgroundColor),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          smallText(item
                                                              .saveDate
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
                                                                    fontSize:
                                                                        12),
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
                                                      color: ThemeProvider
                                                          .appColor,
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ))),
                          RefreshIndicator(
                            key: refreshKeyOngoing,
                            onRefresh: () async {
                              await value.onRefresh();
                            },
                            child: SingleChildScrollView(
                                controller: _scrollControllerOngoing,
                                child: value.appointmentListOngoing.isEmpty
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
                                              'No Ongoing Appointments Found'
                                                  .tr,
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
                                          for (var item
                                              in value.appointmentListOngoing)
                                            GestureDetector(
                                              onTap: () {
                                                value.onAppointmentDetail(
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
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: FadeInImage(
                                                            image: NetworkImage(
                                                                '${Environments.apiBaseURL}storage/images/${item.freelancer?.cover.toString()}'),
                                                            placeholder:
                                                                const AssetImage(
                                                                    "assets/images/placeholder.jpeg"),
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  'assets/images/notfound.png',
                                                                  width: 32,
                                                                  height: 32,
                                                                  fit: BoxFit
                                                                      .cover);
                                                            },
                                                            fit: BoxFit.cover,
                                                            width: 32,
                                                            height: 32,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  heading4(
                                                                    item.freelancer
                                                                        ?.name
                                                                        .toString(),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
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
                                                                          .statusName[item.status
                                                                              as int]
                                                                          .tr,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: ThemeProvider
                                                                              .whiteColor,
                                                                          fontFamily:
                                                                              'bold'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                        item.items!.length,
                                                        (itemIndex) => Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  item
                                                                      .items![
                                                                          itemIndex]
                                                                      .name
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'medium',
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                smallBoldText(
                                                                  value.currencySide ==
                                                                          'left'
                                                                      ? '${value.currencySymbol}${item.items![itemIndex].off.toString()}'
                                                                      : '${item.items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                      children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          size: 14,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          child: smallText(
                                                              '${item.address!.house.toString()}, '
                                                              '${item.address!.address.toString()}, '
                                                              '${item.address!.landmark.toString()}, '
                                                              '${item.address!.pincode}'),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 1,
                                                        color: ThemeProvider
                                                            .backgroundColor),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.access_time,
                                                          size: 14,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        smallText(item.slot
                                                            .toString()),
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 1,
                                                        color: ThemeProvider
                                                            .backgroundColor),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        smallText(item.saveDate
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
                                      )),
                          ),
                          RefreshIndicator(
                            key: refreshKeyOld,
                            onRefresh: () async {
                              await value.onRefresh();
                            },
                            child: SingleChildScrollView(
                                controller: _scrollControllerOld,
                                child: value.appointmentListPast.isEmpty
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
                                              'No Past Appointments Found'.tr,
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
                                          for (var item
                                              in value.appointmentListPast)
                                            GestureDetector(
                                              onTap: () {
                                                value.onAppointmentDetail(
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
                                                      children: [
                                                        Container(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: FadeInImage(
                                                            image: NetworkImage(
                                                                '${Environments.apiBaseURL}storage/images/${item.freelancer?.cover.toString()}'),
                                                            placeholder:
                                                                const AssetImage(
                                                                    "assets/images/placeholder.jpeg"),
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  'assets/images/notfound.png',
                                                                  width: 32,
                                                                  height: 32,
                                                                  fit: BoxFit
                                                                      .cover);
                                                            },
                                                            fit: BoxFit.cover,
                                                            width: 32,
                                                            height: 32,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  heading4(
                                                                    item.freelancer
                                                                        ?.name
                                                                        .toString(),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
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
                                                                          .statusName[item.status
                                                                              as int]
                                                                          .tr,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: ThemeProvider
                                                                              .whiteColor,
                                                                          fontFamily:
                                                                              'bold'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                        item.items!.length,
                                                        (itemIndex) => Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  item
                                                                      .items![
                                                                          itemIndex]
                                                                      .name
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'medium',
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                smallBoldText(
                                                                  value.currencySide ==
                                                                          'left'
                                                                      ? '${value.currencySymbol}${item.items![itemIndex].off.toString()}'
                                                                      : '${item.items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                      children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          size: 14,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          child: smallText(
                                                              '${item.address!.house.toString()}, '
                                                              '${item.address!.address.toString()}, '
                                                              '${item.address!.landmark.toString()}, '
                                                              '${item.address!.pincode}'),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 1,
                                                        color: ThemeProvider
                                                            .backgroundColor),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.access_time,
                                                          size: 14,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        smallText(item.slot
                                                            .toString()),
                                                      ],
                                                    ),
                                                    const Divider(
                                                        thickness: 1,
                                                        color: ThemeProvider
                                                            .backgroundColor),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        smallText(item.saveDate
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
                                      )),
                          ),
                        ],
                      )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/search.png',
                            width: 60, height: 60),
                        const SizedBox(height: 30),
                        TextButton(
                            onPressed: () {
                              value.onLoginRoutes();
                            },
                            child: Text(
                              'Opps, Please Login or Register first!'.tr,
                              style: const TextStyle(
                                  fontFamily: 'bold',
                                  color: ThemeProvider.appColor),
                            )),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
