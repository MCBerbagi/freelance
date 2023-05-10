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
import 'package:handyman_freelancer/app/controller/service_detail_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';
import 'package:handyman_freelancer/app/env.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Appointment #${value.appointmentId}',
              style: ThemeProvider.titleStyle,
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    value.launchInBrowser();
                  },
                  icon: const Icon(Icons.print_outlined)),
            ],
          ),
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
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
                                        '${Environments.apiBaseURL}storage/images/${value.appointmentDetail.userInfo?.cover.toString()}'),
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
                                      heading4(
                                        '${value.appointmentDetail.userInfo?.firstName} '
                                        '${value.appointmentDetail.userInfo?.lastName}',
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${value.appointmentDetail.userInfo?.email}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .blackColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  '${value.appointmentDetail.userInfo?.countryCode} '
                                                  '${value.appointmentDetail.userInfo?.mobile}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .blackColor,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          MyElevatedButton(
                                            onPressed: () {
                                              value.makePhoneCall();
                                            },
                                            color: ThemeProvider.appColorTint,
                                            height: 34,
                                            width: 34,
                                            child: const Icon(Icons.call,
                                                size: 20,
                                                color: ThemeProvider.appColor),
                                          ),
                                          const SizedBox(width: 8),
                                          MyElevatedButton(
                                            onPressed: () {
                                              value.onChat();
                                            },
                                            color: ThemeProvider.appColorTint,
                                            height: 34,
                                            width: 34,
                                            child: const Icon(Icons.chat,
                                                size: 20,
                                                color: ThemeProvider.appColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                                const SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heading4(value.addressTitles[value
                                        .appointmentDetail
                                        .address!
                                        .title as int]),
                                    const SizedBox(height: 4),
                                    smallBoldText(
                                        '${value.appointmentDetail.address!.house.toString()}, '
                                        '${value.appointmentDetail.address!.address.toString()}, '),
                                    smallBoldText(
                                        '${value.appointmentDetail.address!.landmark.toString()}, '
                                        '${value.appointmentDetail.address!.pincode}'),
                                  ],
                                )
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
                                smallBoldText(
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
                                smallBoldText(value.appointmentDetail.saveDate
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: myBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: heading4('Appointment Detail'.tr),
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
                                      color: ThemeProvider.neutralAppColor4,
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
                    ],
                  ),
                ),
          bottomNavigationBar: value.apiCalled == false
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: value.appointmentDetail.status == 2 ||
                          value.appointmentDetail.status == 4 ||
                          value.appointmentDetail.status == 5 ||
                          value.appointmentDetail.status == 6
                      ? Text(
                          '${'Your Appoinments Status'.tr} : ${value.orderStatus}',
                          textAlign: TextAlign.center,
                        )
                      : value.appointmentDetail.status == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyElevatedButton(
                                    onPressed: () {
                                      value.onUpdateAppointmentStatus(1);
                                    },
                                    color: ThemeProvider.appColor,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      'Accept'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: MyElevatedButton(
                                    onPressed: () {
                                      value.onUpdateAppointmentStatus(2);
                                    },
                                    color: ThemeProvider.greyColor,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      'Decline'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 34,
                                      decoration: myBoxDecoration(),
                                      child: DropdownButton<String>(
                                        value: value.savedStatus,
                                        underline: const SizedBox(),
                                        iconSize: 24,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        iconEnabledColor:
                                            ThemeProvider.blackColor,
                                        onChanged: (String? newValue) {
                                          value.onSelectStatus(
                                              newValue.toString());
                                        },
                                        items: value.selectStatus
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: MyElevatedButton(
                                    onPressed: () {
                                      value.updateStatus();
                                    },
                                    color: ThemeProvider.appColor,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      'Update Status'.tr,
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          color: ThemeProvider.whiteColor,
                                          fontFamily: 'bold'),
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
