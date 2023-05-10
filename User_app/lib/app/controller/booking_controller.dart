/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/booked_slots_model.dart';
import 'package:handyman/app/backend/model/slot_model.dart';
import 'package:handyman/app/backend/parse/booking_parse.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/checkout_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/util/toast.dart';
import 'package:jiffy/jiffy.dart';

class BookingController extends GetxController implements GetxService {
  final BookingParser parser;

  SlotModel _slotList = SlotModel();
  SlotModel get slotList => _slotList;

  bool apiCalled = false;

  String savedDate = '';

  List<String> bookedSlots = [];

  bool haveData = false;

  String selectedSlotIndex = '';
  final DatePickerController controller = DatePickerController();
  List<String> dayList = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  BookingController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    if (Get.find<CartController>().savedInCart.isNotEmpty) {
      var dayName = Jiffy().format("EEEE"); // Tuesday
      debugPrint(dayName);
      int index = dayList.indexOf(dayName);
      var date = Jiffy().format('yyyy-MM-dd');
      savedDate = date;
      update();
      getSlotsForBookings(index, date);
    } else {
      onBack();
    }
  }

  Color getColor(Set<MaterialState> states) {
    return ThemeProvider.appColor;
  }

  bool isBooked(String slot) {
    debugPrint(slot);
    debugPrint(bookedSlots.indexOf(slot).toString());
    return bookedSlots.contains(slot) ? true : false;
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onSelectSlot(String slot) {
    if (!bookedSlots.contains(slot)) {
      selectedSlotIndex = slot;
      update();
    }
  }

  Future<void> getSlotsForBookings(int index, String date) async {
    var response = await parser.getSlotsForBookings(
      {
        "week_id": index,
        "date": date,
        "uid": Get.find<CartController>().savedInCart[0].uid,
      },
    );
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      var booked = myMap['bookedSlots'];
      _slotList = SlotModel();
      if (body != null) {
        haveData = true;
        SlotModel datas = SlotModel.fromJson(body);
        _slotList = datas;
        update();
      }

      if (booked != null) {
        bookedSlots = [];
        booked.forEach((element) {
          BookedSlotModel slot = BookedSlotModel.fromJson(element);
          bookedSlots.add(slot.slot.toString());
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onDateChange(DateTime date) {
    selectedSlotIndex = '';
    haveData = false;
    debugPrint(date.toString());
    var dayName = Jiffy(date).format("EEEE");
    var selectedDate = Jiffy(date).format('yyyy-MM-dd');
    savedDate = selectedDate;
    update();
    debugPrint(dayName);
    int index = dayList.indexOf(dayName);
    debugPrint(index.toString());
    getSlotsForBookings(index, selectedDate);
  }

  void onCheckout() {
    if (parser.isLogin() == true) {
      if (selectedSlotIndex == '' || selectedSlotIndex.isEmpty) {
        showToast('Please select Slot'.tr);
        return;
      }
      Get.delete<CheckoutController>(force: true);
      Get.toNamed(AppRouter.getCheckoutRoute());
    } else {
      debugPrint('go to login');
      Get.delete<CheckoutController>(force: true);
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['booking']);
    }
  }
}
