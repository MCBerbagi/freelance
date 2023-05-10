/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/backend/parse/choose_location_parse.dart';
import 'package:handyman/app/controller/account_controller.dart';
import 'package:handyman/app/controller/history_controller.dart';
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/controller/inbox_controller.dart';
import 'package:handyman/app/controller/product_history_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ChooseLocationController extends GetxController implements GetxService {
  final ChooseLocationParser parser;

  ChooseLocationController({required this.parser});

  void getLocation() async {
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
                  "Featching Location".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    _determinePosition().then((value) async {
      Get.back();
      debugPrint(value.toString());
      ///// test /////
      // parser.saveLatLng(21.7645, 72.1519, 'Dummy Address');
      ///// test /////

      /// live ///
      List<Placemark> newPlace =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      Placemark placeMark = newPlace[0];
      String name = placeMark.name.toString();
      String subLocality = placeMark.subLocality.toString();
      String locality = placeMark.locality.toString();
      String administrativeArea = placeMark.administrativeArea.toString();
      String postalCode = placeMark.postalCode.toString();
      String country = placeMark.country.toString();
      String address =
          "$name,$subLocality,$locality,$administrativeArea,$postalCode,$country";
      debugPrint(address);
      parser.saveLatLng(value.latitude, value.longitude, address);

      /// live ///
      Get.delete<HomeController>(force: true);
      Get.delete<AccountController>(force: true);
      Get.delete<HistoryController>(force: true);
      Get.delete<InboxController>(force: true);
      Get.delete<ProductHistoryController>(force: true);
      Get.offAndToNamed(AppRouter.getTabsRoute());
    }).catchError((error) async {
      Get.back();
      showToast(error.toString());
      await Geolocator.openLocationSettings();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.'.tr);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied'.tr);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.'
              .tr);
    }
    return await Geolocator.getCurrentPosition();
  }

  void onCategory() {
    Get.toNamed(
      AppRouter.getCheckoutRoute(),
    );
  }
}
