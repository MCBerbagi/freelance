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
import 'package:handyman_freelancer/app/controller/add_slot_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/widget/elevated_button.dart';

class AddSlotScreen extends StatefulWidget {
  const AddSlotScreen({Key? key}) : super(key: key);

  @override
  State<AddSlotScreen> createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSlotController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            value.action == 'new'.tr ? 'Add New Slot'.tr : 'Update Slot'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: myBoxDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: textFieldDecoration(),
                        child: DropdownButton<String>(
                          value: value.dayName,
                          isExpanded: true,
                          icon: const Icon(Icons.expand_more),
                          elevation: 16,
                          style: const TextStyle(color: ThemeProvider.appColor),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            debugPrint(newValue);
                            value.onUpdateDayName(newValue.toString());
                          },
                          items: <String>[
                            'Sunday'.tr,
                            'Monday'.tr,
                            'Tuesday'.tr,
                            'Wednesday'.tr,
                            'Thursday'.tr,
                            'Friday'.tr,
                            'Saturday'.tr
                          ].map<DropdownMenuItem<String>>((String selected) {
                            return DropdownMenuItem<String>(
                              value: selected,
                              child: Text(selected),
                            );
                          }).toList(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          value.openTimePicker();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: textFieldDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              value.openTime == ''
                                  ? Text('Open Time'.tr)
                                  : Text(value.openTime.toString()),
                              const Icon(Icons.expand_more),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          value.closeTimePicker();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: textFieldDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              value.closeTime == ''
                                  ? Text('Close Time'.tr)
                                  : Text(value.closeTime.toString()),
                              const Icon(Icons.expand_more),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Wrap(
                          children: List.generate(
                            value.slotTimeList.length,
                            (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Chip(
                                    backgroundColor:
                                        ThemeProvider.backgroundColor,
                                    label: Text(
                                      '${value.slotTimeList[i].startTime} ${'to'.tr} ${value.slotTimeList[i].endTime}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Positioned(
                                    right: -10,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    const Icon(Icons.delete,
                                                        size: 40,
                                                        color: ThemeProvider
                                                            .secondaryAppColor),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Are you sure'.tr,
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontFamily:
                                                              'semi-bold'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('to delete this slot ?'
                                                        .tr),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .backgroundColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .secondaryAppColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Cancel'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              value
                                                                  .onDestroy(i);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  ThemeProvider
                                                                      .backgroundColor,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .appColor,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(35),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Delete'.tr,
                                                              style:
                                                                  const TextStyle(
                                                                color: ThemeProvider
                                                                    .whiteColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ThemeProvider.secondaryAppColor,
                                          child: Icon(
                                            Icons.close,
                                            color: ThemeProvider.whiteColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: MyElevatedButton(
                  onPressed: () {
                    value.addSlots();
                  },
                  color: ThemeProvider.appColor,
                  height: 40,
                  width: double.infinity,
                  child: Text('Add Slot'.tr),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyElevatedButton(
                  onPressed: () {
                    if (value.action == 'new') {
                      value.onSubmitSlot();
                    } else {
                      value.onUpdateSlot();
                    }
                  },
                  color: ThemeProvider.appColor,
                  height: 40,
                  width: double.infinity,
                  child: Text('Submit'.tr),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
