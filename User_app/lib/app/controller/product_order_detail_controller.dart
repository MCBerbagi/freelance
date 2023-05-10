/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/product_order_model.dart';
import 'package:handyman/app/backend/parse/product_order_detail_parse.dart';
import 'package:handyman/app/controller/add_product_review_controller.dart';
import 'package:handyman/app/controller/chat_controller.dart';
import 'package:handyman/app/controller/complaints_controller.dart';
import 'package:handyman/app/controller/product_history_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductOrderDetailController extends GetxController
    implements GetxService {
  final ProductOrderDetailParser parser;

  ProductOrderModel _orderDetail = ProductOrderModel();
  ProductOrderModel get orderDetail => _orderDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  List<String> addressTitles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  int orderId = 0;
  List<String> gallery = [];

  String orderStatus = '';

  bool apiCalled = false;

  List<String> paymentName = [
    'NA',
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
        '${parser.apiService.appBaseUrl}${AppConstants.getProductInvoice}$orderId&token=${parser.getToken()}';
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
      if (orderDetail.status == 1) {
        orderStatus = 'Accepted'.tr;
      } else if (orderDetail.status == 2) {
        orderStatus = 'Rejected by Freelancer'.tr;
      } else if (orderDetail.status == 3) {
        orderStatus = 'Ongoing'.tr;
      } else if (orderDetail.status == 4) {
        orderStatus = 'Completed'.tr;
      } else if (orderDetail.status == 5) {
        orderStatus = 'Cancelled'.tr;
      } else if (orderDetail.status == 6) {
        orderStatus = 'Refunded'.tr;
      } else if (orderDetail.status == 7) {
        orderStatus = 'Delayed'.tr;
      } else if (orderDetail.status == 8) {
        orderStatus = 'Panding Payment'.tr;
      }

      // debugPrint(body.toString());
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
                  ),
                ),
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
      successToast('Status Updated'.tr);
      Get.find<ProductHistoryController>().getMyProductOrders();
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

  void onAddProductReview(int id) {
    Get.delete<AddProductReviewController>(force: true);
    Get.toNamed(AppRouter.getAddProductReviewRoute(), arguments: [id]);
  }

  void onChat() {
    Get.delete<ChatController>(force: true);
    Get.toNamed(AppRouter.getChatRoute(), arguments: [
      orderDetail.freelancerInfo!.id,
      '${orderDetail.freelancerInfo!.firstName} ${orderDetail.freelancerInfo!.lastName}'
    ]);
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: orderDetail.freelancerInfo!.mobile,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchInBrowser() async {
    var url = Uri.parse(invoiceURL);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw '${'Could not launch'.tr} $url';
    }
  }

  void openHelpModal() {
    var context = Get.context as BuildContext;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Choose'.tr),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Chat'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ChatController>(force: true);
              Get.toNamed(AppRouter.getChatRoute(), arguments: [
                parser.getAdminId().toString(),
                parser.getAdminName()
              ]);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Complaints'.tr,
              style: const TextStyle(color: ThemeProvider.appColor),
            ),
            onPressed: () {
              Navigator.pop(context);
              Get.delete<ComplaintsController>(force: true);
              Get.toNamed(AppRouter.getComplaintsRoutes(),
                  arguments: [orderId, 'products']);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(fontFamily: 'bold', color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
