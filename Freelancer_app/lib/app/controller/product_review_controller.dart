/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/product_review_model.dart';
import 'package:handyman_freelancer/app/backend/parse/product_review_parse.dart';

class ProductReviewController extends GetxController implements GetxService {
  final ProductReviewParser parser;

  List<ProductReviewModel> _reviewList = <ProductReviewModel>[];
  List<ProductReviewModel> get reviewList => _reviewList;
  int freelancerId = 0;
  bool apiCalled = false;

  ProductReviewController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getMyProductReviews();
  }

  Future<void> getMyProductReviews() async {
    var response = await parser.getMyProductReviews(
      {
        "id": parser.getUID(),
      },
    );
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _reviewList = [];
      body.forEach((element) {
        ProductReviewModel datas = ProductReviewModel.fromJson(element);
        _reviewList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }
}
