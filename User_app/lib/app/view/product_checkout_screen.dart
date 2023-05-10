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
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class ProductCheckoutScreen extends StatefulWidget {
  const ProductCheckoutScreen({Key? key}) : super(key: key);

  @override
  State<ProductCheckoutScreen> createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCheckoutController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Product Checkout'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: List.generate(
                            value.savedInCart.length,
                            (i) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: ThemeProvider.backgroundColor),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: FadeInImage(
                                          image: NetworkImage(
                                              '${Environments.apiBaseURL}storage/images/${Get.find<ProductCartController>().savedInCart[i].cover}'),
                                          placeholder: const AssetImage(
                                              "assets/images/placeholder.jpeg"),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/notfound.png',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: -4,
                                        left: -4,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          decoration: const BoxDecoration(
                                              color: ThemeProvider
                                                  .secondaryAppColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: Text(
                                            '${Get.find<ProductCartController>().savedInCart[i].discount.toString()} %',
                                            style: const TextStyle(
                                                color: ThemeProvider.whiteColor,
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
                                        heading3(
                                            Get.find<ProductCartController>()
                                                .savedInCart[i]
                                                .name
                                                .toString()),
                                        const SizedBox(height: 4),
                                        smallText(
                                            Get.find<ProductCartController>()
                                                .savedInCart[i]
                                                .kg
                                                .toString()),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol}${Get.find<ProductCartController>().savedInCart[i].originalPrice.toString()}'
                                                  : '${Get.find<ProductCartController>().savedInCart[i].originalPrice.toString()}${value.currencySymbol}',
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              value.currencySide == 'left'
                                                  ? '${value.currencySymbol}${Get.find<ProductCartController>().savedInCart[i].sellPrice.toString()}'
                                                  : '${Get.find<ProductCartController>().savedInCart[i].sellPrice.toString()}${value.currencySymbol}',
                                              style: const TextStyle(
                                                  color: ThemeProvider.appColor,
                                                  fontFamily: 'bold',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      MyElevatedButton(
                                          onPressed: () {
                                            value
                                                .updateProductQuantityRemove(i);
                                          },
                                          color:
                                              ThemeProvider.secondaryAppColor,
                                          height: 20,
                                          width: 20,
                                          child: const Icon(Icons.remove,
                                              size: 14)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: heading4(value
                                            .savedInCart[i].quantity
                                            .toString()),
                                      ),
                                      MyElevatedButton(
                                          onPressed: () {
                                            value.updateProductQuantity(i);
                                          },
                                          color:
                                              ThemeProvider.secondaryAppColor,
                                          height: 20,
                                          width: 20,
                                          child:
                                              const Icon(Icons.add, size: 14))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(bottom: 16, top: 24),
                        child: heading3('Offers & Benefits'.tr),
                      ),
                      Card(
                        child: ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
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
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Checkbox(
                            checkColor: Colors.white,
                            activeColor: ThemeProvider.appColor,
                            value: value.isWalletChecked,
                            onChanged:
                                value.balance <= 0 || value.offerName.isNotEmpty
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bodyText1('Item Total'.tr),
                                bodyText1(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${Get.find<ProductCartController>().totalPrice.toString()}'
                                      : '${Get.find<ProductCartController>().totalPrice.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bodyText1('Taxes and Charges'.tr),
                                bodyText1(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${Get.find<ProductCartController>().orderTax.toString()}'
                                      : '${Get.find<ProductCartController>().orderTax.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bodyText1('Delivery Charge'.tr),
                                bodyText1(
                                  value.currencySide == 'left'
                                      ? '${value.currencySymbol}${value.deliveryPrice.toString()}'
                                      : '${value.deliveryPrice.toString()}${value.currencySymbol}',
                                ),
                              ],
                            ),
                            const Divider(thickness: 1, color: Colors.black12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                title:
                                    Text(value.paymentList[i].name.toString()),
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
          height: 100,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  value.onSelectAddress();
                },
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                                ? '${'Pay'.tr} ${value.currencySymbol}${value.grandTotal}'
                                : '${'Pay'.tr} ${value.grandTotal}${value.currencySymbol}',
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
    });
  }
}
