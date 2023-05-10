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
import 'package:handyman/app/controller/account_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:handyman/app/env.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Drawer(
        child: ListView(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: [
            value.login == true
                ? UserAccountsDrawerHeader(
                    decoration:
                        const BoxDecoration(color: ThemeProvider.appColor),
                    accountName: Text(
                      '${value.firstName.toString()} ${value.lastName.toString()}',
                      style: const TextStyle(color: ThemeProvider.whiteColor),
                    ),
                    accountEmail: Text(
                      value.email.toString(),
                      style: const TextStyle(color: ThemeProvider.whiteColor),
                    ),
                    currentAccountPicture: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 100,
                      height: 100,
                      child: FadeInImage(
                        image: NetworkImage(
                            '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                        placeholder:
                            const AssetImage("assets/images/placeholder.jpeg"),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.jpeg',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(),
            value.login == false
                ? const SizedBox(
                    height: 60,
                  )
                : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(0);
              },
            ),
            value.login == true
                ? ListTile(
                    leading: const Icon(Icons.handyman),
                    title: Text('Service Appointments'.tr),
                    onTap: () {
                      Navigator.of(context).pop(true);
                      Get.find<TabsController>().updateTabId(1);
                    },
                  )
                : const SizedBox(),
            value.login == true
                ? ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text('Product Orders'.tr),
                    onTap: () {
                      Navigator.of(context).pop(true);
                      Get.toNamed(
                        AppRouter.getProductHistoryRoute(),
                      );
                    },
                  )
                : const SizedBox(),
            value.login == true
                ? ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text('Inbox'.tr),
                    onTap: () {
                      Navigator.of(context).pop(true);
                      Get.find<TabsController>().updateTabId(3);
                    },
                  )
                : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Profile'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language_outlined),
              title: Text('Language'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.toNamed(
                  AppRouter.getLanguageRoute(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: Text('Change Password'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.toNamed(
                  AppRouter.getForgotPasswordRoute(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail_outlined),
              title: Text('Contact Us'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.toNamed(
                  AppRouter.getContactUsRoute(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('About Us'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('About Us', '1');
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: Text('FAQs'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Frequently Asked Questions'.tr, '5');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text('Help'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Help'.tr, '6');
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text('Terms & Conditions'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Terms & Conditions'.tr, '3');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_open_outlined),
              title: Text('Privacy Policy'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onAppPages('Privacy Policy'.tr, '2');
              },
            ),
            value.login == true
                ? ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: Text('Logout'.tr),
                    onTap: () {
                      Navigator.of(context).pop(true);
                      value.logout();
                    },
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
