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
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/served_category_moedel.dart';
import 'package:handyman_freelancer/app/backend/parse/register_category_parse.dart';
import 'package:handyman_freelancer/app/controller/register_controller.dart';

class RegisterCategoryController extends GetxController implements GetxService {
  final RegisterCategoryParse parser;

  String selectedServedCate = '';
  String selectedServedCateName = '';
  List<ServedCategoryModel> _servedCategoriesList = <ServedCategoryModel>[];
  List<ServedCategoryModel> get servedCategoriesList => _servedCategoriesList;

  List<int> servedCategories = [];

  bool apiCalled = false;

  RegisterCategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] != null) {
      debugPrint(Get.arguments[0].toString());
      List<ServedCategoryModel> savedData = <ServedCategoryModel>[];
      savedData = Get.arguments[0];
      for (var element in savedData) {
        if (element.isChecked == true) {
          servedCategories.add(int.parse(element.id.toString()));
        }
      }

      getAllServedCategory();
      update();
      debugPrint(servedCategories.toString());
    }
  }

  Future<void> getAllServedCategory() async {
    var response = await parser.getAllServedCategory();
    apiCalled = true;
    if (response.statusCode == 200) {
      // success
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _servedCategoriesList = [];
      body.forEach((element) {
        ServedCategoryModel datas = ServedCategoryModel.fromJson(element);
        var index = servedCategories.indexOf(datas.id as int);
        debugPrint(index.toString());
        if (index >= 0) {
          datas.isChecked = true;
        } else {
          datas.isChecked = false;
        }
        _servedCategoriesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(bool status, int id) {
    var itemIndex =
        _servedCategoriesList.indexWhere((element) => element.id == id);
    _servedCategoriesList[itemIndex].isChecked = status;
    if (status == false) {
      servedCategories.remove(id);
    } else {
      servedCategories.add(id);
    }
    update();
  }

  void saveAndClose() {
    Get.find<RegisterController>().saveCategory(_servedCategoriesList);
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
