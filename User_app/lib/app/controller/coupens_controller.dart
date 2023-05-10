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
import 'package:handyman/app/backend/model/offers_model.dart';
import 'package:handyman/app/backend/parse/coupens_parse.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/util/toast.dart';

class CoupensController extends GetxController implements GetxService {
  final CoupensParse parser;

  String actionFrom = '';
  List<OffersModel> _offersList = <OffersModel>[];
  List<OffersModel> get offersList => _offersList;

  bool apiCalled = false;
  String offerId = '';
  String offerName = '';

  CoupensController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    actionFrom = Get.arguments[0];
    offerId = Get.arguments[1];
    offerName = Get.arguments[2];
    getActiveOffers();
  }

  Future<void> getActiveOffers() async {
    Response response = await parser.getActiveOffers();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _offersList = [];
      if (body != null) {
        body.forEach((element) {
          OffersModel data = OffersModel.fromJson(element);
          _offersList.add(data);
        });
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void selectOffer(String id, String name) {
    offerId = id;
    offerName = name;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void addCoupen() {
    if (offerId.isEmpty) {
      showToast('Please select offer'.tr);
      return;
    }
    var selectedCoupon =
        _offersList.firstWhere((element) => element.id.toString() == offerId);
    _offersList.firstWhere((element) => element.name.toString() == offerName);
    if (actionFrom == 'service') {
      Get.find<CheckoutController>().onSaveCoupon(selectedCoupon);
    } else {
      Get.find<ProductCheckoutController>().savedCoupens(selectedCoupon);
    }

    onBack();
  }
}
