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
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/parse/top_products_parse.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_detail_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/toast.dart';

class TopProductsController extends GetxController implements GetxService {
  final TopProductsParse parser;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  List<ProductModel> _productList = <ProductModel>[];
  List<ProductModel> get productList => _productList;

  String ids = '';

  bool apiCalled = false;
  TopProductsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    ids = Get.arguments[0];
    debugPrint(ids);
    getHomeData();
  }

  Future<void> getHomeData() async {
    var response = await parser.getHomeData({"id": ids});
    apiCalled = true;
    if (response.statusCode == 200) {
      if (response.body != null) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != null) {
          var products = myMap['data'];
          _productList = [];
          products.forEach((element) {
            ProductModel datas = ProductModel.fromJson(element);
            _productList.add(datas);
          });

          checkCartData();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onProduct(int id) {
    Get.delete<ProductDetailController>(force: true);
    Get.toNamed(
      AppRouter.getProductDetailRoute(),
      arguments: [id],
    );
  }

  void addToCart(int index) {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      _productList[index].quantity = 1;
      Get.find<ProductCartController>().addItem(_productList[index]);
      checkCartData();
      update();
    } else {
      int freelancerId = Get.find<ProductCartController>()
          .getFreelancerId(_productList[index]);

      if (freelancerId == _productList[index].freelacerId) {
        _productList[index].quantity = 1;
        Get.find<ProductCartController>().addItem(_productList[index]);
        checkCartData();
        update();
      } else {
        showToast('We already have product with other freelancer'.tr);
        update();
      }
    }
  }

  void updateProductQuantity(int index) {
    _productList[index].quantity = _productList[index].quantity + 1;
    Get.find<ProductCartController>().addQuantity(_productList[index]);
    checkCartData();
    update();
  }

  void updateProductQuantityRemove(int index) {
    if (_productList[index].quantity == 1) {
      _productList[index].quantity = 0;
      Get.find<ProductCartController>().removeItem(_productList[index]);
      // Get.find<TabsController>().updateCartValue();
    } else {
      _productList[index].quantity = _productList[index].quantity - 1;
      Get.find<ProductCartController>().addQuantity(_productList[index]);
    }
    checkCartData();
    update();
  }

  void checkCartData() {
    for (var element in _productList) {
      if (Get.find<ProductCartController>()
              .checkProductInCart(element.id as int) ==
          true) {
        element.quantity =
            Get.find<ProductCartController>().getQuantity(element.id as int);
      } else {
        element.quantity = 0;
      }
    }
    update();
  }
}
