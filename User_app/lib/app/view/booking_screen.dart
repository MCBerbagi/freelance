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
import 'package:handyman/app/controller/booking_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:handyman/app/widget/elevated_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Booking'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    decoration: myBoxDecoration(),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 16),
                          child: heading3('Select date of service'.tr),
                        ),
                        const Divider(
                          thickness: 1,
                          color: ThemeProvider.backgroundColor,
                          height: 24,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 8),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              DatePicker(
                                DateTime.now(),
                                width: 55,
                                height: 80,
                                controller: value.controller,
                                dateTextStyle: const TextStyle(
                                    color: Colors.black54, fontSize: 16),
                                initialSelectedDate: DateTime.now(),
                                selectionColor: ThemeProvider.appColor,
                                selectedTextColor: Colors.white,
                                deactivatedColor: ThemeProvider.greyColor,
                                activeDates: List.generate(
                                    7,
                                    (index) => DateTime.now()
                                        .add(Duration(days: index))),
                                onDateChange: (date) {
                                  value.onDateChange(date);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.haveData == false
                      ? Center(
                          child: Text('No Slots Found'.tr),
                        )
                      : Container(
                          clipBehavior: Clip.none,
                          decoration: myBoxDecoration(),
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left: 16),
                                child: heading3('Time to start service'.tr),
                              ),
                              const Divider(
                                thickness: 1,
                                color: ThemeProvider.backgroundColor,
                                height: 24,
                              ),
                              Wrap(
                                children: List.generate(
                                  value.slotList.slots!.length,
                                  (i) => GestureDetector(
                                    onTap: () {
                                      value.onSelectSlot(
                                          '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 4),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        color: value.isBooked(
                                                '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}')
                                            ? Colors.grey
                                            : value.selectedSlotIndex ==
                                                    '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}'
                                                ? ThemeProvider.appColor
                                                : Colors.white,

                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 6,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.16),
                                          )
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: Text(
                                        '${value.slotList.slots![i].startTime} ${'to'.tr} ${value.slotList.slots![i].endTime}',
                                        style: TextStyle(
                                            color: value.isBooked(
                                                        '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}') ||
                                                    value.selectedSlotIndex ==
                                                        '${value.slotList.slots![i].startTime}-${value.slotList.slots![i].endTime}'
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              )),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          child: MyElevatedButton(
              onPressed: () {
                value.onCheckout();
              },
              color: ThemeProvider.appColor,
              height: 45,
              width: double.infinity,
              child: Text(
                'Chekout'.tr,
                style: const TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'bold'),
              )),
        ),
      );
    });
  }
}
