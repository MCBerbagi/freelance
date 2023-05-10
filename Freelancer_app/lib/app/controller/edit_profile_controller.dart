/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/profile_model.dart';
import 'package:handyman_freelancer/app/backend/parse/edit_profile_parse.dart';
import 'package:handyman_freelancer/app/controller/account_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/util/toast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;

  XFile? _selectedImage;

  String cover = '';
  List<String> gallery = ['', '', '', '', '', ''];

  String selectedServedCateName = '';
  String selectedServedCateId = '';

  String selectedCityName = '';
  String selectedCityId = '';

  String countryCodeMobile = '';

  final firstNameTextEditor = TextEditingController();
  final lastNameTextEditor = TextEditingController();
  int selectedGender = 1;
  final emailTextEditor = TextEditingController();
  final mobileTextEditor = TextEditingController();

  final hourlyPriceTextEditor = TextEditingController();
  final totalExperienceTextEditor = TextEditingController();

  final zipCodeTextEditor = TextEditingController();
  final latTextEditor = TextEditingController();
  final longTextEditor = TextEditingController();

  final descriptionsTextEditor = TextEditingController();

  ProfileModel _profileInfo = ProfileModel();
  ProfileModel get profileInfo => _profileInfo;

  int haveShopValue = 0;
  bool haveShop = false;

  bool apiCalled = false;

  double rate = 0.0;

  EditProfileController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getUserByID();
  }

  Future<void> getUserByID() async {
    var response = await parser.getUserByID({"id": parser.getUID()});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _profileInfo = ProfileModel();
      var body = myMap['data'];
      ProfileModel data = ProfileModel.fromJson(body);
      _profileInfo = data;
      debugPrint('====>  ${data.servedCategory}');
      selectedServedCateId = _profileInfo.servedCategory.toString();
      // selectedServedCateName = _profileInfo.webCatesData.id.name.toString();
      parser.saveFreelancerId(_profileInfo.id.toString());
      firstNameTextEditor.text = _profileInfo.userInfo!.firstName.toString();
      lastNameTextEditor.text = _profileInfo.userInfo!.lastName.toString();
      selectedGender = _profileInfo.userInfo!.gender as int;
      countryCodeMobile = _profileInfo.userInfo!.countryCode!.toString();
      emailTextEditor.text = _profileInfo.userInfo!.email.toString();
      mobileTextEditor.text = _profileInfo.userInfo!.mobile.toString();
      zipCodeTextEditor.text = _profileInfo.zipcode.toString();
      latTextEditor.text = _profileInfo.lat.toString();
      longTextEditor.text = _profileInfo.lng.toString();
      descriptionsTextEditor.text = _profileInfo.descriptions.toString();
      hourlyPriceTextEditor.text = _profileInfo.hourlyPrice.toString();
      totalExperienceTextEditor.text = _profileInfo.totalExperience.toString();
      haveShopValue = _profileInfo.haveShop!;
      haveShop = haveShopValue == 1 ? true : false;
      selectedCityId = _profileInfo.cid.toString();
      selectedCityName = _profileInfo.cityData!.name.toString();

      cover = _profileInfo.cover.toString();
      if (body['rate'] != null) {
        rate = double.parse(body['rate']['rate'].toString());
      }
      debugPrint('***********');
      debugPrint(rate.toString());
      debugPrint('***********');
      if (_profileInfo.gallery != 'NA') {
        var imgs = jsonDecode(_profileInfo.gallery.toString());
        int index = 0;
        imgs.forEach((element) {
          gallery[index] = element;
          index++;
        });
      } else {}

      mobileTextEditor.text = _profileInfo.userInfo!.mobile.toString();
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  void onCategoriesList() {
    debugPrint(profileInfo.servedCategory.toString());
    Get.toNamed(AppRouter.getServedCategoryRoute(),
        arguments: [profileInfo.servedCategory.toString()]);
  }

  void onCityList() {
    debugPrint(profileInfo.cid.toString());
    Get.toNamed(AppRouter.getCityRoute(),
        arguments: [profileInfo.cid.toString()]);
  }

  Future<void> onUpdateInfo() async {
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
                  ),
                ),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    var body = {
      "uid": parser.getUID(),
      "id": profileInfo.id,
      "first_name": firstNameTextEditor.text,
      "last_name": lastNameTextEditor.text,
      "gender": selectedGender,
      "hourly_price": hourlyPriceTextEditor.text,
      "total_experience": totalExperienceTextEditor.text,
      "have_shop": haveShopValue,
      "cid": selectedCityId,
      "zipcode": zipCodeTextEditor.text,
      "lat": latTextEditor.text,
      "lng": longTextEditor.text,
      "gallery": jsonEncode(gallery),
      "cover": cover,
      "descriptions": descriptionsTextEditor.text,
      "rate": rate
    };

    var response = await parser.onUpdateInfo(body);
    debugPrint(response.bodyString);
    Get.back();
    if (response.statusCode == 200) {
      successToast('update'.tr);
      Get.find<AccountController>().changeData();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void toggleShopBtn(bool status) {
    haveShop = status;
    haveShopValue = haveShop == true ? 1 : 0;
    update();
  }

  void updateGender(int status) {
    selectedGender = status;
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
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
                    ),
                  ),
                ],
              )
            ],
          ),
          barrierDismissible: false);
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void selectFromGalleryOthers(String kind, int index) async {
    _selectedImage = await ImagePicker().pickImage(
        source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 25);
    update();
    if (_selectedImage != null) {
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
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            gallery[index] = body['image_name'];
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void onSaveCity(String id, String name) {
    selectedCityName = name;
    selectedCityId = id;
    debugPrint('got from city list');
    update();
  }

  void onSaveServedCategory(String id, String name) {
    selectedCityName = name;
    selectedCityId = id;
    debugPrint('got from served list');
    update();
  }
}
