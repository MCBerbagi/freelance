/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/banner_model.dart';
import 'package:handyman/app/backend/model/category_model.dart';
import 'package:handyman/app/backend/model/freelancer_model.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:handyman/app/backend/parse/home_parse.dart';
import 'package:handyman/app/controller/handyman_profile_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_detail_controller.dart';
import 'package:handyman/app/controller/product_listing_controller.dart';
import 'package:handyman/app/controller/search_controller.dart';
import 'package:handyman/app/controller/services_controller.dart';
import 'package:handyman/app/controller/top_freelancers_controller.dart';
import 'package:handyman/app/controller/top_products_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;

  bool apiCalled = false;

  List<CategoryModel> _categoryList = <CategoryModel>[];
  List<CategoryModel> get categoryList => _categoryList;

  List<FreelancerModel> _freelancerList = <FreelancerModel>[];
  List<FreelancerModel> get freelancerList => _freelancerList;

  List<BannersModel> _bannersList = <BannersModel>[];
  List<BannersModel> get bannersList => _bannersList;

  List<ProductModel> _productList = <ProductModel>[];
  List<ProductModel> get productList => _productList;

  String title = '';

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;
  bool haveData = false;
  HomeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    title = parser.getAddressName();
    getHomeData();
  }

  Future<void> getHomeData() async {
    var response = await parser
        .getHomeData({"lat": parser.getLat(), "lng": parser.getLng()});
    apiCalled = true;
    if (response.statusCode == 200) {
      if (response.body != null) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != null &&
            myMap['categories'] != null &&
            myMap['products'] != null) {
          var categories = myMap['categories'];
          var body = myMap['data'];
          var products = myMap['products'];
          var banners = myMap['banners'];
          haveData = myMap['havedata'];
          _categoryList = [];
          _freelancerList = [];
          _productList = [];
          _bannersList = [];
          categories.forEach((element) {
            CategoryModel datas = CategoryModel.fromJson(element);
            _categoryList.add(datas);
          });
          body.forEach((element) {
            FreelancerModel datas = FreelancerModel.fromJson(element);
            _freelancerList.add(datas);
          });
          products.forEach((element) {
            ProductModel datas = ProductModel.fromJson(element);
            _productList.add(datas);
          });
          banners.forEach((element) {
            BannersModel datas = BannersModel.fromJson(element);
            _bannersList.add(datas);
          });
          debugPrint(_bannersList.length.toString());
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

  void onSearch() {
    Get.delete<SearchController>(force: true);
    Get.toNamed(
      AppRouter.getSearchRoute(),
    );
  }

  void onCategory(int id, String name) {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(
      AppRouter.getServicesRoute(),
      arguments: [id, name],
    );
  }

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(
      AppRouter.getHandymanProfileRoute(),
      arguments: [id, name],
    );
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

  void onBannerClick(int type, String value) {
    debugPrint(type.toString());
    debugPrint(value.toString());
    if (type == 1) {
      debugPrint('category');
      Get.delete<ServicesController>(force: true);
      Get.toNamed(
        AppRouter.getServicesRoute(),
        arguments: [int.parse(value.toString()), 'Offers'],
      );
    } else if (type == 2) {
      debugPrint('single freelancer');
      Get.delete<HandymanProfileController>(force: true);
      Get.toNamed(
        AppRouter.getHandymanProfileRoute(),
        arguments: [int.parse(value.toString()), 'Top Freelancer'],
      );
    } else if (type == 3) {
      debugPrint('multiple freelancer');
      Get.delete<TopFreelancersController>(force: true);
      Get.toNamed(AppRouter.getTopFreelancerRoutes(), arguments: [value]);
    } else if (type == 4) {
      debugPrint('product category');
      Get.delete<ProductListingController>(force: true);
      Get.toNamed(
        AppRouter.getProductListingRoute(),
        arguments: [type, 'Offers'],
      );
    } else if (type == 5) {
      debugPrint('single product');
      Get.delete<ProductDetailController>(force: true);
      Get.toNamed(
        AppRouter.getProductDetailRoute(),
        arguments: [int.parse(value.toString()), 'Offers'],
      );
    } else if (type == 6) {
      debugPrint('multiple products');
      Get.delete<TopProductsController>(force: true);
      Get.toNamed(AppRouter.getTopProductsRoutes(), arguments: [value]);
    } else {
      debugPrint('external url');
      launchInBrowser(value);
    }
  }

  Future<void> launchInBrowser(var link) async {
    var url = Uri.parse(link);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw '${'Could not launch'.tr} $url';
    }
  }
}
