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
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/parse/freelancer_product_parse.dart';
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/controller/product_detail_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/toast.dart';

class FreelancerProductController extends GetxController
    implements GetxService {
  final FreelancerProductParser parser;
  String title = '';

  List<ProductModel> _productList = <ProductModel>[];
  List<ProductModel> get productList => _productList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int freelancerId = 0;
  bool apiCalled = false;

  FreelancerProductController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    freelancerId = Get.arguments[0];
    title = Get.arguments[1];
    getFreelancerProducts();
  }

  Future<void> getFreelancerProducts() async {
    var response = await parser.getFreelancerProducts({"id": freelancerId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _productList = [];
      body.forEach((element) {
        ProductModel datas = ProductModel.fromJson(element);
        if (Get.find<ProductCartController>()
                .checkProductInCart(datas.id as int) ==
            true) {
          datas.quantity =
              Get.find<ProductCartController>().getQuantity(datas.id as int);
        } else {
          datas.quantity = 0;
        }
        _productList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onProductDetail(int id, String name) {
    Get.delete<ProductDetailController>(force: true);
    Get.toNamed(
      AppRouter.getProductDetailRoute(),
      arguments: [id, name],
    );
  }

  void updateProductQuantityRemove(int index) {
    if (_productList[index].quantity == 1) {
      _productList[index].quantity = 0;
      Get.find<ProductCartController>().removeItem(_productList[index]);
      Get.find<TabsController>().updateCartValue();
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
    Get.find<HomeController>().checkCartData();
    update();
  }

  void addToCart(int index) {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      _productList[index].quantity = 1;
      Get.find<ProductCartController>().addItem(_productList[index]);
      Get.find<TabsController>().updateCartValue();
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
