/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman_freelancer/app/controller/account_controller.dart';
import 'package:handyman_freelancer/app/controller/edit_profile_controller.dart';
import 'package:handyman_freelancer/app/controller/product_review_controller.dart';
import 'package:handyman_freelancer/app/controller/review_controller.dart';
import 'package:handyman_freelancer/app/controller/tabs_controller.dart';
import 'package:handyman_freelancer/app/helper/router.dart';
import 'package:handyman_freelancer/app/util/theme.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/widget/navbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Scaffold(
          drawer: const NavBar(),
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'My Account'.tr,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.only(left: 6),
                ),
                onPressed: () {
                  Get.delete<EditProfileController>(force: true);
                  Get.toNamed(AppRouter.getEditProfileRoute());
                },
                child: Text(
                  'Edit'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'medium',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
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
                      return Image.asset('assets/images/notfound.png',
                          fit: BoxFit.cover, height: 100, width: 100);
                    },
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 10),
                heading2(
                    '${value.firstName.toString()} ${value.lastName.toString()}'),
                const SizedBox(height: 2),
                lightText(value.email.toString()),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onServices();
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.home_repair_service_outlined),
                    minLeadingWidth: 0,
                    title: heading4('My Services'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onProducts();
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.shopping_cart_outlined),
                    minLeadingWidth: 0,
                    title: heading4('My Products'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onSlots();
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.timelapse_outlined),
                    minLeadingWidth: 0,
                    title: heading4('My Slot'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.delete<ReviewController>(force: true);
                      Get.toNamed(
                        AppRouter.getReviewRoute(),
                      );
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.star_border_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Review'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.delete<ProductReviewController>(force: true);
                      Get.toNamed(
                        AppRouter.getProductReviewRoute(),
                      );
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.star_half_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Product Review'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(
                        AppRouter.getLanguageRoute(),
                      );
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.language_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Language'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(
                        AppRouter.getForgotPasswordRoute(),
                      );
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.lock_outline),
                    minLeadingWidth: 0,
                    title: heading4('Change Password'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(
                        AppRouter.getContactUsRoute(),
                      );
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.contact_mail_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Contact Us'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Get.find<TabsController>().updateTabId(3);
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.support_agent_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Chats'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onAppPages('About Us'.tr, '1');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.info_outline),
                    minLeadingWidth: 0,
                    title: heading4('About Us'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onAppPages('Frequently Asked Questions'.tr, '5');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.flag_outlined),
                    minLeadingWidth: 0,
                    title: heading4('FAQs'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onAppPages('Help'.tr, '6');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.help_outline),
                    minLeadingWidth: 0,
                    title: heading4('Help'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onAppPages('Terms & Conditions'.tr, '3');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.privacy_tip_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Terms & Conditions'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onAppPages('Privacy Policy'.tr, '2');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.lock_open_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Privacy Policy'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.logout();
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.logout_outlined),
                    minLeadingWidth: 0,
                    title: heading4('Logout'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
