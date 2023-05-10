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
import 'package:handyman/app/backend/parse/web_payment_parse.dart';
import 'package:handyman/app/controller/booking_controller.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';

class WebPaymentController extends GetxController implements GetxService {
  final WebPaymentParse parser;
  String payMethod = '';
  String paymentURL = '';
  String apiURL = '';
  WebPaymentController({required this.parser});

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
      "freelancer_id": Get.find<CartController>().savedInCart[0].uid,
      "order_to": 1,
      "address": jsonEncode(Get.find<CheckoutController>().addressInfo),
      "items": jsonEncode(Get.find<CartController>().savedInCart),
      "coupon_id": Get.find<CheckoutController>().selectedCoupon.id ?? 0,
      "coupon": Get.find<CheckoutController>().selectedCoupon.id != null
          ? jsonEncode(Get.find<CheckoutController>().selectedCoupon)
          : 'NA',
      "discount": Get.find<CheckoutController>().discount,
      "total": Get.find<CartController>().totalPrice,
      "serviceTax": Get.find<CartController>().orderTax,
      "grand_total": Get.find<CheckoutController>().grandTotal,
      "pay_method": Get.find<CheckoutController>().paymentId,
      "paid": orderId,
      "wallet_used": 0,
      "wallet_price": 0,
      "notes": Get.find<CheckoutController>().notesTextEditor.text.isNotEmpty
          ? Get.find<CheckoutController>().notesTextEditor.text
          : 'NA',
      "status": 0,
      "save_date": Get.find<BookingController>().savedDate,
      "slot": Get.find<BookingController>().selectedSlotIndex,
      "distance_cost": Get.find<CheckoutController>().deliveryPrice
    };
    debugPrint(param.toString());
    var response = await parser.createOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      var notificationParam = {
        "id": Get.find<CartController>().savedInCart[0].uid,
        "title": "New Appointment Received",
        "message": "You have received new appointments"
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
    Get.delete<CartController>(force: true);
    Get.offAllNamed(AppRouter.getTabsRoute());
    Get.find<TabsController>().updateTabId(0);
  }

  void backOrders() {
    Get.delete<CartController>(force: true);
    Get.offAllNamed(AppRouter.getTabsRoute());
    Get.find<TabsController>().updateTabId(1);
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
