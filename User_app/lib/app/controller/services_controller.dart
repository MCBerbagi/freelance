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
import 'package:handyman/app/backend/model/freelancer_model.dart';
import 'package:handyman/app/backend/parse/services_parse.dart';
import 'package:handyman/app/controller/handyman_profile_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';

class ServicesController extends GetxController implements GetxService {
  final ServicesParser parser;
  String title = '';
  String dropdownValuePrice = 'most rated'.tr;

  List<FreelancerModel> _freelancerList = <FreelancerModel>[];
  List<FreelancerModel> get freelancerList => _freelancerList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int cateID = 0;

  bool apiCalled = false;
  var top = 0.0;
  String selectedFilter = '';
  ServicesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    cateID = Get.arguments[0];
    title = Get.arguments[1];
    getFreelancerFromCategory();
  }

  Future<void> getFreelancerFromCategory() async {
    var response = await parser.getFreelancerFromCategory(
      {
        "lat": parser.getLat(),
        "lng": parser.getLng(),
        "id": cateID,
      },
    );
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _freelancerList = [];
      body.forEach((element) {
        FreelancerModel datas = FreelancerModel.fromJson(element);
        _freelancerList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(
      AppRouter.getHandymanProfileRoute(),
      arguments: [id, name],
    );
  }

  void filterProducts(context, String kind) {
    if (kind == 'rating') {
      selectedFilter = 'Popularity'.tr;
      _freelancerList.sort((a, b) => b.rating!.compareTo(a.rating!));
    } else if (kind == 'l-h') {
      selectedFilter = 'Price L-H'.tr;
      _freelancerList.sort((a, b) => a.hourlyPrice!.compareTo(b.hourlyPrice!));
    } else if (kind == 'h-l') {
      selectedFilter = 'Price H-L'.tr;
      _freelancerList.sort((a, b) => b.hourlyPrice!.compareTo(a.hourlyPrice!));
    } else if (kind == 'a-z') {
      selectedFilter = 'A-Z'.tr;
      _freelancerList
          .sort((a, b) => a.name.toString().compareTo(b.name.toString()));
    } else if (kind == 'z-a') {
      selectedFilter = 'Z-A'.tr;
      _freelancerList
          .sort((a, b) => b.name.toString().compareTo(a.name.toString()));
    } else if (kind == 'experience') {
      selectedFilter = 'Experience'.tr;
      _freelancerList
          .sort((a, b) => b.totalExperience!.compareTo(a.totalExperience!));
    }
    Navigator.of(context).pop(true);
    update();
  }
}
