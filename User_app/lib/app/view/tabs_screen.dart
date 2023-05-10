/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/view/account_screen.dart';
import 'package:handyman/app/view/history_screen.dart';
import 'package:handyman/app/view/home_screen.dart';
import 'package:handyman/app/view/inbox_screen.dart';
import 'package:handyman/app/view/product_category_screen.dart';

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
          backgroundColor: Colors.white,
          bottomNavigationBar: (TabBar(
            controller: value.tabController,
            labelColor: ThemeProvider.appColor,
            unselectedLabelColor: const Color.fromARGB(255, 185, 196, 207),
            indicatorColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            labelStyle: const TextStyle(
              fontFamily: 'regular',
              fontSize: 12,
            ),
            onTap: (int index) => value.updateTabId(index),
            tabs: [
              Tab(
                icon: Icon(
                    value.currentIndex != 0
                        ? Icons.home_outlined
                        : Icons.home_sharp,
                    color: value.currentIndex == 0
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Home'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex != 1
                        ? Icons.history_outlined
                        : Icons.history,
                    color: value.currentIndex == 1
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'History'.tr,
              ),
              Tab(
                icon: value.cartTotal > 0
                    ? badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: ThemeProvider.appColor,
                        ),
                        //
                        badgeContent: Text(
                          value.cartTotal.toString(),
                          style:
                              const TextStyle(color: ThemeProvider.whiteColor),
                        ),
                        child: Icon(
                          value.currentIndex != 2
                              ? Icons.shopping_cart_outlined
                              : Icons.shopping_cart,
                          color: value.currentIndex == 2
                              ? ThemeProvider.appColor
                              : ThemeProvider.greyColor,
                        ),
                      )
                    : Icon(
                        value.currentIndex != 2
                            ? Icons.shopping_cart_outlined
                            : Icons.shopping_cart,
                        color: value.currentIndex == 2
                            ? ThemeProvider.appColor
                            : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Shop'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex != 3
                        ? Icons.email_outlined
                        : Icons.email,
                    color: value.currentIndex == 3
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Inbox'.tr,
              ),
              Tab(
                icon: Icon(
                    value.currentIndex != 4
                        ? Icons.person_outline
                        : Icons.person,
                    color: value.currentIndex == 4
                        ? ThemeProvider.appColor
                        : const Color.fromARGB(255, 185, 196, 207)),
                text: 'Account'.tr,
              ),
            ],
          )),
          body: TabBarView(
            controller: value.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              HistoryScreen(),
              ProductCategoryScreen(),
              InboxScreen(),
              AccountScreen(),
            ],
          ),
        ),
      );
    });
  }
}
