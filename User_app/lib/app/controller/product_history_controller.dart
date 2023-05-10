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
import 'package:handyman/app/backend/model/product_order_model.dart';
import 'package:handyman/app/backend/parse/product_history_parse.dart';
import 'package:handyman/app/controller/product_order_detail_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';

class ProductHistoryController extends GetxController implements GetxService {
  final ProductHistoryParser parser;

  bool loadMore = false;
  bool apiCalled = false;
  RxInt lastLimit = 1.obs;
  bool login = true;

  List<ProductOrderModel> _orderList = <ProductOrderModel>[]; //new
  List<ProductOrderModel> get orderList => _orderList; //new

  List<ProductOrderModel> _orderListOngoing = <ProductOrderModel>[]; //ongoing
  List<ProductOrderModel> get orderListOngoing => _orderListOngoing; //ongoing

  List<ProductOrderModel> _orderListPast = <ProductOrderModel>[]; //past
  List<ProductOrderModel> get orderListPast => _orderListPast; //past

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  List<String> statusName = [
    'Created',
    'Accepted',
    'Rejected',
    'Ongoing',
    'Completed',
    'Cancelled',
    'Refunded',
    'Delayed',
    'Panding Payment'
  ];

  ProductHistoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    login = parser.isLogin();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    getMyProductOrders();
    if (apiCalled == true) {}
  }

  Future<void> getMyProductOrders() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getMyProductOrders(param);
    debugPrint(response.bodyString);
    apiCalled = true;
    loadMore = false;
    update();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      var productorder = myMap['data'];
      _orderList = [];
      _orderListOngoing = [];
      _orderListPast = [];

      productorder.forEach(
        (add) {
          ProductOrderModel adds = ProductOrderModel.fromJson(add);
          if (adds.status == 0) {
            _orderList.add(adds);
          } else if (adds.status == 1 ||
              adds.status == 3 ||
              adds.status == 7 ||
              adds.status == 8) {
            _orderListOngoing.add(adds);
          } else {
            _orderListPast.add(adds);
          }
        },
      );
      update();
      debugPrint(orderList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onOrderDetail(int id) {
    Get.delete<ProductOrderDetailController>(force: true);
    Get.toNamed(
      AppRouter.getProductOrderDetailRoute(),
      arguments: [id],
    );
  }

  Future<void> onRefresh() async {
    debugPrint('Hi There');
    apiCalled = false;
    update();
    getMyProductOrders();
  }

  void increment() {
    debugPrint('load more');
    loadMore = true;
    lastLimit = lastLimit++;
    update();
    getMyProductOrders();
  }
}
