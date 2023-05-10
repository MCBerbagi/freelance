/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/api.dart';
import 'package:handyman_freelancer/app/backend/parse/account_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/add_product_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/add_service_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/add_slot_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/analyze_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/app_page_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/chat_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/city_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/contactus_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/edit_profile_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/firebase_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/forgot_password_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/home_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/inbox_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/language_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/login_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/notification_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_category_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_order_detail_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_order_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_review_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/product_subcategory_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/register_category_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/register_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/served_category_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/service_category_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/service_detail_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/service_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/review_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/slider_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/slot_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/splash_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/tabs_parse.dart';
import 'package:handyman_freelancer/app/backend/parse/welcome_parse.dart';
import 'package:handyman_freelancer/app/controller/account_controller.dart';
import 'package:handyman_freelancer/app/controller/analyze_controller.dart';
import 'package:handyman_freelancer/app/controller/home_controller.dart';
import 'package:handyman_freelancer/app/controller/inbox_controller.dart';
import 'package:handyman_freelancer/app/controller/product_order_controller.dart';
import 'package:handyman_freelancer/app/controller/tabs_controller.dart';
import 'package:handyman_freelancer/app/env.dart';
import 'package:handyman_freelancer/app/helper/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // Parser LazyLoad
    Get.lazyPut(
        () => SliderParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WelcomeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoginParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RegisterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ForgotPasswordParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TabsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HomeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AccountParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AnalyzeParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ReviewParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductReviewParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => InboxParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChatParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => NotificationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LanguageParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddServiceParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => EditProfileParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ContactUsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppPageParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddProductParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceCategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductCategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductSubCategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServedCategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CityParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SlotParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddSlotParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductOrderParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductOrderDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashScreenParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => RegisterCategoryParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FirebaseParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => ProductOrderController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AnalyzeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => InboxController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}
