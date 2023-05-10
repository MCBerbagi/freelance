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
import 'package:handyman/app/backend/parse/add_product_review_parse.dart';
import 'package:handyman/app/controller/single_product_review_controller.dart';
import 'package:handyman/app/helper/router.dart';

class AddProductReviewController extends GetxController implements GetxService {
  final AddProductReviewParser parser;

  double rate = 3.5;

  int orderId = 0;

  final notesEditor = TextEditingController();

  List<double?> rating = [];

  AddProductReviewController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments[0];
  }

  void saveRating(double ratte) {
    rate = ratte;
    update();
  }

  void onProductReview(int id, String cover, String name) {
    Get.delete<SingleProductReviewController>(force: true);
    Get.toNamed(
      AppRouter.getSingleProductReviewRoute(),
      arguments: [id, cover, name],
    );
  }
}
