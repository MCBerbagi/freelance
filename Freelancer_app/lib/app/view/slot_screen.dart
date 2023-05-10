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
import 'package:handyman_freelancer/app/controller/slot_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class SlotScreen extends StatefulWidget {
  const SlotScreen({Key? key}) : super(key: key);

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SlotController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'My Slots'.tr,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.only(left: 6),
                ),
                onPressed: () {
                  value.onAddNew();
                },
                child: Text(
                  'Add+'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'medium',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: value.slotList.isEmpty
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  "assets/images/no-data.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'No Data Found'.tr,
                                style: const TextStyle(
                                  color: ThemeProvider.appColor,
                                ),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                            value.slotList.length,
                            (index) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: myBoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.dayList[value.slotList[index]
                                                  .weekId as int]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 17, fontFamily: 'bold'),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  value.onEdit(value
                                                      .slotList[index]
                                                      .id as int);
                                                },
                                                child: const Icon(
                                                  Icons.edit_note,
                                                  color: ThemeProvider.appColor,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              const Icon(
                                                                  Icons.delete,
                                                                  size: 40,
                                                                  color: ThemeProvider
                                                                      .secondaryAppColor),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                'Are you sure'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        24,
                                                                    fontFamily:
                                                                        'semi-bold'),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  'to delete Slots ?'
                                                                      .tr),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ThemeProvider.backgroundColor,
                                                                        backgroundColor:
                                                                            ThemeProvider.secondaryAppColor,
                                                                        minimumSize:
                                                                            const Size.fromHeight(35),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Cancel'
                                                                            .tr,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ThemeProvider.whiteColor,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        value.onSlotDestroy(value
                                                                            .slotList[index]
                                                                            .id as int);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ThemeProvider.backgroundColor,
                                                                        backgroundColor:
                                                                            ThemeProvider.appColor,
                                                                        minimumSize:
                                                                            const Size.fromHeight(35),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Delete'
                                                                            .tr,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ThemeProvider.whiteColor,
                                                                          fontSize:
                                                                              16,
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
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: ThemeProvider
                                                      .secondaryAppColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Wrap(
                                      children: List.generate(
                                        value.slotList[index].slots!.length,
                                        (subIndex) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Chip(
                                                backgroundColor: ThemeProvider
                                                    .backgroundColor,
                                                label: Text(
                                                  '${value.slotList[index].slots![subIndex].startTime} to ${value.slotList[index].slots![subIndex].endTime}',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Positioned(
                                                right: -6,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 40,
                                                                    color: ThemeProvider
                                                                        .secondaryAppColor),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  'Are you sure'
                                                                      .tr,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'semi-bold'),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'to delete Slots ?'
                                                                        .tr),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.secondaryAppColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Cancel'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          value.onDistroy(
                                                                              index,
                                                                              subIndex);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.appColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Delete'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
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
                                                    height: 16,
                                                    width: 16,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          ThemeProvider
                                                              .secondaryAppColor,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: ThemeProvider
                                                            .whiteColor,
                                                        size: 12,
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
                        ),
                ),
        );
      },
    );
  }
}
