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
import 'package:handyman_freelancer/app/controller/home_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/navbar.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        Get.find<HomeController>().increment();
      }
    });

    _scrollControllerOngoing.addListener(() {
      if (_scrollControllerOngoing.position.pixels ==
          _scrollControllerOngoing.position.maxScrollExtent) {
        Get.find<HomeController>().increment();
      }
    });

    _scrollControllerOld.addListener(() {
      if (_scrollControllerOld.position.pixels ==
          _scrollControllerOld.position.maxScrollExtent) {
        Get.find<HomeController>().increment();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
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
              'Home'.tr,
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
                        child: value.appointmentList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      'No New Appointments Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: value.appointmentList.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        value.onAppoinmentDetail(
                                          value.appointmentList[i].id as int,
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
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  height: 36,
                                                  width: 36,
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentList[i].userInfo?.cover.toString()}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    heading4(
                                                        '${value.appointmentList[i].userInfo!.firstName.toString()} '
                                                        '${value.appointmentList[i].userInfo!.lastName.toString()} '),
                                                    const SizedBox(height: 4),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      child: Text(
                                                        '${value.appointmentList[i].address!.house.toString()}, '
                                                        '${value.appointmentList[i].address!.address.toString()}, '
                                                        '${value.appointmentList[i].address!.landmark.toString()}, '
                                                        '${value.appointmentList[i].address!.pincode}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                  '${'ORDER'.tr} #${value.appointmentList[i].id}',
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
                                                    color:
                                                        ThemeProvider.appColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(6),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    value
                                                        .statusName[value
                                                            .appointmentList[i]
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
                                                value.appointmentList[i].items!
                                                    .length,
                                                (itemIndex) => Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          value
                                                              .appointmentList[
                                                                  i]
                                                              .items![itemIndex]
                                                              .name
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'medium',
                                                                  fontSize: 12),
                                                        ),
                                                        smallBoldText(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${value.appointmentList[i].items![itemIndex].off.toString()}'
                                                              : '${value.appointmentList[i].items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                  Icons.access_time_filled,
                                                  size: 14,
                                                  color: ThemeProvider
                                                      .secondaryAppColor,
                                                ),
                                                const SizedBox(width: 6),
                                                smallBoldText(value
                                                    .appointmentList[i].slot
                                                    .toString()),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
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
                                                        .appointmentList[i]
                                                        .saveDate
                                                        .toString()),
                                                  ],
                                                ),
                                                heading4(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol}${value.appointmentList[i].grandTotal.toString()}'
                                                      : '${value.appointmentList[i].grandTotal.toString()}${value.currencySymbol}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                        child: value.appointmentListOngoing.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      'No Ongoing Appointments Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: value.appointmentListOngoing.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        value.onAppoinmentDetail(
                                          value.appointmentListOngoing[i].id
                                              as int,
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
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  height: 36,
                                                  width: 36,
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentListOngoing[i].userInfo?.cover.toString()}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    heading4(
                                                        '${value.appointmentListOngoing[i].userInfo!.firstName.toString()} '
                                                        '${value.appointmentListOngoing[i].userInfo!.lastName.toString()} '),
                                                    const SizedBox(height: 4),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      child: Text(
                                                        '${value.appointmentListOngoing[i].address!.house.toString()}, '
                                                        '${value.appointmentListOngoing[i].address!.address.toString()}, '
                                                        '${value.appointmentListOngoing[i].address!.landmark.toString()}, '
                                                        '${value.appointmentListOngoing[i].address!.pincode}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                  '${'ORDER'.tr} #${value.appointmentListOngoing[i].id}',
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
                                                    color:
                                                        ThemeProvider.appColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(6),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    value
                                                        .statusName[value
                                                            .appointmentListOngoing[
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
                                                value.appointmentListOngoing[i]
                                                    .items!.length,
                                                (itemIndex) => Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          value
                                                              .appointmentListOngoing[
                                                                  i]
                                                              .items![itemIndex]
                                                              .name
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'medium',
                                                                  fontSize: 12),
                                                        ),
                                                        smallBoldText(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${value.appointmentListOngoing[i].items![itemIndex].off.toString()}'
                                                              : '${value.appointmentListOngoing[i].items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                  Icons.access_time_filled,
                                                  size: 14,
                                                  color: ThemeProvider
                                                      .secondaryAppColor,
                                                ),
                                                const SizedBox(width: 6),
                                                smallBoldText(value
                                                    .appointmentListOngoing[i]
                                                    .slot
                                                    .toString()),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
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
                                                        .appointmentListOngoing[
                                                            i]
                                                        .saveDate
                                                        .toString()),
                                                  ],
                                                ),
                                                heading4(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol}${value.appointmentListOngoing[i].grandTotal.toString()}'
                                                      : '${value.appointmentListOngoing[i].grandTotal.toString()}${value.currencySymbol}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                        child: value.appointmentListPast.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      'No Old Appointments Found'.tr,
                                      style: const TextStyle(
                                        color: ThemeProvider.appColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: value.appointmentListPast.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        value.onAppoinmentDetail(
                                          value.appointmentListPast[i].id
                                              as int,
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
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  width: 36,
                                                  height: 36,
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.appointmentListPast[i].userInfo?.cover.toString()}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    heading4(
                                                        '${value.appointmentListPast[i].userInfo!.firstName.toString()} '
                                                        '${value.appointmentListPast[i].userInfo!.lastName.toString()} '),
                                                    const SizedBox(height: 4),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      child: Text(
                                                        '${value.appointmentListPast[i].address!.house.toString()}, '
                                                        '${value.appointmentListPast[i].address!.address.toString()}, '
                                                        '${value.appointmentListPast[i].address!.landmark.toString()}, '
                                                        '${value.appointmentListPast[i].address!.pincode}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                  '${'ORDER'.tr} #${value.appointmentListPast[i].id}',
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
                                                    color:
                                                        ThemeProvider.appColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(6),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    value
                                                        .statusName[value
                                                            .appointmentListPast[
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
                                                value.appointmentListPast[i]
                                                    .items!.length,
                                                (itemIndex) => Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          value
                                                              .appointmentListPast[
                                                                  i]
                                                              .items![itemIndex]
                                                              .name
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'medium',
                                                                  fontSize: 12),
                                                        ),
                                                        smallBoldText(
                                                          value.currencySide ==
                                                                  'left'
                                                              ? '${value.currencySymbol}${value.appointmentListPast[i].items![itemIndex].off.toString()}'
                                                              : '${value.appointmentListPast[i].items![itemIndex].off.toString()}${value.currencySymbol}',
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
                                                  Icons.access_time_filled,
                                                  size: 14,
                                                  color: ThemeProvider
                                                      .secondaryAppColor,
                                                ),
                                                const SizedBox(width: 6),
                                                smallBoldText(value
                                                    .appointmentListPast[i].slot
                                                    .toString()),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
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
                                                        .appointmentListPast[i]
                                                        .saveDate
                                                        .toString()),
                                                  ],
                                                ),
                                                heading4(
                                                  value.currencySide == 'left'
                                                      ? '${value.currencySymbol}${value.appointmentListPast[i].grandTotal.toString()}'
                                                      : '${value.appointmentListPast[i].grandTotal.toString()}${value.currencySymbol}',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
}
