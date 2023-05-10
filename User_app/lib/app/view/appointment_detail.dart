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
import 'package:handyman/app/controller/appointment_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:skeletons/skeletons.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentDetailController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              '${'Appointment ID'.tr} #${value.appointmentId}',
              style: ThemeProvider.titleStyle,
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    value.launchInBrowser();
                  },
                  icon: const Icon(Icons.print_outlined)),
              IconButton(
                  onPressed: () {
                    value.openHelpModal();
                  },
                  icon: const Icon(Icons.question_mark_outlined))
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: myBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  height: 70,
                                  width: 70,
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.appointmentDetail.freelancer?.cover.toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/notfound.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover);
                                    },
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      heading4(value
                                          .appointmentDetail.freelancer?.name
                                          .toString()),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${value.appointmentDetail.freelancer!.totalExperience} ${'year experience'.tr}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: ThemeProvider.blackColor,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.star,
                                              color: value
                                                          .appointmentDetail
                                                          .freelancer!
                                                          .rating! >=
                                                      1
                                                  ? ThemeProvider
                                                      .neutralAppColor1
                                                  : ThemeProvider.greyColor,
                                              size: 12),
                                          Icon(Icons.star,
                                              color: value
                                                          .appointmentDetail
                                                          .freelancer!
                                                          .rating! >=
                                                      2
                                                  ? ThemeProvider
                                                      .neutralAppColor1
                                                  : ThemeProvider.greyColor,
                                              size: 12),
                                          Icon(Icons.star,
                                              color: value
                                                          .appointmentDetail
                                                          .freelancer!
                                                          .rating! >=
                                                      3
                                                  ? ThemeProvider
                                                      .neutralAppColor1
                                                  : ThemeProvider.greyColor,
                                              size: 12),
                                          Icon(Icons.star,
                                              color: value
                                                          .appointmentDetail
                                                          .freelancer!
                                                          .rating! >=
                                                      4
                                                  ? ThemeProvider
                                                      .neutralAppColor1
                                                  : ThemeProvider.greyColor,
                                              size: 12),
                                          Icon(Icons.star,
                                              color: value
                                                          .appointmentDetail
                                                          .freelancer!
                                                          .rating! >=
                                                      5
                                                  ? ThemeProvider
                                                      .neutralAppColor1
                                                  : ThemeProvider.greyColor,
                                              size: 12),
                                          const SizedBox(width: 6),
                                          Text(
                                            value.appointmentDetail.freelancer!
                                                .rating
                                                .toString(),
                                            style: const TextStyle(
                                                color: ThemeProvider.blackColor,
                                                fontFamily: 'medium',
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.mail_outline,
                                              size: 14,
                                              color: ThemeProvider.greyColor),
                                          const SizedBox(width: 4),
                                          smallBoldText(value.appointmentDetail
                                              .freelancer?.email
                                              .toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.call,
                                              size: 14,
                                              color: ThemeProvider.greyColor),
                                          const SizedBox(width: 4),
                                          smallBoldText(value.appointmentDetail
                                              .freelancer?.mobile
                                              .toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                MyElevatedButton(
                                  onPressed: () {
                                    value.makePhoneCall();
                                  },
                                  color: ThemeProvider.appColorTint,
                                  height: 40,
                                  width: 40,
                                  child: const Icon(Icons.call,
                                      color: ThemeProvider.appColor),
                                ),
                                const SizedBox(width: 8),
                                MyElevatedButton(
                                  onPressed: () {
                                    value.onChat();
                                  },
                                  color: ThemeProvider.appColorTint,
                                  height: 40,
                                  width: 40,
                                  child: const Icon(Icons.chat,
                                      color: ThemeProvider.appColor),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: myBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: heading4('My Appointment'.tr),
                            ),
                            const Divider(
                              thickness: 2,
                              color: ThemeProvider.backgroundColor,
                              height: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                value.appointmentDetail.items!.length,
                                (itemIndex) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.appointmentDetail
                                              .items![itemIndex].name
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'medium',
                                              fontSize: 12),
                                        ),
                                        smallBoldText(
                                          value.currencySide == 'left'
                                              ? '${value.currencySymbol}${value.appointmentDetail.items![itemIndex].off.toString()}'
                                              : '${value.appointmentDetail.items![itemIndex].off.toString()}${value.currencySymbol}',
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        thickness: 1,
                                        color: ThemeProvider.backgroundColor),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Item Total'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.appointmentDetail.total.toString()}'
                                      : '${value.appointmentDetail.total.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Item discount'.tr),
                                Text(
                                  value.currencySide == 'left'
                                      ? '-${value.currencySymbol}${value.appointmentDetail.discount.toString()}'
                                      : '-${value.appointmentDetail.discount.toString()}${value.currencySymbol}',
                                  style: const TextStyle(
                                      color: ThemeProvider.neutralAppColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Distance Charge'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.appointmentDetail.distanceCost.toString()}'
                                      : '${value.appointmentDetail.distanceCost.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Taxes and Charges'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.appointmentDetail.serviceTax.toString()}'
                                      : '${value.appointmentDetail.serviceTax.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Wallet Discount'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.appointmentDetail.walletPrice.toString()}'
                                      : '${value.appointmentDetail.walletPrice.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const Divider(thickness: 1, color: Colors.black12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading4('Grand Total'.tr),
                                heading4(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.appointmentDetail.grandTotal.toString()}'
                                      : '${value.appointmentDetail.grandTotal.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: myBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: heading4('Booking Details'.tr),
                            ),
                            const Divider(
                              thickness: 2,
                              color: ThemeProvider.backgroundColor,
                              height: 24,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        heading4(value.addressTitles[value
                                            .appointmentDetail
                                            .address!
                                            .title as int]),
                                        smallText(
                                            '${value.appointmentDetail.address!.house.toString()}, '
                                            '${value.appointmentDetail.address!.address.toString()}, '
                                            '${value.appointmentDetail.address!.landmark.toString()}, '
                                            '${value.appointmentDetail.address!.pincode}'),
                                      ],
                                    ))
                              ],
                            ),
                            const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                                const SizedBox(width: 4),
                                smallText(
                                    value.appointmentDetail.slot.toString()),
                              ],
                            ),
                            const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                                const SizedBox(width: 4),
                                smallText(value.appointmentDetail.saveDate
                                    .toString()),
                              ],
                            ),
                            const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Appointment Number'.tr),
                                const SizedBox(height: 4),
                                smallBoldText(
                                  value.appointmentDetail.id.toString(),
                                ),
                              ],
                            ),
                            const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Payment'.tr),
                                const SizedBox(height: 4),
                                smallBoldText(
                                  value.paymentName[
                                      value.appointmentDetail.payMethod as int],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: value.apiCalled == false
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: value.appointmentDetail.status == 1 ||
                          value.appointmentDetail.status == 2 ||
                          value.appointmentDetail.status == 3 ||
                          value.appointmentDetail.status == 7 ||
                          value.appointmentDetail.status == 8 ||
                          value.appointmentDetail.status == 5 ||
                          value.appointmentDetail.status == 6
                      ? Text(
                          '${'Your Appoinments Status'.tr} : ${value.orderStatus}',
                          textAlign: TextAlign.center,
                        )
                      : value.appointmentDetail.status == 0
                          ? MyElevatedButton(
                              onPressed: () {
                                value.onUpdateAppointmentStatus(5);
                              },
                              color: ThemeProvider.appColor,
                              height: 40,
                              width: double.infinity,
                              child: Text(
                                'Cancel'.tr,
                                style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    color: ThemeProvider.whiteColor,
                                    fontFamily: 'bold'),
                              ),
                            )
                          : value.appointmentDetail.status == 4
                              ? SizedBox(
                                  height: 65,
                                  child: Column(
                                    children: [
                                      MyElevatedButton(
                                        onPressed: () {
                                          value.onAddReview(value
                                              .appointmentDetail
                                              .freelancerId as int);
                                        },
                                        color: ThemeProvider.appColor,
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          'Add Review'.tr,
                                          style: const TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 16,
                                              color: ThemeProvider.whiteColor,
                                              fontFamily: 'bold'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                ),
        );
      },
    );
  }
}
