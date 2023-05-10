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
import 'package:handyman/app/backend/parse/single_product_review_parse.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';

class SingleProductReviewController extends GetxController
    implements GetxService {
  final SingleProductReviewParser parser;

  double rate = 3.5;

  int productId = 0;
  String cover = '';
  String name = '';
  bool apiCalled = false;

  final notesEditor = TextEditingController();

  List<double?> rating = [];

  SingleProductReviewController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments[0];
    cover = Get.arguments[1];
    name = Get.arguments[2];
    getProductReviews();
  }

  void saveRating(double ratte) {
    rate = ratte;
    update();
  }

  Future<void> getProductReviews() async {
    Response response = await parser.getProductReviews({"id": productId});
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic reviews = myMap["data"];
      rating = [];
      reviews.forEach((element) {
        rating.add(double.parse(element['rating'].toString()));
      });
      debugPrint(rating.length.toString());
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }

  Future<void> saveReview() async {
    if (notesEditor.text == '' || notesEditor.text.isEmpty) {
      showToast('Please add comments'.tr);
      return;
    }
    debugPrint(rate.toString());
    rating.add(double.parse(rate.toString()));
    List<double> ratings = rating.map((e) => e!).cast<double>().toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      debugPrint(rate.toString());

      debugPrint(notesEditor.text);
      var param = {
        "uid": parser.getUID(),
        "product_id": productId,
        "notes": notesEditor.text,
        "rating": rate,
        "status": 1
      };
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
          barrierDismissible: false);
      Response response = await parser.saveReview(param);
      Get.back();
      apiCalled = true;
      update();
      if (response.statusCode == 200) {
        var updateParam = {
          "id": productId,
          'total_rating': rating.length,
          'rating': average.toStringAsFixed(2)
        };
        await parser.updateProductInfo(updateParam);
        successToast('Review Saved'.tr);

        onBack();
      } else {
        ApiChecker.checkApi(response);
        update();
      }
    }
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
