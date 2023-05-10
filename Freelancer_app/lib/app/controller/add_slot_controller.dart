/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/slot_model.dart';
import 'package:handyman_freelancer/app/backend/model/slot_time_model.dart';
import 'package:handyman_freelancer/app/controller/slot_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/util/toast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:handyman_freelancer/app/backend/parse/add_slot_parse.dart';

class AddSlotController extends GetxController implements GetxService {
  final AddSlotParser parser;

  String dayName = 'Sunday'.tr;

  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];
  String openTime = '';
  String closeTime = '';

  List<SlotTimeModel> _slotTimeList = <SlotTimeModel>[];
  List<SlotTimeModel> get slotTimeList => _slotTimeList;

  SlotModel _slotData = SlotModel();
  SlotModel get slotData => _slotData;

  String action = '';

  int slotId = 0;
  bool apiCalled = false;

  AddSlotController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    action = Get.arguments[0];
    if (action == 'edit') {
      slotId = Get.arguments[1];
      debugPrint('slot id======= $slotId');
      getSlotById();
    } else {
      apiCalled = true;
    }
    _slotTimeList = [];
  }

  Future<void> getSlotById() async {
    Response response = await parser.getSlotById({"id": slotId});
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var data = myMap['data'];
      _slotTimeList = [];
      SlotModel slotData = SlotModel.fromJson(data);
      _slotData = slotData;
      dayName = dayList[_slotData.weekId as int];
      _slotTimeList = _slotData.slots as List<SlotTimeModel>;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> openTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    openTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute
    }).format("hh:mm a").toString();
    update();
  }

  Future<void> closeTimePicker() async {
    var context = Get.context as BuildContext;
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    closeTime = Jiffy({
      "year": 2020,
      "month": 10,
      "day": 19,
      "hour": pickedTime!.hour,
      "minute": pickedTime.minute
    }).format("hh:mm a").toString();
    update();
  }

  void addSlots() {
    if (openTime == '' || closeTime == '') {
      showToast('Please select time'.tr);
      return;
    }
    var isExist = _slotTimeList.where((element) =>
        element.startTime == openTime && element.endTime == closeTime);
    if (isExist.isNotEmpty) {
      showToast('Already exist'.tr);
      return;
    }
    var body = {
      "start_time": openTime,
      "end_time": closeTime,
    };
    SlotTimeModel datas = SlotTimeModel.fromJson(body);
    _slotTimeList.add(datas);
    update();
  }

  void onUpdateDayName(String name) {
    dayName = name;
    update();
  }

  Future<void> onSubmitSlot() async {
    if (_slotTimeList.isEmpty) {
      showToast('Slots are empty'.tr);
      return;
    }
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
      barrierDismissible: false,
    );

    var body = {
      "uid": parser.getUID(),
      "week_id": dayList.indexOf(dayName),
      "slots": jsonEncode(slotTimeList)
    };
    Response response = await parser.onSubmitSlot(body);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<SlotController>().getMySlots();
      onBack();
    } else if (response.statusCode == 500) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      showToast(myMap['message'.tr]);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdateSlot() async {
    if (_slotTimeList.isEmpty) {
      showToast('Slots are empty'.tr);
      return;
    }
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
      barrierDismissible: false,
    );

    var body = {
      "id": slotId,
      "week_id": dayList.indexOf(dayName),
      "slots": jsonEncode(slotTimeList)
    };
    Response response = await parser.onUpdateSlot(body);
    Get.back();
    if (response.statusCode == 200) {
      Get.find<SlotController>().getMySlots();
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onDestroy(int index) {
    debugPrint(index.toString());
    _slotTimeList.removeAt(index);
    update();
  }
}
