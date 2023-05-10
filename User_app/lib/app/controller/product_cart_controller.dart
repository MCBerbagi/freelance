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
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/parse/product_cart_parse.dart';
import 'package:handyman/app/controller/product_category_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/util/constant.dart';

class ProductCartController extends GetxController implements GetxService {
  final ProductCartParser parser;

  List<ProductModel> _savedInCart = <ProductModel>[];
  List<ProductModel> get savedInCart => _savedInCart;

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

  // ignore: prefer_final_fields
  double _minOrderPrice = 0.0;
  double get minOrderPrice => _minOrderPrice;

  double _freeShipping = 0.0;
  double get freeShipping => _freeShipping;

  String currencySide = AppConstants.defaultCurrencySide;
  String currencySymbol = AppConstants.defaultCurrencySymbol;

  int _shippingMethod = AppConstants.defaultShippingMethod;
  int get shippingMethod => _shippingMethod;

  bool isWalletChecked = false;

  ProductCartController({required this.parser});

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
    Get.find<TabsController>().updateCartValue();
    calcuate();
    update();
  }

  void addItem(ProductModel product) {
    _savedInCart.add(product);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void removeItem(ProductModel product) {
    _savedInCart.removeWhere(
        (element) => element.id == product.id && element.name == product.name);
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  void deleteFromList(ProductModel product) {
    _savedInCart.removeWhere(
        (element) => element.id == product.id && element.name == product.name);
    parser.saveCart(_savedInCart);
    calcuate();
    // Get.find<SubcategoryController>().onChangeService();
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
        total = total + element.sellPrice! * element.quantity;
      } else {
        total = total + element.originalPrice! * element.quantity;
      }
    }
    _totalPrice = total;
    Get.find<TabsController>().updateCartValue();
    Get.find<ProductCategoryController>().updateCartValue();
    update();
  }

  int getQuantity(int id) {
    final index = savedInCart
        .indexWhere((element) => element.id == id && element.quantity >= 1);
    return index >= 0 ? savedInCart[index].quantity : 0;
  }

  void addQuantity(ProductModel product) {
    int index = savedInCart.indexWhere((element) => element.id == product.id);
    if (product.quantity <= 0) {
      removeItem(product);
    }
    _savedInCart[index].quantity = product.quantity;
    parser.saveCart(_savedInCart);
    calcuate();
    update();
  }

  int getFreelancerId(ProductModel product) {
    return savedInCart[0].freelacerId as int;
  }

  void clearCart() {
    _savedInCart = [];
    _totalPrice = 0.0;
    _grandTotal = 0.0;
    _walletDiscount = 0.0;
    _orderPrice = 0.0;
    // _totalItemsInCart = 0;
    parser.saveCart(_savedInCart);
    Get.find<TabsController>().updateCartValue();
    calcuate();
    update();
  }
}
