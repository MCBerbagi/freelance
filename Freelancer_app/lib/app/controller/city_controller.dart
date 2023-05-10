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
import 'package:handyman_freelancer/app/backend/model/profile_model.dart';
import 'package:handyman_freelancer/app/backend/parse/city_parse.dart';
import 'package:handyman_freelancer/app/controller/edit_profile_controller.dart';

class CityController extends GetxController implements GetxService {
  final CityParser parser;

  String selectedCityId = '';
  String selectedCityName = '';
  List<ProfileModel> _cityList = <ProfileModel>[];
  List<ProfileModel> get cityList => _cityList;

  bool apiCalled = false;

  CityController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getAllCity();
    selectedCityId = Get.arguments[0].toString();
    // debugPrint(.toString());
  }

  Future<void> getAllCity() async {
    var response = await parser.getAllCity();
    apiCalled = true;
    if (response.statusCode == 200) {
      // success
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _cityList = [];
      body.forEach((element) {
        ProfileModel datas = ProfileModel.fromJson(element);
        _cityList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveCate(String id) {
    selectedCityId = id;
    var name =
        _cityList.firstWhere((element) => element.id.toString() == id).name;
    selectedCityName = name as String;
    update();
  }

  void saveAndCloe() {
    Get.find<EditProfileController>()
        .onSaveCity(selectedCityId, selectedCityName);
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }
}
