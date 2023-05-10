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
import 'package:handyman_freelancer/app/backend/model/services_model.dart';
import 'package:handyman_freelancer/app/backend/parse/service_parse.dart';
import 'package:handyman_freelancer/app/util/constant.dart';
import 'package:handyman_freelancer/app/util/theme.dart';

class ServiceController extends GetxController implements GetxService {
  final ServiceParser parser;

  List<ServicesModel> _servicesList = <ServicesModel>[];
  List<ServicesModel> get servicesList => _servicesList;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  bool apiCalled = false;

  ServiceController({required this.parser});

  get arguments => null;
  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    getMyServices();
  }

  Future<void> getMyServices() async {
    _servicesList = [];
    var response = await parser.getMyServices(
        {"id": parser.sharedPreferencesManager.getString('uid')});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      body.forEach((element) {
        ServicesModel datas = ServicesModel.fromJson(element);
        _servicesList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateStatus(int id, int status) {
    debugPrint(id.toString());
    debugPrint(status.toString());
    debugPrint(id.toString());
    var context = Get.context as BuildContext;
    Widget okButton = TextButton(
      child: Text(
        "Yes Update".tr,
        style: const TextStyle(color: ThemeProvider.appColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        updateStatusOfService(id, status);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel".tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?".tr),
      content: Text("Change the status of this service".tr),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> updateStatusOfService(int id, int status) async {
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
    var body = {"id": id, "status": status == 1 ? 0 : 1};
    var response = await parser.updateStatus(body);
    Get.back();
    if (response.statusCode == 200) {
      apiCalled = false;
      update();
      getMyServices();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void deleteItem(int id) {
    debugPrint(id.toString());
    var context = Get.context as BuildContext;
    Widget okButton = TextButton(
      child: Text(
        "Yes Delete".tr,
        style: const TextStyle(color: ThemeProvider.appColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        deleteProduct(id);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel".tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?".tr),
      content: Text("To delete this service".tr),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deleteProduct(int id) async {
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
    var body = {"id": id};
    var response = await parser.deleteService(body);
    Get.back();
    if (response.statusCode == 200) {
      apiCalled = false;
      update();
      getMyServices();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
