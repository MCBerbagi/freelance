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
import 'package:handyman_freelancer/app/controller/tabs_controller.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/view/account_screen.dart';
import 'package:handyman_freelancer/app/view/analyze_screen.dart';
import 'package:handyman_freelancer/app/view/home_screen.dart';
import 'package:handyman_freelancer/app/view/inbox_screen.dart';
import 'package:handyman_freelancer/app/view/product_order_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const String id = 'Tabs';

  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(builder: (value) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          bottomNavigationBar: (TabBar(
            controller: value.tabController,
            padding: const EdgeInsets.all(5),
            labelColor: ThemeProvider.appColor,
            unselectedLabelColor: const Color.fromARGB(255, 185, 196, 207),
            indicatorColor: ThemeProvider.transparentColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            labelStyle: const TextStyle(
              fontFamily: 'regular',
              fontSize: 12,
            ),
            onTap: (int index) => value.updateIndex(index),
            tabs: [
              Tab(
                icon: Icon(
                    value.currentIndex == 0
                        ? Icons.home_sharp
                        : Icons.home_outlined,
                    color: value.currentIndex == 0
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Home'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex == 1
                        ? Icons.shopping_bag_sharp
                        : Icons.shopping_bag_outlined,
                    color: value.currentIndex == 1
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Orders'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex == 2
                        ? Icons.currency_exchange_sharp
                        : Icons.currency_exchange_outlined,
                    color: value.currentIndex == 2
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Earnings'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex == 3
                        ? Icons.email_sharp
                        : Icons.email_outlined,
                    color: value.currentIndex == 3
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Inbox'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex == 4
                        ? Icons.person_sharp
                        : Icons.person_outline,
                    color: value.currentIndex == 4
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Profile'.tr,
              ),
            ],
          )),
          body: TabBarView(
            controller: value.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              ProductOrderScreen(),
              AnalyzeScreen(),
              InboxScreen(),
              AccountScreen(),
            ],
          ),
        ),
      );
    });
  }
}
