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
import 'package:handyman/app/backend/model/services_model.dart';
import 'package:handyman/app/backend/parse/subcategory_parse.dart';
import 'package:handyman/app/controller/booking_controller.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/service_detail_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/toast.dart';

class SubcategoryController extends GetxController implements GetxService {
  final SubcategoryParser parser;
  String title = '';
  String tabID = '1';

  List<ServiceModel> _servicesList = <ServiceModel>[];
  List<ServiceModel> get servicesList => _servicesList;

  ServiceModel _servicesDetail = ServiceModel();
  ServiceModel get servicesDetail => _servicesDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int freelancerId = 0;

  bool apiCalled = false;

  SubcategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    freelancerId = Get.arguments[0];
    title = Get.arguments[1];
    getFreelancerServices();
  }

  Future<void> getFreelancerServices() async {
    var response = await parser.getFreelancerServices({
      "id": freelancerId,
    });
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];

      _servicesList = [];
      _servicesDetail = ServiceModel();

      body.forEach(
        (element) {
          ServiceModel datas = ServiceModel.fromJson(element);
          if (Get.find<CartController>().checkProductInCart(datas.id as int)) {
            datas.isChecked = true;
          } else {
            datas.isChecked = false;
          }
          _servicesList.add(datas);
          _servicesDetail = datas;
        },
      );
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onChangeService() {
    for (var element in _servicesList) {
      if (Get.find<CartController>().checkProductInCart(element.id as int)) {
        element.isChecked = true;
      } else {
        element.isChecked = false;
      }
    }
    update();
  }

  void onServicesDetail(int id) {
    Get.delete<ServiceDetailController>(force: true);
    Get.toNamed(
      AppRouter.getServiceDetailRoute(),
      arguments: [id],
    );
  }

  void onServiceChange(bool status, int index) {
    debugPrint(status.toString());
    debugPrint(index.toString());
    if (Get.find<CartController>().savedInCart.isEmpty) {
      _servicesList[index].isChecked = status;
      update();
      if (_servicesList[index].isChecked == true) {
        Get.find<CartController>().addItem(_servicesList[index]);
        update();
      } else if (_servicesList[index].isChecked == false) {
        Get.find<CartController>().removeItem(_servicesList[index]);
        update();
      }
    } else if (Get.find<CartController>().savedInCart.isNotEmpty) {
      int? savedId = Get.find<CartController>().savedInCart[0].uid;
      if (freelancerId == savedId) {
        _servicesList[index].isChecked = status;
        update();
        if (_servicesList[index].isChecked == true) {
          Get.find<CartController>().addItem(_servicesList[index]);
          update();
        } else if (_servicesList[index].isChecked == false) {
          Get.find<CartController>().removeItem(_servicesList[index]);
          update();
        }
      } else {
        clearCartAlert().then((value) {
          if (value == true) {
            Get.find<CartController>().clearCart();
          }
        }).catchError((error) {
          showToast(error);
        });
        update();
      }
    }
  }

  void onBooking() {
    Get.delete<BookingController>(force: true);
    Get.toNamed(
      AppRouter.getBookingRoute(),
    );
  }
}
