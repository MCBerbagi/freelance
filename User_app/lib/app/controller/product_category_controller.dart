/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/product_category_model.dart';
import 'package:handyman/app/backend/parse/product_category_parse.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/controller/product_listing_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';

class ProductCategoryController extends GetxController implements GetxService {
  final ProductCategoryParser parser;

  bool apiCalled = false;
  int cartTotal = 0;
  double total = 0.0;

  List<ProductCategoryModel> _productCategoryList = <ProductCategoryModel>[];
  List<ProductCategoryModel> get productCategoryList => _productCategoryList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  ProductCategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    getAllProductCategories();
  }

  Future<void> getAllProductCategories() async {
    var response = await parser.getAllProductCategories();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _productCategoryList = [];
      body.forEach((element) {
        ProductCategoryModel datas = ProductCategoryModel.fromJson(element);
        _productCategoryList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  void onProductList(int id, String name) {
    Get.delete<ProductListingController>(force: true);
    Get.toNamed(
      AppRouter.getProductListingRoute(),
      arguments: [id, name],
    );
  }

  void updateCartValue() {
    cartTotal = Get.find<ProductCartController>().savedInCart.length;
    total = Get.find<ProductCartController>().totalPrice;
    update();
  }

  void onProductCheckout() {
    if (parser.isLogin() == true) {
      Get.delete<ProductCheckoutController>(force: true);
      Get.toNamed(AppRouter.getProductCheckoutRoute());
    } else {
      debugPrint('go to login');
      Get.delete<ProductCheckoutController>(force: true);
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['product-checkout']);
    }
  }
}
