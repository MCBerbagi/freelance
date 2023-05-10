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
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/appointment_model.dart';
import 'package:handyman_freelancer/app/backend/parse/home_parse.dart';
import 'package:handyman_freelancer/app/controller/service_detail_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/constant.dart';
import 'package:handyman_freelancer/app/util/toast.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;

  bool apiCalled = false;

  List<AppointmentsModel> _appointmentList = <AppointmentsModel>[]; // new
  List<AppointmentsModel> get appointmentList => _appointmentList; // new

  List<AppointmentsModel> _appointmentListOngoing =
      <AppointmentsModel>[]; // ongoing
  List<AppointmentsModel> get appointmentListOngoing =>
      _appointmentListOngoing; // ongoing

  List<AppointmentsModel> _appointmentListPast = <AppointmentsModel>[]; // past
  List<AppointmentsModel> get appointmentListPast =>
      _appointmentListPast; // past

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
    'Panding Payment',
  ];

  bool loadMore = false;
  RxInt lastLimit = 1.obs;

  HomeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    getAppointmentsByFreelancerId();
  }

  Future<void> getAppointmentsByFreelancerId() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getAppointmentsByFreelancerId(param);
    apiCalled = true;
    loadMore = false;
    update();
    if (response.statusCode == 200) {
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

  void onAppoinmentDetail(int id) {
    Get.delete<ServiceDetailController>(force: true);
    Get.toNamed(
      AppRouter.getServiceDetailRoute(),
      arguments: [id],
    );
  }

  void increment() {
    debugPrint('load more');
    loadMore = true;
    lastLimit = lastLimit++;
    update();
    extraToast('Fetching...'.tr);
    getAppointmentsByFreelancerId();
  }

  Future<void> onRefresh() async {
    debugPrint('Hi There');
    apiCalled = false;
    update();
    extraToast('Refreshing...'.tr);
    getAppointmentsByFreelancerId();
  }
}
