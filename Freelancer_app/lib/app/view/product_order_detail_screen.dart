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
import 'package:handyman_freelancer/app/controller/product_order_detail_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

class ProductOrderDetailScreen extends StatefulWidget {
  const ProductOrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductOrderDetailScreen> createState() =>
      _ProductOrderDetailScreenState();
}

class _ProductOrderDetailScreenState extends State<ProductOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductOrderDetailController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              '${'ORDER'.tr} #${value.orderId}',
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
                                        '${Environments.apiBaseURL}storage/images/${value.orderDetail.userInfo?.cover.toString()}'),
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
                                        '${value.orderDetail.userInfo?.firstName} '
                                        '${value.orderDetail.userInfo?.lastName}',
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
                                                  '${value.orderDetail.userInfo?.email}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: ThemeProvider
                                                          .blackColor,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  '${value.orderDetail.userInfo?.countryCode} '
                                                  '${value.orderDetail.userInfo?.mobile}',
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
                              child: heading4('Order Details'.tr),
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
                                        .orderDetail.address!.title as int]),
                                    const SizedBox(height: 4),
                                    smallBoldText(
                                        '${value.orderDetail.address!.house.toString()}, '
                                        '${value.orderDetail.address!.address.toString()}, '),
                                    smallBoldText(
                                        '${value.orderDetail.address!.landmark.toString()}, '
                                        '${value.orderDetail.address!.pincode}'),
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
                                  Icons.calendar_month,
                                  size: 14,
                                  color: ThemeProvider.greyColor,
                                ),
                                const SizedBox(width: 4),
                                smallBoldText(
                                    value.orderDetail.dateTime.toString()),
                              ],
                            ),
                            const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Order Number'.tr),
                                const SizedBox(height: 4),
                                smallBoldText(
                                  value.orderDetail.id.toString(),
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
                                      value.orderDetail.paidMethod as int],
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
                              child: heading4('Orders'.tr),
                            ),
                            const Divider(
                              thickness: 2,
                              color: ThemeProvider.backgroundColor,
                              height: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                value.orderDetail.orders!.length,
                                (itemIndex) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.orderDetail.orders![itemIndex]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'medium',
                                              fontSize: 12),
                                        ),
                                        smallBoldText(
                                          value.currencySide == 'left'
                                              ? '${value.currencySymbol}${value.orderDetail.orders![itemIndex].sellPrice.toString()}'
                                              : '${value.orderDetail.orders![itemIndex].sellPrice.toString()}${value.currencySymbol}',
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
                                      ? '${value.currencySymbol}${value.orderDetail.total.toString()}'
                                      : '${value.orderDetail.total.toString()}${value.currencySymbol}',
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
                                      ? '-${value.currencySymbol}${value.orderDetail.discount.toString()}'
                                      : '-${value.orderDetail.discount.toString()}${value.currencySymbol}',
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
                                smallText('Delivery Charge'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.orderDetail.deliveryCharge.toString()}'
                                      : '${value.orderDetail.deliveryCharge.toString()}${value.currencySymbol}',
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
                                      ? '${value.currencySymbol}${value.orderDetail.tax.toString()}'
                                      : '${value.orderDetail.tax.toString()}${value.currencySymbol}',
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
                                      ? '${value.currencySymbol}${value.orderDetail.grandTotal.toString()}'
                                      : '${value.orderDetail.grandTotal.toString()}${value.currencySymbol}',
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
                  child: value.orderDetail.status == 2 ||
                          value.orderDetail.status == 4 ||
                          value.orderDetail.status == 5 ||
                          value.orderDetail.status == 6
                      ? Text(
                          '${'Your Order Status'.tr} : ${value.orderStatus}',
                          textAlign: TextAlign.center,
                        )
                      : value.orderDetail.status == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyElevatedButton(
                                    onPressed: () {
                                      value.onUpdateOrderStatus(1);
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
                                      value.onUpdateOrderStatus(2);
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
