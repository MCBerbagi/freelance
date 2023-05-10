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
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/address_model.dart';
import 'package:handyman/app/backend/parse/address_list_parse.dart';
import 'package:handyman/app/controller/add_address_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/controller/product_checkout_controller.dart';
import 'package:handyman/app/helper/router.dart';

class AddressListController extends GetxController implements GetxService {
  final AddressListParser parser;
  String actionFrom = '';

  String selectedAddressId = '';
  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;
  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  bool apiCalled = false;

  AddressListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    actionFrom = Get.arguments[0];
    selectedAddressId = Get.arguments[1];
    getSavedAddress();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getSavedAddress(param);
    debugPrint(response.bodyString);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      var address = myMap['data'];
      _addressList = [];
      address.forEach((add) {
        AddressModel adds = AddressModel.fromJson(add);
        _addressList.add(adds);
      });
      debugPrint(addressList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveAdd(
    String id,
  ) {
    selectedAddressId = id;

    update();
  }

  void saveAndClose() {
    if (actionFrom == 'service') {
      Get.find<CheckoutController>().onSaveAddress(selectedAddressId);
    } else {
      Get.find<ProductCheckoutController>().onSaveAddress(selectedAddressId);
    }
    onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onNewAddress() {
    Get.delete<AddAddressController>(force: true);
    Get.toNamed(AppRouter.getAddAddressRoute(), arguments: [actionFrom, 'new']);
  }
}
