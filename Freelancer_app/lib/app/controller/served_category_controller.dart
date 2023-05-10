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
import 'package:handyman_freelancer/app/backend/model/served_category_moedel.dart';
import 'package:handyman_freelancer/app/backend/parse/served_category_parse.dart';
import 'package:handyman_freelancer/app/controller/edit_profile_controller.dart';
import 'package:handyman_freelancer/app/util/toast.dart';

class ServedCategoryController extends GetxController implements GetxService {
  final ServedCategoryParser parser;

  String selectedServedCate = '';
  String selectedServedCateName = '';
  List<ServedCategoryModel> _servedCategoriesList = <ServedCategoryModel>[];
  List<ServedCategoryModel> get servedCategoriesList => _servedCategoriesList;

  List<int> servedCategories = [];

  bool apiCalled = false;

  ServedCategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments[0] != null) {
      debugPrint(Get.arguments[0]);
      var ids = Get.arguments[0].toString().split(',');

      servedCategories = [];
      for (var element in ids) {
        servedCategories.add(int.parse(element));
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

  void onExtra(bool status, int id) {
    debugPrint('$status - -  $id');
    debugPrint(servedCategories.toString());
    var index = servedCategories
        .indexWhere((element) => element.toString() == id.toString());
    var itemIndex = _servedCategoriesList
        .indexWhere((element) => element.id.toString() == id.toString());
    debugPrint(itemIndex.toString());
    if (index >= 0) {
      debugPrint('already have it');
      servedCategories.remove(id);
      _servedCategoriesList[itemIndex].isChecked = false;
      update();
    } else {
      debugPrint('no not there add it');
      servedCategories.add(id);
      _servedCategoriesList[itemIndex].isChecked = true;
      update();
    }
    update();
  }

  void saveCate(String id) {
    selectedServedCate = id;
    var name = _servedCategoriesList
        .firstWhere((element) => element.id.toString() == id)
        .name;
    selectedServedCateName = name as String;
    update();
  }

  void updateStatus(bool status, int id) {
    debugPrint(status.toString());
    debugPrint(id.toString());
    var itemIndex =
        _servedCategoriesList.indexWhere((element) => element.id == id);
    _servedCategoriesList[itemIndex].isChecked = status;
    if (status == false) {
      // remove
      servedCategories.remove(id);
    } else {
      servedCategories.add(id);
      // add
    }
    debugPrint(servedCategoriesList.toString());
    update();
  }

  Future<void> saveAndClose() async {
    var body = {
      "id": parser.getFreelancerId(),
      "served_category": servedCategories.join(',')
    };
    var response = await parser.onUpdateCate(body);
    if (response.statusCode == 200) {
      successToast('Served Categories Update');
      Get.find<EditProfileController>().getUserByID();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    debugPrint('done');
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
