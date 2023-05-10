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
import 'package:handyman_freelancer/app/backend/parse/tabs_parse.dart';

class TabsController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final TabsParser parser;
  int currentIndex = 0;
  String title = '';
  late TabController tabController;
  TabsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: 5, vsync: this, initialIndex: currentIndex);
  }

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }

  void updateTabId(int id) {
    currentIndex = id;
    tabController.animateTo(currentIndex);
    update();
  }
}
