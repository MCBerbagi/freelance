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
import 'package:handyman_freelancer/app/controller/account_controller.dart';
import 'package:handyman_freelancer/app/controller/product_review_controller.dart';
import 'package:handyman_freelancer/app/controller/review_controller.dart';
import 'package:handyman_freelancer/app/controller/tabs_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/env.dart';

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
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: ThemeProvider.appColor),
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
                    return Image.asset('assets/images/placeholder.jpeg',
                        fit: BoxFit.cover);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text('Home'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text('Profile'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: Text('Orders'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart_outline_rounded),
              title: Text('Analytics'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text('Inbox'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.find<TabsController>().updateTabId(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_repair_service_outlined),
              title: Text('My Services'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onServices();
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: Text('My Products'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onProducts();
              },
            ),
            ListTile(
              leading: const Icon(Icons.timelapse_outlined),
              title: Text('My Slot'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.onSlots();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border_outlined),
              title: Text('Review'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.delete<ReviewController>(force: true);
                Get.toNamed(
                  AppRouter.getReviewRoute(),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_half_outlined),
              title: Text('Product Review'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                Get.delete<ProductReviewController>(force: true);
                Get.toNamed(
                  AppRouter.getProductReviewRoute(),
                );
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
                value.onAppPages('About Us'.tr, '1');
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
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text('Logout'.tr),
              onTap: () {
                Navigator.of(context).pop(true);
                value.logout();
              },
            ),
          ],
        ),
      );
    });
  }
}
