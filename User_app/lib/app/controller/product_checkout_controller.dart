/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/address_model.dart';
import 'package:handyman/app/backend/model/freelancer_model.dart';
import 'package:handyman/app/backend/model/offers_model.dart';
import 'package:handyman/app/backend/model/payment_model.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/parse/product_checkout_parse.dart';
import 'package:handyman/app/controller/address_list_controller.dart';
import 'package:handyman/app/controller/coupens_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/stripe_pay_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/controller/web_payment_product_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:jiffy/jiffy.dart';

class ProductCheckoutController extends GetxController implements GetxService {
  final ProductCheckoutParser parser;

  double _discount = 0.0;
  double get discount => _discount;

  List<ProductModel> _savedInCart = <ProductModel>[];
  List<ProductModel> get savedInCart => _savedInCart;

  late OffersModel _selectedCoupon = OffersModel();
  OffersModel get selectedCoupon => _selectedCoupon;

  List<PaymentModel> _paymentList = <PaymentModel>[];
  List<PaymentModel> get paymentList => _paymentList;

  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;

  bool apiCalled = false;

  int paymentId = 0;
  String payMethodName = '';

  String selectedAddressId = '';
  bool haveAddress = false;

  String offerId = '';
  String offerName = '';

  bool haveFairDeliveryRadius = false;

  double _deliveryPrice = 0.0;
  double get deliveryPrice => _deliveryPrice;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  FreelancerModel _freelancerDetail = FreelancerModel();
  FreelancerModel get freelancerDetail => _freelancerDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  bool isWalletChecked = false;
  double balance = 0.0;
  double walletDiscount = 0.0;

  ProductCheckoutController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    _savedInCart = Get.find<ProductCartController>().savedInCart;
    getMyWalletAmount();
    getFreelancerByID();
    calculateAllCharge();
    getSavedAddress();
    getPayments();
  }

  Future<void> getMyWalletAmount() async {
    Response response = await parser.getMyWalletBalance();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body != null &&
          body != '' &&
          body['balance'] != null &&
          body['balance'] != '') {
        balance = double.tryParse(body['balance'].toString()) ?? 0.0;
        walletDiscount = double.tryParse(body['balance'].toString()) ?? 0.0;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getFreelancerByID() async {
    var response = await parser.getFreelancerByID(
        {"id": Get.find<ProductCartController>().savedInCart[0].freelacerId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      _freelancerDetail = FreelancerModel();

      var body = myMap['data'];

      FreelancerModel data = FreelancerModel.fromJson(body);

      _freelancerDetail = data;
      calculateDistance();
      debugPrint(body.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> getPayments() async {
    var response = await parser.getPayments();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _paymentList = [];
      body.forEach(
        (element) {
          PaymentModel datas = PaymentModel.fromJson(element);
          _paymentList.add(datas);
        },
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void savePayment(String id) {
    paymentId = int.parse(id);
    if (paymentId == 1) {
      payMethodName = 'cod';
    } else if (paymentId == 2) {
      payMethodName = 'stripe';
    } else if (paymentId == 3) {
      payMethodName = 'paypal';
    } else if (paymentId == 4) {
      payMethodName = 'paytm';
    } else if (paymentId == 5) {
      payMethodName = 'razorpay';
    } else if (paymentId == 6) {
      payMethodName = 'instamojo';
    } else if (paymentId == 7) {
      payMethodName = 'paystack';
    } else if (paymentId == 8) {
      payMethodName = 'flutterwave';
    }
    update();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getSavedAddress(param);
    debugPrint(response.bodyString);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != null && myMap['data'] != '') {
        var address = myMap['data'];
        _addressList = [];
        _addressInfo = AddressModel();
        address.forEach((add) {
          AddressModel adds = AddressModel.fromJson(add);
          _addressList.add(adds);
        });
        if (_addressList.isNotEmpty) {
          haveAddress = true;
          _addressInfo = _addressList[0];
          selectedAddressId = _addressInfo.id.toString();
          calculateDistance();
        } else {
          haveAddress = false;
        }
        debugPrint(addressList.length.toString());
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void calculateDistance() {
    if (addressInfo.lat != null &&
        addressInfo.lng != null &&
        freelancerDetail.lat != null &&
        freelancerDetail.lng != null) {
      double storeDistance = 0.0;
      double totalMeters = 0.0;
      storeDistance = Geolocator.distanceBetween(
        double.tryParse(addressInfo.lat.toString()) ?? 0.0,
        double.tryParse(addressInfo.lng.toString()) ?? 0.0,
        double.tryParse(freelancerDetail.lat.toString()) ?? 0.0,
        double.tryParse(freelancerDetail.lng.toString()) ?? 0.0,
      );
      totalMeters = totalMeters + storeDistance;
      double distance = double.parse((storeDistance / 1000).toStringAsFixed(2));
      debugPrint(distance.toString());
      if (distance >
          Get.find<ProductCartController>().parser.getAllowedDeliveryRadius()) {
        haveFairDeliveryRadius = false;
        showToast(
            '${'Sorry we deliver the order near to'.tr} ${Get.find<ProductCartController>().parser.getAllowedDeliveryRadius()}KM');
      } else {
        if (Get.find<ProductCartController>().shippingMethod == 0) {
          double distancePricer =
              distance * Get.find<ProductCartController>().shippingPrice;
          _deliveryPrice = double.parse((distancePricer).toStringAsFixed(2));
        } else {
          _deliveryPrice = Get.find<ProductCartController>().shippingPrice;
        }
        haveFairDeliveryRadius = true;
      }
      calculateAllCharge();
      update();
    }
  }

  void updateProductQuantity(int index) {
    _savedInCart[index].quantity = _savedInCart[index].quantity + 1;
    Get.find<ProductCartController>().addQuantity(_savedInCart[index]);
    calculateAllCharge();
    update();
  }

  void updateProductQuantityRemove(int index) {
    if (_savedInCart[index].quantity == 1) {
      _savedInCart[index].quantity = 0;
      Get.find<ProductCartController>().removeItem(_savedInCart[index]);
      Get.find<TabsController>().updateCartValue();
    } else {
      _savedInCart[index].quantity = _savedInCart[index].quantity - 1;
      Get.find<ProductCartController>().addQuantity(_savedInCart[index]);
    }
    calculateAllCharge();
    update();
  }

  void onSelectAddress() {
    Get.delete<AddressListController>(force: true);
    Get.toNamed(AppRouter.getAddressListRoute(),
        arguments: ['product', selectedAddressId]);
  }

  void onSaveAddress(String id) {
    selectedAddressId = id;
    var address =
        _addressList.firstWhere((element) => element.id.toString() == id);
    _addressInfo = address;
    calculateDistance();

    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onCoupens(String offerId, String offerName) {
    Get.delete<CoupensController>(force: true);
    Get.toNamed(AppRouter.getcouponRoute(),
        arguments: ['product', offerId, offerName]);
  }

  void savedCoupens(OffersModel offer) {
    _selectedCoupon = offer;
    offerId = offer.id.toString();
    offerName = offer.name.toString();
    calculateAllCharge();
    update();
  }

  void updateWalletChecked(bool status) {
    isWalletChecked = status;
    calculateAllCharge();
    update();
  }

  void calculateAllCharge() {
    double totalPrice = Get.find<ProductCartController>().totalPrice +
        Get.find<ProductCartController>().orderTax +
        deliveryPrice;
    if (_selectedCoupon.discount != null && _selectedCoupon.discount != 0) {
      double percentage(numFirst, per) {
        return (numFirst / 100) * per;
      }

      _discount = percentage(Get.find<ProductCartController>().totalPrice,
          _selectedCoupon.discount); // null
    }
    walletDiscount = balance;
    if (isWalletChecked == true) {
      if (totalPrice <= walletDiscount) {
        walletDiscount = totalPrice;
        totalPrice = totalPrice - walletDiscount;
      } else {
        totalPrice = totalPrice - walletDiscount;
      }
    } else {
      if (totalPrice <= discount) {
        _discount = totalPrice;
        totalPrice = totalPrice - discount;
      } else {
        totalPrice = totalPrice - discount;
      }
    }
    debugPrint('grand total $totalPrice');
    _grandTotal = double.parse((totalPrice).toStringAsFixed(2));
    update();
  }

  void onCheckout() {
    debugPrint(paymentId.toString());
    if (paymentId == 0) {
      showToast('Please select payment method'.tr);
      return;
    } else if (paymentId == 1) {
      createOrder();
      // cod
      //  Order API call
    } else if (paymentId == 2) {
      Get.delete<StripePayController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      // stripe payment
      Get.toNamed(AppRouter.getStripePayRoutes(),
          arguments: ['product', grandTotal, gateway!.currencyCode.toString()]);
    } else if (paymentId == 3) {
      Get.delete<WebPaymentProductController>(force: true);
      var paymentURL = AppConstants.payPalPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebPaymentProduct(),
          arguments: [payMethodName, paymentURL]);
      // paypal
    } else if (paymentId == 4) {
      // paytm
      Get.delete<WebPaymentProductController>(force: true);
      var paymentURL = AppConstants.payTmPayLink + grandTotal.toString();
      Get.toNamed(AppRouter.getWebPaymentProduct(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 5) {
      // razorpay
      Get.delete<WebPaymentProductController>(force: true);
      var paymentPayLoad = {
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'email': parser.getEmail(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'name': parser.getName(),
        'app_color': '#f47878'
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.razorPayLink + queryString;

      Get.toNamed(AppRouter.getWebPaymentProduct(),
          arguments: [payMethodName, paymentURL]);
    } else if (paymentId == 6) {
      payWithInstaMojo();
      // instamojo
    } else if (paymentId == 7) {
      var rng = Random();
      var paykey = List.generate(12, (_) => rng.nextInt(100));
      Get.delete<WebPaymentProductController>(force: true);
      var paymentPayLoad = {
        'email': parser.getEmail(),
        'amount':
            double.parse((grandTotal * 100).toStringAsFixed(2)).toString(),
        'first_name': parser.getFirstName(),
        'last_name': parser.getLastName(),
        'ref': paykey.join()
      };
      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.paystackCheckout + queryString;

      Get.toNamed(AppRouter.getWebPaymentProduct(),
          arguments: [payMethodName, paymentURL]);
      // paystock
    } else if (paymentId == 8) {
      //flutterwave
      Get.delete<WebPaymentProductController>(force: true);
      var gateway = paymentList.firstWhereOrNull(
          (element) => element.id.toString() == paymentId.toString());
      var paymentPayLoad = {
        'amount': grandTotal.toString(),
        'email': parser.getEmail(),
        'phone': parser.getPhone(),
        'name': parser.getName(),
        'code': gateway!.currencyCode.toString(),
        'logo':
            '${parser.apiService.appBaseUrl}storage/images/${parser.getAppLogo()}',
        'app_name': Environments.appName
      };

      String queryString = Uri(queryParameters: paymentPayLoad).query;
      var paymentURL = AppConstants.flutterwaveCheckout + queryString;

      Get.toNamed(AppRouter.getWebPaymentProduct(),
          arguments: [payMethodName, paymentURL]);
    }
  }

  Future<void> createOrder() async {
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
      "freelancer_id": savedInCart[0].freelacerId,
      "date_time": Jiffy().format('yyyy-MM-dd'),
      "paid_method": paymentId,
      "order_to": "home",
      "orders": jsonEncode(savedInCart),
      "notes": 'NA',
      "total": Get.find<ProductCartController>().totalPrice,
      "tax": Get.find<ProductCartController>().orderTax,
      "grand_total": grandTotal,
      "discount": discount,
      "delivery_charge": deliveryPrice,
      "extra": 'NA',
      "pay_key": 'COD',
      "status": 0,
      "payStatus": 1,
      "address": jsonEncode(addressInfo),
      "coupon_code": jsonEncode(selectedCoupon)
    };
    var response = await parser.createProductOrder(param);
    Get.back();
    debugPrint(response.bodyString);
    if (response.statusCode == 200) {
      var notificationParam = {
        "id": savedInCart[0].freelacerId,
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
              const Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
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
    debugPrint('on Home');
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(0);
    Get.offAllNamed(AppRouter.getTabsRoute());
  }

  void backOrders() {
    debugPrint('on History');
    Get.find<ProductCartController>().clearCart();
    Get.find<TabsController>().updateTabId(4);
    Get.offAllNamed(AppRouter.getTabsRoute());
  }

  Future<void> payWithInstaMojo() async {
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
      'allow_repeated_payments': 'False',
      'amount': grandTotal,
      'buyer_name': parser.getName(),
      'purpose': 'Orders',
      'redirect_url': '${parser.apiService.appBaseUrl}/api/v1/success_payments',
      'phone': parser.getPhone() != '' ? parser.getPhone() : '8888888888888888',
      'send_email': 'True',
      'webhook': parser.apiService.appBaseUrl,
      'send_sms': 'True',
      'email': parser.getEmail()
    };
    Response response = await parser.getInstaMojoPayLink(param);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["success"];
      if (body['payment_request'] != '' &&
          body['payment_request']['longurl'] != '') {
        Get.delete<WebPaymentProductController>(force: true);
        var paymentURL = body['payment_request']['longurl'];
        Get.toNamed(AppRouter.getWebPaymentProduct(),
            arguments: [payMethodName, paymentURL]);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
