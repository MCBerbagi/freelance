/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/model/services_model.dart';
import 'package:handyman/app/backend/parse/cart_parse.dart';
import 'package:handyman/app/controller/service_detail_controller.dart';
import 'package:handyman/app/controller/subcategory_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';

class CartController extends GetxController implements GetxService {
  final CartParser parser;
  List<ServiceModel> _savedInCart = <ServiceModel>[];
  List<ServiceModel> get savedInCart => _savedInCart;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  double _walletDiscount = 0.0;
  double get walletDiscount => _walletDiscount;

  double _orderTax = 0.0;
  double get orderTax => _orderTax;

  double _orderPrice = 0.0;
  double get orderPrice => _orderPrice;

  double _shippingPrice = 0.0;
  double get shippingPrice => _shippingPrice;

  double _freeShipping = 0.0;
  double get freeShipping => _freeShipping;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  int _shippingMethod = AppConstants.defaultShippingMethod;
  int get shippingMethod => _shippingMethod;

  CartController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySide = parser.getCurrencySide();
    currencySymbol = parser.getCurrencySymbol();
    _shippingMethod = parser.getShippingMethod();
    _shippingPrice = parser.shippingPrice();
    _freeShipping = parser.freeOrderPrice();
    _orderTax = parser.taxOrderPrice();
  }

  void getCart() {
    _savedInCart = [];
    _savedInCart.addAll(parser.getCartProducts());
    calcuate();
    update();
  }

  void addItem(ServiceModel product) {
    _savedInCart.add(product);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void removeItem(ServiceModel product) {
    _savedInCart.removeWhere(
        (element) => element.id == product.id && element.name == product.name);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void deleteFromList(ServiceModel product) {
    _savedInCart.removeWhere(
        (element) => element.id == product.id && element.name == product.name);
    parser.saveCart(_savedInCart);
    calcuate();
    Get.find<SubcategoryController>().onChangeService();
    update();
  }

  bool checkProductInCart(int id) {
    return savedInCart.where((element) => element.id == id).isNotEmpty;
  }

  void calcuate() {
    debugPrint(jsonEncode(_savedInCart));
    double total = 0;
    for (var element in _savedInCart) {
      if (element.discount! > 0) {
        total = total + element.off!;
      } else {
        total = total + element.price!;
      }
    }
    _totalPrice = total;
    _totalPrice = totalPrice;
    update();
  }

  void clearCart() {
    _savedInCart = [];
    _totalPrice = 0.0;
    _grandTotal = 0.0;
    _walletDiscount = 0.0;
    _orderPrice = 0.0;
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void onServicesDetail(int id) {
    Get.delete<ServiceDetailController>(force: true);
    Get.toNamed(
      AppRouter.getServiceDetailRoute(),
      arguments: [id],
    );
  }
}
