/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/backend/parse/account_parse.dart';
import 'package:handyman/app/backend/parse/add_address_parse.dart';
import 'package:handyman/app/backend/parse/add_card_parse.dart';
import 'package:handyman/app/backend/parse/add_product_review_parse.dart';
import 'package:handyman/app/backend/parse/add_review_parse.dart';
import 'package:handyman/app/backend/parse/address_list_parse.dart';
import 'package:handyman/app/backend/parse/address_parse.dart';
import 'package:handyman/app/backend/parse/app_page_parse.dart';
import 'package:handyman/app/backend/parse/appointment_detail_parse.dart';
import 'package:handyman/app/backend/parse/booking_parse.dart';
import 'package:handyman/app/backend/parse/cart_parse.dart';
import 'package:handyman/app/backend/parse/category_parse.dart';
import 'package:handyman/app/backend/parse/chat_parse.dart';
import 'package:handyman/app/backend/parse/checkout_parse.dart';
import 'package:handyman/app/backend/parse/choose_location_parse.dart';
import 'package:handyman/app/backend/parse/complaints_parse.dart';
import 'package:handyman/app/backend/parse/contactus_parse.dart';
import 'package:handyman/app/backend/parse/coupens_parse.dart';
import 'package:handyman/app/backend/parse/edit_profile_parse.dart';
import 'package:handyman/app/backend/parse/favorite_parse.dart';
import 'package:handyman/app/backend/parse/filter_parse.dart';
import 'package:handyman/app/backend/parse/find_location_parse.dart';
import 'package:handyman/app/backend/parse/firebase_parse.dart';
import 'package:handyman/app/backend/parse/forgot_password_parse.dart';
import 'package:handyman/app/backend/parse/freelancer_product_parse.dart';
import 'package:handyman/app/backend/parse/handyman_profile_parse.dart';
import 'package:handyman/app/backend/parse/history_parse.dart';
import 'package:handyman/app/backend/parse/home_parse.dart';
import 'package:handyman/app/backend/parse/inbox_parse.dart';
import 'package:handyman/app/backend/parse/language_parse.dart';
import 'package:handyman/app/backend/parse/login_parse.dart';
import 'package:handyman/app/backend/parse/notification_parse.dart';
import 'package:handyman/app/backend/parse/popular_parse.dart';
import 'package:handyman/app/backend/parse/popular_product_parse.dart';
import 'package:handyman/app/backend/parse/product_cart_parse.dart';
import 'package:handyman/app/backend/parse/product_category_parse.dart';
import 'package:handyman/app/backend/parse/product_checkout_parse.dart';
import 'package:handyman/app/backend/parse/product_detail_parse.dart';
import 'package:handyman/app/backend/parse/product_history_parse.dart';
import 'package:handyman/app/backend/parse/product_listing_parse.dart';
import 'package:handyman/app/backend/parse/product_order_detail_parse.dart';
import 'package:handyman/app/backend/parse/refer_parse.dart';
import 'package:handyman/app/backend/parse/register_parse.dart';
import 'package:handyman/app/backend/parse/search_parse.dart';
import 'package:handyman/app/backend/parse/service_detail_parse.dart';
import 'package:handyman/app/backend/parse/services_parse.dart';
import 'package:handyman/app/backend/parse/single_product_review_parse.dart';
import 'package:handyman/app/backend/parse/slider_parse.dart';
import 'package:handyman/app/backend/parse/splash_parse.dart';
import 'package:handyman/app/backend/parse/stripe_pay_parse.dart';
import 'package:handyman/app/backend/parse/subcategory_parse.dart';
import 'package:handyman/app/backend/parse/tabs_parse.dart';
import 'package:handyman/app/backend/parse/top_freelancers_parse.dart';
import 'package:handyman/app/backend/parse/top_products_parse.dart';
import 'package:handyman/app/backend/parse/track_booking_parse.dart';
import 'package:handyman/app/backend/parse/wallet_parse.dart';
import 'package:handyman/app/backend/parse/web_payment_parse.dart';
import 'package:handyman/app/backend/parse/web_payment_product_parse.dart';
import 'package:handyman/app/backend/parse/welcome_parse.dart';
import 'package:handyman/app/controller/account_controller.dart';
import 'package:handyman/app/controller/cart_controller.dart';
import 'package:handyman/app/controller/history_controller.dart';
import 'package:handyman/app/controller/home_controller.dart';
import 'package:handyman/app/controller/inbox_controller.dart';
import 'package:handyman/app/controller/product_cart_controller.dart';
import 'package:handyman/app/controller/product_category_controller.dart';
import 'package:handyman/app/controller/tabs_controller.dart';
import 'package:handyman/app/env.dart';
import 'package:handyman/app/helper/shared_pref.dart';
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
        () => RegisterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoginParser(
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
        () => ServicesParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HandymanProfileParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HistoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SubcategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => BookingParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChooseLocationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FindLocationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AccountParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FilterParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CheckoutParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddReviewParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppPageParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FavoriteParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => NotificationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => PopularParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => PopularProductParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ChatParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => InboxParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => TrackBookingParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddressParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WalletParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LanguageParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ContactUsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ReferParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AppointmentDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductCategoryParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductListingParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductCheckoutParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceDetailParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddAddressParse(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddressListParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CoupensParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SplashScreenParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => CartParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => AddCardParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => StripePayParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WebPaymentParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => WebPaymentProductParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductHistoryParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProductOrderDetailParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FreelancerProductParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => AddProductReviewParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SingleProductReviewParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => EditProfileParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => SearchParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => FirebaseParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopFreelancersParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => TopProductsParse(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ComplaintsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(() => ProductCartParser(
        sharedPreferencesManager: Get.find(), apiService: Get.find()));
    Get.lazyPut(() => CartController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => ProductCartController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => ProductCategoryController(parser: Get.find()),
        fenix: true);
    Get.lazyPut(() => InboxController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}
