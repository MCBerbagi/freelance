/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/address_model.dart';
import 'package:handyman/app/backend/parse/add_address_parse.dart';
import 'package:handyman/app/controller/address_controller.dart';
import 'package:handyman/app/controller/address_list_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController implements GetxService {
  final AddAddressParse parser;
  int title = 0;

  final addressTextEditor = TextEditingController();
  final houseTextEditor = TextEditingController();
  final landmarkTextEditor = TextEditingController();
  final zipcodeTextEditor = TextEditingController();
  int addressId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String action = '';
  List<int> updateAddId = [];
  String fromAction = '';
  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;
  bool apiCalled = false;
  AddAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    fromAction = Get.arguments[0];
    action = Get.arguments[1];
    if (Get.arguments[1] == 'update') {
      addressId = Get.arguments[2];
      getAddressById();
    } else {
      apiCalled = true;
    }
  }

  void onFilter(int choice) {
    title = choice;
    update();
  }

  void getLatLngFromAddress() async {
    if (addressTextEditor.text == '' ||
        addressTextEditor.text.isEmpty ||
        houseTextEditor.text == '' ||
        houseTextEditor.text.isEmpty ||
        landmarkTextEditor.text == '' ||
        landmarkTextEditor.text.isEmpty ||
        zipcodeTextEditor.text == '' ||
        zipcodeTextEditor.text.isEmpty) {
      showToast('All fields are required'.tr);
      return;
    }
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
      barrierDismissible: false,
    );
    var address =
        '${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text} ${zipcodeTextEditor.text}';
    debugPrint(address);
    List<Location> locations = await locationFromAddress(address);
    Get.back();
    if (locations.isNotEmpty) {
      debugPrint(locations[0].toString());
      lat = locations[0].latitude;
      lng = locations[0].longitude;
      update();
      if (action == 'new') {
        saveAddress();
      } else {
        updateAddress();
      }
    } else {
      Get.back();
      showToast("Could not determine your location".tr);
      update();
    }
  }

  Future<void> saveAddress() async {
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
      barrierDismissible: false,
    );

    var body = {
      "uid": parser.getUID(),
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": zipcodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "status": 1
    };
    var response = await parser.saveAddress(body);
    Get.back();

    debugPrint(response.bodyString);

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Added'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    if (fromAction == 'list') {
      Get.find<AddressController>().getSavedAddress();
    } else if (fromAction == 'service') {
      Get.find<AddressListController>().getSavedAddress();
      Get.find<CheckoutController>().getSavedAddress();
    } else {
      Get.find<AddressListController>().getSavedAddress();
      Get.find<ProductCheckoutController>().getSavedAddress();
    }
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getAddressById() async {
    var param = {"id": addressId};

    Response response = await parser.getAddressById(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      _addressInfo = AddressModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      AddressModel datas = AddressModel.fromJson(body);
      _addressInfo = datas;
      addressTextEditor.text = _addressInfo.address.toString();
      houseTextEditor.text = _addressInfo.house.toString();
      landmarkTextEditor.text = _addressInfo.landmark.toString();
      zipcodeTextEditor.text = _addressInfo.pincode.toString();
      title = _addressInfo.title as int;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateAddress() async {
    var body = {
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": zipcodeTextEditor.text,
      "lat": lat,
      "lng": lng,
      "id": addressId
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
      barrierDismissible: false,
    );

    var response = await parser.updateAddress(body);
    Get.back();

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Updated'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
