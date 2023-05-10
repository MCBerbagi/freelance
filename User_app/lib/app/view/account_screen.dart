/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:handyman/app/controller/account_controller.dart';
import 'package:handyman/app/helper/router.dart';
import 'package:handyman/app/util/theme.dart';
import 'package:get/get.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/widget/navbar.dart';

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
              value.login == true
                  ? TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.only(left: 6),
                      ),
                      onPressed: () {
                        value.onEditProfile();
                      },
                      child: Text(
                        'Edit'.tr,
                        style: const TextStyle(
                          color: ThemeProvider.whiteColor,
                          fontFamily: 'medium',
                          fontSize: 14,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 16),
                value.login == true
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: FadeInImage(
                          image: NetworkImage(
                              '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                          placeholder: const AssetImage(
                              "assets/images/placeholder.jpeg"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/notfound.png',
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: value.login == true ? 10 : 0),
                value.login == true
                    ? heading2(
                        '${value.firstName.toString()} ${value.lastName.toString()}')
                    : const SizedBox(),
                SizedBox(height: value.login == true ? 2 : 0),
                value.login == true
                    ? lightText(value.email.toString())
                    : const SizedBox(),
                SizedBox(height: value.login == true ? 16 : 0),
                value.login == false
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            value.onLogin();
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.login_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Login / Register'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            value.onProductHistory();
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.file_present_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Product History'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            value.onFavorite();
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.favorite_outline),
                          minLeadingWidth: 0,
                          title: heading4('Favorite'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            value.onAddress();
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.location_on_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Your Address'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            value.onChat();
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.support_agent_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Inbox'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                              AppRouter.getWalletRoute(),
                            );
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading:
                              const Icon(Icons.account_balance_wallet_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Wallet'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                value.login == true
                    ? Card(
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                              AppRouter.getReferRoute(),
                            );
                          },
                          visualDensity: const VisualDensity(vertical: -3),
                          leading: const Icon(Icons.insert_invitation_outlined),
                          minLeadingWidth: 0,
                          title: heading4('Refer & Earn'.tr),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    : const SizedBox(),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onLanguage();
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
                      value.onContactUs();
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
                value.login == true
                    ? Card(
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
                      )
                    : const SizedBox(),
              ],
            ),
          ));
    });
  }
}
