/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:handyman/app/util/constant.dart';

class ProductCartParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProductCartParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveCart(List<ProductModel> products) {
    List<String> carts = [];
    for (var cartModel in products) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferencesManager.putStringList('productCart', carts);
  }

  List<ProductModel> getCartProducts() {
    List<String>? carts = [];

    if (sharedPreferencesManager.isKeyExists('productCart') ?? false) {
      carts = sharedPreferencesManager.getStringList('productCart');
    }
    List<ProductModel> cartList = <ProductModel>[];
    carts?.forEach((element) {
      var data = jsonDecode(element);
      cartList.add(ProductModel.fromJson(data));
    });
    return cartList;
  }

  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null &&
            sharedPreferencesManager.getString('uid') != ''
        ? true
        : false;
  }

  double shippingPrice() {
    return sharedPreferencesManager.getDouble('shippingPrice') ?? 0.0;
  }

  int getShippingMethod() {
    return sharedPreferencesManager.getInt('shipping') ??
        AppConstants.defaultShippingMethod;
  }

  double freeOrderPrice() {
    return sharedPreferencesManager.getDouble('free') ?? 0.0;
  }

  double getAllowedDeliveryRadius() {
    return sharedPreferencesManager.getDouble('allowDistance') ??
        AppConstants.defaultDeliverRadius;
  }

  double taxOrderPrice() {
    return sharedPreferencesManager.getDouble('tax') ?? 0.0;
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  String getPhone() {
    return sharedPreferencesManager.getString('phone') ?? '';
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }

  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getAppLogo() {
    return sharedPreferencesManager.getString('appLogo') ?? '';
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }
}
