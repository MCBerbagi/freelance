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
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/model/product_review_model.dart';
import 'package:handyman/app/backend/parse/product_detail_parse.dart';
import 'package:handyman/app/controller/freelancer_product_controller.dart';
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/toast.dart';

class ProductDetailController extends GetxController implements GetxService {
  final ProductDetailParser parser;

  int selectedTab = 0;

  ProductModel _productDetail = ProductModel();
  ProductModel get productDetail => _productDetail;

  SoldBy _soldByDetail = SoldBy();
  SoldBy get soldByDetail => _soldByDetail;

  List<ProductModel> _relatedProductsList = <ProductModel>[];
  List<ProductModel> get relatedProductsList => _relatedProductsList;

  List<ProductReivewModel> _reviewList = <ProductReivewModel>[];
  List<ProductReivewModel> get reviewList => _reviewList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int productId = 0;
  List<String> images = [];

  bool apiCalled = false;
  ProductDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    productId = Get.arguments[0];
    getProductInfo();
  }

  Future<void> getProductInfo() async {
    var response = await parser.getProductInfo({"id": productId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      _productDetail = ProductModel();

      var body = myMap['data'];
      var soldBy = myMap['soldby'];
      var relatedProduct = myMap['related'];

      ProductModel data = ProductModel.fromJson(body);
      SoldBy seller = SoldBy.fromJson(soldBy);

      _productDetail = data;
      _soldByDetail = seller;
      _relatedProductsList = [];
      checkCartData();

      relatedProduct.forEach((element) {
        ProductModel datas = ProductModel.fromJson(element);
        _relatedProductsList.add(datas);
      });

      if (images.isNotEmpty) {
        var imgs = jsonDecode(images.toString());
        imgs.forEach((element) {
          if (element != '') {
            images.add(element.toString());
          }
        });
      }
      getAllProductReviews();
      debugPrint(body.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void checkCartData() {
    if (Get.find<ProductCartController>()
            .checkProductInCart(productDetail.id as int) ==
        true) {
      productDetail.quantity = Get.find<ProductCartController>()
          .getQuantity(productDetail.id as int);
    } else {
      productDetail.quantity = 0;
    }
    update();
  }

  void addToCart() {
    if (Get.find<ProductCartController>().savedInCart.isEmpty) {
      _productDetail.quantity = 1;
      Get.find<ProductCartController>().addItem(_productDetail);
      checkCartData();
      Get.find<HomeController>().checkCartData();
      update();
    } else {
      int freelancerId =
          Get.find<ProductCartController>().getFreelancerId(_productDetail);

      if (freelancerId == _productDetail.freelacerId) {
        _productDetail.quantity = 1;
        Get.find<ProductCartController>().addItem(_productDetail);
        checkCartData();
        Get.find<HomeController>().checkCartData();
        update();
      } else {
        showToast('We already have product with other freelancer'.tr);
        update();
      }
    }
  }

  void updateProductQuantity() {
    _productDetail.quantity = _productDetail.quantity + 1;
    Get.find<ProductCartController>().addQuantity(_productDetail);
    checkCartData();
    Get.find<HomeController>().checkCartData();
    update();
  }

  void updateProductQuantityRemove() {
    if (_productDetail.quantity == 1) {
      _productDetail.quantity = 0;
      Get.find<ProductCartController>().removeItem(_productDetail);
      Get.find<TabsController>().updateCartValue();
    } else {
      _productDetail.quantity = _productDetail.quantity - 1;
      Get.find<ProductCartController>().addQuantity(_productDetail);
    }
    Get.find<HomeController>().checkCartData();
    checkCartData();
    update();
  }

  void updateSegment(int id) {
    selectedTab = id;
    update();
  }

  void onRelatedProduct(int id) {
    debugPrint(id.toString());
    Get.delete<ProductDetailController>(force: true);
    Get.toNamed(AppRouter.getProductDetailRoute(),
        arguments: [id], preventDuplicates: false);
  }

  void onFreelancerProducts(int id, String name) {
    Get.delete<FreelancerProductController>(force: true);
    Get.toNamed(
      AppRouter.getFreelancerProductRoute(),
      arguments: [id, name],
    );
  }

  Future<void> getAllProductReviews() async {
    var response = await parser.getAllProductReviews(
      {"id": productId},
    );
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _reviewList = [];
      body.forEach((element) {
        ProductReivewModel datas = ProductReivewModel.fromJson(element);
        _reviewList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
