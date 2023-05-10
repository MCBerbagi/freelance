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
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/categories_model.dart';
import 'package:handyman_freelancer/app/backend/parse/service_category_parse.dart';
import 'package:handyman_freelancer/app/controller/add_service_controller.dart';

class ServiceCategoryController extends GetxController implements GetxService {
  final ServiceCategoryParser parser;

  String selectedCategory = '';
  String selectedCategoryName = '';
  List<CategoryModel> _categoriesList = <CategoryModel>[];
  List<CategoryModel> get categoriesList => _categoriesList;

  bool apiCalled = false;

  ServiceCategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    debugPrint(Get.arguments[0]);
    selectedCategory = Get.arguments[0];
    getCategories();
  }

  Future<void> getCategories() async {
    var response = await parser.getCategories();
    apiCalled = true;
    if (response.statusCode == 200) {
      // success
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data']['web_cates_data'];
      _categoriesList = [];
      body.forEach((element) {
        CategoryModel datas = CategoryModel.fromJson(element);
        _categoriesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCate(String id) {
    selectedCategory = id;
    var name = _categoriesList
        .firstWhere((element) => element.id.toString() == id)
        .name;
    selectedCategoryName = name as String;
    update();
  }

  void saveAndCloe() {
    Get.find<AddServiceController>()
        .onSaveCategory(selectedCategory, selectedCategoryName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
