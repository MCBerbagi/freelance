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
import 'package:handyman/app/backend/model/appoinments_model.dart';
import 'package:handyman/app/backend/parse/history_parse.dart';
import 'package:handyman/app/controller/appointment_detail_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/constant.dart';

class HistoryController extends GetxController implements GetxService {
  final HistoryParser parser;

  bool loadMore = false;
  bool apiCalled = false;
  RxInt lastLimit = 1.obs;

  List<AppointmentsModel> _appointmentList = <AppointmentsModel>[]; //new
  List<AppointmentsModel> get appointmentList => _appointmentList; //new

  List<AppointmentsModel> _appointmentListOngoing =
      <AppointmentsModel>[]; // ongoing
  List<AppointmentsModel> get appointmentListOngoing =>
      _appointmentListOngoing; // ongoing

  List<AppointmentsModel> _appointmentListPast = <AppointmentsModel>[]; // past
  List<AppointmentsModel> get appointmentListPast =>
      _appointmentListPast; // past

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

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  HistoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    getMyAppointments();
  }

  Future<void> getMyAppointments() async {
    if (parser.isLogin() == true) {
      var param = {"id": parser.getUID()};

      Response response = await parser.getMyAppointments(param);
      debugPrint(response.bodyString);
      apiCalled = true;
      loadMore = false;
      update();
      if (response.statusCode == 200) {
        debugPrint(response.bodyString);
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

        var appointment = myMap['data'];
        _appointmentList = [];
        _appointmentListOngoing = [];
        _appointmentListPast = [];
        appointment.forEach(
          (add) {
            AppointmentsModel adds = AppointmentsModel.fromJson(add);
            if (adds.status == 0) {
              _appointmentList.add(adds);
            } else if (adds.status == 1 ||
                adds.status == 3 ||
                adds.status == 7 ||
                adds.status == 8) {
              _appointmentListOngoing.add(adds);
            } else {
              _appointmentListPast.add(adds);
            }
          },
        );
        update();
        debugPrint(appointmentList.length.toString());
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void onAppointmentDetail(int id) {
    Get.delete<AppointmentDetailController>(force: true);
    Get.toNamed(
      AppRouter.getAppointmentDetailRoute(),
      arguments: [id],
    );
  }

  void onLoginRoutes() {
    Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
  }

  Future<void> onRefresh() async {
    debugPrint('Hi There');
    apiCalled = false;
    update();
    getMyAppointments();
  }

  void increment() {
    debugPrint('load more');
    loadMore = true;
    lastLimit = lastLimit++;
    update();
    getMyAppointments();
  }
}
