/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/parse/web_payment_product_parse.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:jiffy/jiffy.dart';

class WebPaymentProductController extends GetxController
    implements GetxService {
  final WebPaymentProductParse parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  WebPaymentProductController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    apiURL = parser.apiService.appBaseUrl;
    payMethod = Get.arguments[0];
    if (payMethod != 'instamojo') {
      paymentURL = apiURL + Get.arguments[1];
    } else {
      paymentURL = Get.arguments[1];
    }
    update();
  }

  Future<void> createOrder(String orderId) async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);

    var param = {
      "uid": parser.getUID(),
      "freelancer_id":
          Get.find<ProductCheckoutController>().savedInCart[0].freelacerId,
      "date_time": Jiffy().format('yyyy-MM-dd'),
      "paid_method": Get.find<ProductCheckoutController>().paymentId,
      "order_to": "home",
      "orders": jsonEncode(Get.find<ProductCheckoutController>().savedInCart),
      "notes": 'NA',
      "total": Get.find<ProductCartController>().totalPrice,
      "tax": Get.find<ProductCartController>().orderTax,
      "grand_total": Get.find<ProductCheckoutController>().grandTotal,
      "discount": Get.find<ProductCheckoutController>().discount,
      "delivery_charge": Get.find<ProductCheckoutController>().deliveryPrice,
      "extra": 'NA',
      "pay_key": orderId,
      "status": 0,
      "payStatus": 1,
      "address": jsonEncode(Get.find<ProductCheckoutController>().addressInfo),
      "coupon_code":
          jsonEncode(Get.find<ProductCheckoutController>().selectedCoupon)
    };
    debugPrint(param.toString());
    var response = await parser.createProductOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      var notificationParam = {
        "id": Get.find<ProductCheckoutController>().savedInCart[0].freelacerId,
        "title": "New Order Received",
        "message": "You have received new order"
      };
      await parser.sendNotification(notificationParam);
      Get.defaultDialog(
        title: '',
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ThemeProvider.appColor,
                    borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/check.png',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Thank You!'.tr,
                style: const TextStyle(fontFamily: 'bold', fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'For Your Order'.tr,
                style: const TextStyle(fontFamily: 'semi-bold', fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                    .tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  backOrders();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ThemeProvider.whiteColor,
                  backgroundColor: ThemeProvider.appColor,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'TRACK MY ORDER'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  backHome();
                },
                child: Text(
                  'BACK TO HOME'.tr,
                  style: const TextStyle(color: ThemeProvider.appColor),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void backHome() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(0);
    Get.offAllNamed(AppRouter.getTabsRoute());
  }

  void backOrders() {
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(4);
    Get.offAllNamed(AppRouter.getTabsRoute());
  }

  Future<void> verifyRazorpayPurchase(String payKey) async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Creating Order".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    Response response = await parser.verifyPurchase(payKey);
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['status'] == 'captured') {
        Get.back();
        createOrder(jsonEncode(body));
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
    update();
  }
}
