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
import 'package:handyman/app/controller/booking_controller.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/widget/elevated_button.dart';
import 'package:handyman/app/env.dart';
import 'package:skeletons/skeletons.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Checkout'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          decoration: myBoxDecoration(),
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: Get.find<CartController>()
                                    .savedInCart
                                    .length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: ThemeProvider
                                                  .backgroundColor),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                ),
                                                width: 65,
                                                height: 65,
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${Get.find<CartController>().savedInCart[i].cover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/notfound.png',
                                                      fit: BoxFit.cover,
                                                      height: 65,
                                                      width: 65,
                                                    );
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              Positioned(
                                                top: -4,
                                                left: -4,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: ThemeProvider
                                                              .secondaryAppColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                  child: Text(
                                                    '${Get.find<CartController>().savedInCart[i].discount.toString()} %',
                                                    style: const TextStyle(
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        fontFamily: 'medium',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                heading4(
                                                    Get.find<CartController>()
                                                        .savedInCart[i]
                                                        .name
                                                        .toString()),
                                                const SizedBox(height: 4),
                                                smallBoldText(
                                                  Get.find<CartController>()
                                                      .savedInCart[i]
                                                      .webCatesData!
                                                      .name
                                                      .toString(),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      value.currencySide ==
                                                              'left'
                                                          ? '${value.currencySymbol}${Get.find<CartController>().savedInCart[i].price}'
                                                          : '${Get.find<CartController>().savedInCart[i].price}${value.currencySymbol}',
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: ThemeProvider
                                                              .greyColor,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      value.currencySide ==
                                                              'left'
                                                          ? '${value.currencySymbol}${Get.find<CartController>().savedInCart[i].off}'
                                                          : '${Get.find<CartController>().savedInCart[i].off}${value.currencySymbol}',
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .appColor,
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                smallText(
                                                  '${Get.find<CartController>().savedInCart[i].duration} ${'min duration'.tr}',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  value.onDeleteService(i);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: ThemeProvider
                                                      .neutralAppColor2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: myBoxDecoration(),
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 60,
                                width: 60,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.freelancerDetail.cover.toString()}'),
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
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heading4(
                                        value.freelancerDetail.name.toString()),
                                    const SizedBox(height: 4),
                                    smallText(
                                      '${value.freelancerDetail.totalExperience} ${'year experience'.tr}',
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 16),
                          child: heading3('Notes for service'.tr),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CupertinoTextField(
                            controller: value.notesTextEditor,
                            placeholder: 'Write Notes'.tr,
                            maxLines: 3,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(bottom: 8, top: 16),
                          child: heading3('Offers & Benefits'.tr),
                        ),
                        Card(
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: value.offerName.isEmpty
                                ? Text('Apply Coupon Code'.tr)
                                : Text('Coupon Applied :'.tr + value.offerName),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              if (value.isWalletChecked == false) {
                                value.onCoupens(value.offerId, value.offerName);
                              }
                            },
                          ),
                        ),
                        Card(
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            leading: Checkbox(
                              checkColor: Colors.white,
                              activeColor: ThemeProvider.appColor,
                              value: value.isWalletChecked,
                              onChanged: value.balance <= 0 ||
                                      value.offerName.isNotEmpty
                                  ? null
                                  : (bool? status) {
                                      value.updateWalletChecked(status!);
                                    },
                            ),
                            title: value.currencySide == 'left'
                                ? Text(
                                    '${'Available Balance'.tr + value.currencySymbol}${value.balance}')
                                : Text(
                                    '${'Available Balance'.tr + value.balance.toString()}${value.currencySymbol}'),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(bottom: 16, top: 24),
                          child: heading3('Bill Details'.tr),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: myBoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('Item Total'.tr),
                                  bodyText1(
                                    value.currencySide == 'left'
                                        ? '${value.currencySymbol}${Get.find<CartController>().totalPrice.toString()}'
                                        : '${Get.find<CartController>().totalPrice.toString()}${value.currencySymbol}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('Item discount'.tr),
                                  Text(
                                    value.currencySide == 'left'
                                        ? '-${value.currencySymbol}${value.discount.toString()}'
                                        : '-${value.discount.toString()}${value.currencySymbol}',
                                    style: const TextStyle(
                                        color: ThemeProvider.neutralAppColor2,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('Distance Charge'.tr),
                                  bodyText1(
                                    value.currencySide == 'left'
                                        ? '${value.currencySymbol}${value.deliveryPrice.toString()}'
                                        : '${value.deliveryPrice.toString()}${value.currencySymbol}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bodyText1('Taxes and Charges'.tr),
                                  bodyText1(
                                    value.currencySide == 'left'
                                        ? '${value.currencySymbol}${Get.find<CartController>().orderTax.toString()}'
                                        : '${Get.find<CartController>().orderTax.toString()}${value.currencySymbol}',
                                  ),
                                ],
                              ),
                              const Divider(
                                  thickness: 1, color: Colors.black12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  heading3('To Pay'.tr),
                                  heading3(
                                    value.currencySide == 'left'
                                        ? '${value.currencySymbol}${value.grandTotal.toString()}'
                                        : '${value.grandTotal.toString()}${value.currencySymbol}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(bottom: 16, top: 24),
                          child: heading3('Payment Method'.tr),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: value.paymentList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, i) => Column(
                            children: [
                              Card(
                                child: RadioListTile(
                                  value: value.paymentList[i].id.toString(),
                                  groupValue: value.paymentId.toString(),
                                  onChanged: (data) {
                                    value.savePayment(data.toString());
                                  },
                                  title: Text(
                                      value.paymentList[i].name.toString()),
                                  // subtitle: Text("subtext"),
                                  secondary: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          '${Environments.apiBaseURL}storage/images/${value.paymentList[i].cover.toString()}'),
                                      placeholder: const AssetImage(
                                          "assets/images/placeholder.jpeg"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/notfound.png',
                                          fit: BoxFit.cover,
                                          width: 32,
                                          height: 32,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  activeColor: ThemeProvider.appColor,
                                  toggleable: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Container(
            color: Colors.white,
            height: 136,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    value.onSelectAddress();
                  },
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.location_on, size: 14),
                  minLeadingWidth: 0,
                  title: value.haveAddress == true
                      ? Text(
                          '${value.addressInfo.address} ${value.addressInfo.landmark}',
                          style: const TextStyle(fontSize: 14),
                        )
                      : Text('Please Add Your Address'.tr),
                  trailing: const Icon(Icons.edit_outlined, size: 14),
                ),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.access_time_sharp, size: 14),
                  minLeadingWidth: 0,
                  title: Text(
                    '${Get.find<BookingController>().savedDate} ${Get.find<BookingController>().selectedSlotIndex}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.edit_outlined, size: 14),
                  onTap: () {
                    value.onBack();
                  },
                ),
                value.haveFairDeliveryRadius == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: MyElevatedButton(
                            onPressed: () {
                              value.onCheckout();
                            },
                            color: ThemeProvider.appColor,
                            height: 42,
                            width: double.infinity,
                            child: Text(
                              value.currencySide == 'left'
                                  ? '${'Pay'} ${value.currencySymbol}${value.grandTotal}'
                                  : '${'Pay'} ${value.grandTotal}${value.currencySymbol}',
                              style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  color: ThemeProvider.whiteColor,
                                  fontFamily: 'bold'),
                            )),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
