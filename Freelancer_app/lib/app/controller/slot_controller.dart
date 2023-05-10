/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/handler.dart';
import 'package:handyman_freelancer/app/backend/model/slot_model.dart';
import 'package:handyman_freelancer/app/backend/parse/slot_parse.dart';
import 'package:handyman_freelancer/app/controller/add_slot_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/util/toast.dart';

class SlotController extends GetxController implements GetxService {
  final SlotParser parser;

  List<SlotModel> _slotList = <SlotModel>[];
  List<SlotModel> get slotList => _slotList;
  bool apiCalled = false;

  List<String> dayList = [
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr
  ];
  SlotController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getMySlots();
  }

  Future<void> getMySlots() async {
    Response response = await parser.getSlotById();
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var data = myMap['data'];
      _slotList = [];
      data.forEach((element) {
        SlotModel data = SlotModel.fromJson(element);
        _slotList.add(data);
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onDistroy(int index, int subIndex) async {
    debugPrint(index.toString());
    debugPrint(subIndex.toString());
    _slotList[index].slots!.removeAt(subIndex);
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

    var param = {
      "id": _slotList[index].id,
      "week_id": _slotList[index].weekId,
      "slots": jsonEncode(_slotList[index].slots)
    };
    Response response = await parser.onUpdateSlots(param);
    Get.back();
    if (response.statusCode == 200) {
      getMySlots();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onAddNew() {
    Get.delete<AddSlotController>(force: true);
    Get.toNamed(AppRouter.getAddSlotRoute(), arguments: ['new']);
  }

  void onEdit(int id) {
    Get.delete<AddSlotController>(force: true);
    Get.toNamed(AppRouter.getAddSlotRoute(), arguments: ['edit', id]);
  }

  void onSlotDestroy(int id) async {
    var param = {"id": id};
    var response = await parser.destroyTimeSlot(param);
    if (response.statusCode == 200) {
      getMySlots();
      successToast('Slot Remove Successfully'.tr);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
