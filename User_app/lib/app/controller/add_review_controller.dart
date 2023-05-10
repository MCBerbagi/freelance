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
import 'package:handyman/app/backend/parse/add_review_parse.dart';
import 'package:handyman/app/controller/appointment_detail_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';

class AddReviewController extends GetxController implements GetxService {
  final AddReviewParser parser;
  double rate = 3.5;

  FreelancerModel _freelancerDetail = FreelancerModel();
  FreelancerModel get freelancerDetail => _freelancerDetail;

  int freelancerId = 0;
  bool apiCalled = false;

  final notesEditor = TextEditingController();

  List<double?> rating = [];

  AddReviewController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    freelancerId = Get.arguments[0];
    getFreelancerByID();
  }

  Future<void> getFreelancerByID() async {
    var response = await parser.getFreelancerByID({"id": freelancerId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _freelancerDetail = FreelancerModel();
      var body = myMap['data'];
      FreelancerModel data = FreelancerModel.fromJson(body);
      _freelancerDetail = data;
      getFreelancerReviews();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveRating(double ratte) {
    rate = ratte;
    update();
  }

  Future<void> getFreelancerReviews() async {
    Response response = await parser.getFreelancerReviews({"id": freelancerId});
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

    rating.add(double.parse(rate.toString()));
    List<double> ratings = rating.map((e) => e!).cast<double>().toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      debugPrint(rate.toString());

      debugPrint(notesEditor.text);
      var param = {
        "uid": parser.getUID(),
        "freelancer_id": freelancerDetail.uid,
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
          "id": freelancerDetail.id,
          'total_rating': rating.length,
          'rating': average.toStringAsFixed(2)
        };
        await parser.updateFreelancerInfo(updateParam);
        successToast('Review Saved'.tr);
        // rating = [];
        // reviews.forEach((element) {
        //   rating.add(double.parse(element['rating']));
        // });
        // debugPrint(rating.length.toString());
        Get.find<AppointmentDetailController>().getAppointmentById();
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
