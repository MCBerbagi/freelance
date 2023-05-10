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
import 'package:handyman/app/backend/model/appoinments_model.dart';
import 'package:handyman/app/backend/parse/appointment_detail_parse.dart';
import 'package:handyman/app/controller/add_review_controller.dart';
import 'package:handyman/app/controller/chat_controller.dart';
import 'package:handyman/app/controller/complaints_controller.dart';
import 'package:handyman/app/controller/history_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetailController extends GetxController
    implements GetxService {
  final AppointmentDetailParser parser;

  AppointmentsModel _appointmentDetail = AppointmentsModel();
  AppointmentsModel get appointmentDetail => _appointmentDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  List<String> addressTitles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  bool type = true;

  int appointmentId = 0;
  List<String> gallery = [];

  String orderStatus = '';
  String invoiceURL = '';

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

  AppointmentDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    appointmentId = Get.arguments[0];
    invoiceURL =
        '${parser.apiService.appBaseUrl}${AppConstants.getAppointmentsInvoice}$appointmentId&token=${parser.getToken()}';
    getAppointmentById();
  }

  Future<void> getAppointmentById() async {
    var response = await parser.getAppointmentById({"id": appointmentId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _appointmentDetail = AppointmentsModel();
      var body = myMap['data'];
      AppointmentsModel data = AppointmentsModel.fromJson(body);
      _appointmentDetail = data;
      if (appointmentDetail.status == 1) {
        orderStatus = 'Accepted'.tr;
      } else if (appointmentDetail.status == 2) {
        orderStatus = 'Rejected by Freelancer'.tr;
      } else if (appointmentDetail.status == 3) {
        orderStatus = 'Ongoing'.tr;
      } else if (appointmentDetail.status == 4) {
        orderStatus = 'Completed'.tr;
      } else if (appointmentDetail.status == 5) {
        orderStatus = 'Cancelled'.tr;
      } else if (appointmentDetail.status == 6) {
        orderStatus = 'Refunded'.tr;
      } else if (appointmentDetail.status == 7) {
        orderStatus = 'Delayed'.tr;
      } else if (appointmentDetail.status == 8) {
        orderStatus = 'Panding Payment'.tr;
      }
      debugPrint(body.toString());
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdateAppointmentStatus(int status) async {
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
    var body = {"id": appointmentId, "status": status};
    Response response = await parser.onUpdateAppointmentStatus(body);
    Get.back();
    if (response.statusCode == 200) {
      // back//
      successToast('Status Updated'.tr);
      Get.find<HistoryController>().getMyAppointments();
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

  void onAddReview(int id) {
    Get.delete<AddReviewController>(force: true);
    Get.toNamed(AppRouter.getAddReviewRoute(), arguments: [id]);
  }

  void onChat() {
    Get.delete<ChatController>(force: true);
    Get.toNamed(AppRouter.getChatRoute(), arguments: [
      appointmentDetail.freelancer!.uid,
      appointmentDetail.freelancer!.name
    ]);
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: appointmentDetail.freelancer!.mobile,
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
                  arguments: [appointmentId, 'appointments']);
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
