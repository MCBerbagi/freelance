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
import 'package:handyman_freelancer/app/backend/model/product_order_model.dart';
import 'package:handyman_freelancer/app/backend/parse/product_order_detail_parse.dart';
import 'package:handyman_freelancer/app/controller/chat_controller.dart';
import 'package:handyman_freelancer/app/controller/product_order_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/constant.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductOrderDetailController extends GetxController
    implements GetxService {
  final ProductOrderDetailParser parser;

  ProductOrderModel _orderDetail = ProductOrderModel();
  ProductOrderModel get orderDetail => _orderDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int orderId = 0;
  List<String> gallery = [];

  bool apiCalled = false;

  List<String> selectStatus = ['Ongoing'.tr, 'Completed'.tr, 'Delayed'.tr];
  String orderStatus = '';
  String savedStatus = 'Ongoing'.tr;

  List<String> addressTitles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  List<String> paymentName = [
    'NA'.tr,
    'COD'.tr,
    'Stripe'.tr,
    'PayPal'.tr,
    'Paytm'.tr,
    'Razorpay'.tr,
    'Instamojo'.tr,
    'Paystack'.tr,
    'Flutterwave'.tr
  ];
  String invoiceURL = '';
  ProductOrderDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    orderId = Get.arguments[0];
    invoiceURL =
        '${parser.apiService.appBaseUrl}${AppConstants.getProductOrderInvoice}$orderId&token=${parser.getToken()}';
    getOrderById();
  }

  Future<void> getOrderById() async {
    var response = await parser.getOrderById({"id": orderId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      _orderDetail = ProductOrderModel();
      var body = myMap['data'];
      ProductOrderModel data = ProductOrderModel.fromJson(body);
      _orderDetail = data;
      if (orderDetail.status == 2) {
        orderStatus = 'Rejected'.tr;
      } else if (orderDetail.status == 4) {
        orderStatus = 'Completed'.tr;
      } else if (orderDetail.status == 5) {
        orderStatus = 'Cancelled by user'.tr;
      } else if (orderDetail.status == 6) {
        orderStatus = 'Refunded'.tr;
      } else if (orderDetail.status == 8) {
        orderStatus = 'Panding Payment'.tr;
      }

      debugPrint(body.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<void> onUpdateOrderStatus(int status) async {
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
    var body = {"id": orderId, "status": status};
    Response response = await parser.onUpdateOrderStatus(body);
    Get.back();
    if (response.statusCode == 200) {
      // back//
      var notificationParam = {
        "id": orderDetail.uid,
        "title": "New Notificaiton",
        "message": "Your Order status is Changed"
      };
      await parser.sendNotification(notificationParam);
      successToast('Status Updated'.tr);
      Get.find<ProductOrderController>().getMyProductOrders();
      onBack(); // list refresh
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onSelectStatus(String choice) {
    savedStatus = choice;
    update();
  }

  void updateStatus() {
    debugPrint(savedStatus);
    int index = 0;
    if (savedStatus == 'Ongoing'.tr) {
      index = 3;
    } else if (savedStatus == 'Completed'.tr) {
      index = 4;
    } else {
      index = 7;
    }
    onUpdateOrderStatus(index);
  }

  void onChat() {
    String uid = orderDetail.userInfo!.id.toString();
    String name =
        '${orderDetail.userInfo!.firstName} ${orderDetail.userInfo!.lastName}';
    Get.delete<ChatController>(force: true);
    Get.toNamed(AppRouter.getChatRoute(), arguments: [uid, name]);
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: orderDetail.userInfo!.mobile,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchInBrowser() async {
    var url = Uri.parse(invoiceURL);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url'.tr;
    }
  }
}
