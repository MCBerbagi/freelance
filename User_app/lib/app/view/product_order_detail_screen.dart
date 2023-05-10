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
import 'package:handyman/app/controller/product_order_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:skeletons/skeletons.dart';

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
              '${'Order ID'.tr} #${value.orderId}',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading4('My Order'.tr),
                                smallBoldText(
                                  '#${value.orderDetail.id}',
                                ),
                              ],
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
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                smallText('Wallet Discount'.tr),
                                smallBoldText(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.orderDetail.walletPrice.toString()}'
                                      : '${value.orderDetail.walletPrice.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
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
                                color: ThemeProvider.backgroundColor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Order Status'.tr),
                                const SizedBox(height: 4),
                                smallBoldText(
                                  value.orderDetail.status.toString(),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: ThemeProvider.backgroundColor,
                              height: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText('Sold By'.tr),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${value.orderDetail.freelancerInfo?.cover.toString()}'),
                                        placeholder: const AssetImage(
                                            "assets/images/placeholder.jpeg"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/notfound.png',
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover);
                                        },
                                        fit: BoxFit.cover,
                                        width: 32,
                                        height: 32,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: heading4(
                                          '${value.orderDetail.freelancerInfo?.firstName.toString()} '
                                          ' ${value.orderDetail.freelancerInfo?.lastName.toString()} '),
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
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heading4(value.addressTitles[value
                                        .orderDetail.address!.title as int]),
                                    smallText(
                                      '${value.orderDetail.address!.house.toString()}, '
                                      '${value.orderDetail.address!.address.toString()}, '
                                      '${value.orderDetail.address!.landmark.toString()}, '
                                      '${value.orderDetail.address!.pincode}',
                                    ),
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
                                smallText(
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
                    ],
                  ),
                ),
          bottomNavigationBar: value.apiCalled == false
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: value.orderDetail.status == 1 ||
                          value.orderDetail.status == 2 ||
                          value.orderDetail.status == 3 ||
                          value.orderDetail.status == 7 ||
                          value.orderDetail.status == 8
                      ? Text(
                          '${'Your Order Status'.tr} : ${value.orderStatus}',
                          textAlign: TextAlign.center,
                        )
                      : value.orderDetail.status == 0
                          ? MyElevatedButton(
                              onPressed: () {
                                value.onUpdateOrderStatus(5);
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
                          : SizedBox(
                              height: 65,
                              child: Column(
                                children: [
                                  const SizedBox(height: 6),
                                  MyElevatedButton(
                                    onPressed: () {
                                      value.onAddProductReview(
                                          value.orderDetail.id as int);
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
                            ),
                ),
        );
      },
    );
  }
}
