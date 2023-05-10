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
import 'package:handyman/app/backend/model/stripe_model.dart';
import 'package:handyman/app/backend/parse/stripe_pay_parse.dart';
import 'package:handyman/app/controller/add_card_controller.dart';
import 'package:handyman/app/controller/booking_controller.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:jiffy/jiffy.dart';

class StripePayController extends GetxController implements GetxService {
  final StripePayParse parser;
  bool apiCalled = false;
  bool cardsListCalled = false;
  List<StripeCardsModel> _cards = <StripeCardsModel>[];
  List<StripeCardsModel> get cards => _cards;
  String stripeKey = '';
  String selectedCard = '';
  String actionFrom = '';
  double grandTotal = 0.0;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencyCode = '';
  StripePayController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    actionFrom = Get.arguments[0]; // services
    grandTotal = Get.arguments[1];
    currencyCode = Get.arguments[2];
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    getProfile();
  }

  Future<void> getProfile() async {
    Response response = await parser.getProfile();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null && body != '') {
        stripeKey = body['stripe_key'] ?? '';
        getStringCards();
        update();
      }
    } else {
      cardsListCalled = true;
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> getStringCards() async {
    if (stripeKey != '' && stripeKey.isNotEmpty) {
      Response response = await parser.getStripeCards(stripeKey);
      cardsListCalled = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        dynamic body = myMap["success"];
        _cards = [];
        body['data'].forEach((data) {
          StripeCardsModel datas = StripeCardsModel.fromJson(data);
          _cards.add(datas);
        });
      } else {
        cardsListCalled = true;
        ApiChecker.checkApi(response);
        update();
      }
      update();
    } else {
      cardsListCalled = true;
      update();
    }
  }

  void onAddCard() {
    Get.delete<AddCardController>(force: true);
    Get.toNamed(AppRouter.getNewCardRoutes());
  }

  void saveCardToPay(String id) {
    selectedCard = id;
    update();
  }

  void createPayment() {
    if (selectedCard != '' && selectedCard.isNotEmpty) {
      Get.generalDialog(
          pageBuilder: (context, __, ___) => AlertDialog(
                title: Text('Are you sure?'.tr),
                content: Text(
                    "Orders once placed cannot be cancelled and are non-refundable"
                        .tr),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.blackColor,
                          fontFamily: 'medium'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      makePayment();
                    },
                    child: Text(
                      'Yes, Place Order'.tr,
                      style: const TextStyle(
                          color: ThemeProvider.appColor, fontFamily: 'bold'),
                    ),
                  )
                ],
              ));
    } else {
      showToast('Please select card'.tr);
    }
  }

  Future<void> makePayment() async {
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
    var param = {
      'amount': grandTotal.toInt() * 100,
      'currency': currencyCode,
      'customer': stripeKey,
      'card': selectedCard
    };
    Response response = await parser.checkout(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic successResponse = myMap["success"];
      if (actionFrom == 'services') {
        createOrder(successResponse);
      } else {
        createProductOrder(successResponse);
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  Future<void> createProductOrder(dynamic paymentInfo) async {
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
      "grand_total": grandTotal,
      "discount": Get.find<ProductCheckoutController>().discount,
      "delivery_charge": Get.find<ProductCheckoutController>().deliveryPrice,
      "extra": 'NA',
      "pay_key": jsonEncode(paymentInfo),
      "status": 0,
      "payStatus": 1,
      "address": jsonEncode(Get.find<ProductCheckoutController>().addressInfo),
      "coupon_code":
          jsonEncode(Get.find<ProductCheckoutController>().selectedCoupon)
    };
    var response = await parser.createProductOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
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
                    height: 80,
                    width: 80,
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
                style: const TextStyle(fontFamily: 'medium', fontSize: 16),
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

  Future<void> createOrder(dynamic paymentInfo) async {
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
      "grand_total": grandTotal,
      "pay_method": Get.find<CheckoutController>().paymentId,
      "paid": jsonEncode(paymentInfo),
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
    var response = await parser.createOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
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
                    height: 80,
                    width: 80,
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
                style: const TextStyle(fontFamily: 'medium', fontSize: 16),
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
    Get.find<CartController>().clearCart();
    Get.offAllNamed(AppRouter.getTabsRoute());
    Get.find<TabsController>().updateTabId(0);
  }

  void backOrders() {
    Get.find<CartController>().clearCart();
    Get.offAllNamed(AppRouter.getTabsRoute());
    Get.find<TabsController>().updateTabId(1);
  }
}
