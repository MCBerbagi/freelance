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
import 'package:handyman/app/backend/model/freelancer_model.dart';
import 'package:handyman/app/backend/model/review_model.dart';
import 'package:handyman/app/backend/parse/handyman_profile_parse.dart';
import 'package:handyman/app/controller/freelancer_product_controller.dart';
import 'package:handyman/app/controller/subcategory_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';

class HandymanProfileController extends GetxController implements GetxService {
  final HandymanProfileParser parser;
  int selectedTab = 0;

  FreelancerModel _freelancerDetail = FreelancerModel();
  FreelancerModel get freelancerDetail => _freelancerDetail;

  List<ReviewModel> _reviewList = <ReviewModel>[];
  List<ReviewModel> get reviewList => _reviewList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int freelancerId = 0;
  List<String> gallery = [];

  bool apiCalled = false;

  bool isFav = false;

  HandymanProfileController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    freelancerId = Get.arguments[0];
    getFreelancerByID();
  }

  Future<void> getFreelancerByID() async {
    var response = await parser.getFreelancerByID({"id": freelancerId});

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      FreelancerModel data = FreelancerModel.fromJson(body);
      _freelancerDetail = data;
      if (parser.isLoggedIn() == true) {
        var myFavParam = {
          "uid": parser.getUID(),
          "freelancer_uid": freelancerId
        };
        Response favList = await parser.myFavList(myFavParam);
        Map<String, dynamic> favMap = Map<String, dynamic>.from(favList.body);
        debugPrint(favMap.toString());
        if (favMap['data'] != null &&
            favMap['data'] != 'null' &&
            favMap['data']['id'] != null) {
          isFav = true;
          update();
        }
      }

      if (data.gallery.toString() != 'NA') {
        var imgs = jsonDecode(data.gallery.toString());
        imgs.forEach((element) {
          if (element != '') {
            gallery.add(element.toString());
          }
        });
      }
      getAllFreelancerReviews();
      debugPrint('Called');
      apiCalled = true;
      update();
    } else {
      ApiChecker.checkApi(response);
      apiCalled = true;
      update();
    }
    update();
  }

  Future<void> getAllFreelancerReviews() async {
    var response = await parser.getAllFreelancerReviews(
      {"id": freelancerId},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _reviewList = [];
      body.forEach((element) {
        ReviewModel datas = ReviewModel.fromJson(element);
        _reviewList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateSegment(int id) {
    selectedTab = id;
    update();
  }

  void onServices(int id, String name) {
    Get.delete<SubcategoryController>(force: true);
    Get.toNamed(
      AppRouter.getSubcategoryRoute(),
      arguments: [id, name],
    );
  }

  void onProducts(int id, String name) {
    Get.delete<FreelancerProductController>(force: true);
    Get.toNamed(
      AppRouter.getFreelancerProductRoute(),
      arguments: [id, name],
    );
  }

  void addToFav() {
    if (parser.isLoggedIn() == true) {
      debugPrint('favoirite');
      if (isFav == true) {
        debugPrint('remove');
        removeFavList();
      } else {
        debugPrint('add');
        addToFavList();
      }
    } else {
      debugPrint('Go to Login');
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
    }
  }

  Future<void> removeFavList() async {
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
      barrierDismissible: false,
    );
    var addToFavParam = {
      "uid": parser.getUID(),
      "freelancer_uid": freelancerId,
      "status": 1
    };
    Response response = await parser.removeFromFavList(addToFavParam);
    Get.back();
    if (response.statusCode == 200) {
      isFav = false;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> addToFavList() async {
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
      barrierDismissible: false,
    );
    var addToFavParam = {
      "uid": parser.getUID(),
      "freelancer_uid": freelancerId,
      "status": 1
    };
    Response response = await parser.addToFavourite(addToFavParam);
    Get.back();
    if (response.statusCode == 200) {
      isFav = true;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
