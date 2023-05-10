/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/binding/add_product_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/add_service_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/add_slot_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/app_page_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/chat_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/city_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/contactus_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/edit_profile_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/firebase_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/forgot_password_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/home_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/inbox_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/language_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/login_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/notification_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_category_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_order_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_order_detail_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_review_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/product_subcategory_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/register_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/register_category_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/served_category_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/service_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/service_category_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/service_detail_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/review_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/slider_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/slot_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/splash_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/tabs_binding.dart';
import 'package:handyman_freelancer/app/backend/binding/welcome_binding.dart';
import 'package:handyman_freelancer/app/view/add_product_screen.dart';
import 'package:handyman_freelancer/app/view/add_service_screen.dart';
import 'package:handyman_freelancer/app/view/add_slot_screen.dart';
import 'package:handyman_freelancer/app/view/app_page_screen.dart';
import 'package:handyman_freelancer/app/view/chat_screen.dart';
import 'package:handyman_freelancer/app/view/city_screen.dart';
import 'package:handyman_freelancer/app/view/contactus_screen.dart';
import 'package:handyman_freelancer/app/view/edit_profile_screen.dart';
import 'package:handyman_freelancer/app/view/error_screen.dart';
import 'package:handyman_freelancer/app/view/firebase.dart';
import 'package:handyman_freelancer/app/view/forgot_password_screen.dart';
import 'package:handyman_freelancer/app/view/home_screen.dart';
import 'package:handyman_freelancer/app/view/inbox_screen.dart';
import 'package:handyman_freelancer/app/view/language_screen.dart';
import 'package:handyman_freelancer/app/view/login_screen.dart';
import 'package:handyman_freelancer/app/view/notification_screen.dart';
import 'package:handyman_freelancer/app/view/product_category_screen.dart';
import 'package:handyman_freelancer/app/view/product_order_detail_screen.dart';
import 'package:handyman_freelancer/app/view/product_order_screen.dart';
import 'package:handyman_freelancer/app/view/product_review_screen.dart';
import 'package:handyman_freelancer/app/view/product_screen.dart';
import 'package:handyman_freelancer/app/view/product_subcategory_screen.dart';
import 'package:handyman_freelancer/app/view/register_category.dart';
import 'package:handyman_freelancer/app/view/register_screen.dart';
import 'package:handyman_freelancer/app/view/served_category_screen.dart';
import 'package:handyman_freelancer/app/view/service_category_screen.dart';
import 'package:handyman_freelancer/app/view/service_detail_screen.dart';
import 'package:handyman_freelancer/app/view/service_screen.dart';
import 'package:handyman_freelancer/app/view/review_screen.dart';
import 'package:handyman_freelancer/app/view/slider_screen.dart';
import 'package:handyman_freelancer/app/view/slot_screen.dart';
import 'package:handyman_freelancer/app/view/splash_screen.dart';
import 'package:handyman_freelancer/app/view/tabs_screen.dart';
import 'package:handyman_freelancer/app/view/welcome_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String intro = '/intro';
  static const String errorRoutes = '/error';

  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String tabs = '/tabs';
  static const String home = '/home';
  static const String account = '/account';
  static const String analyze = '/analyze';
  static const String review = '/review';
  static const String productReview = '/productReview';
  static const String inbox = '/inbox';
  static const String chat = '/chat';
  static const String notification = '/notification';
  static const String language = '/language';
  static const String serviceDetail = '/serviceDetail';
  static const String service = '/service';
  static const String editProfile = '/editProfile';
  static const String addService = '/addService';
  static const String contactUs = '/contactUs';
  static const String appPage = '/appPage';
  static const String product = '/product';
  static const String addProduct = '/addProduct';
  static const String serviceCategory = '/serviceCategory';
  static const String productCategory = '/productCategory';
  static const String productSubCategory = '/productSubCategory';
  static const String servedCategory = '/servedCategory';
  static const String city = '/city';
  static const String slot = '/slot';
  static const String addSlot = '/addSlot';
  static const String productOrder = '/productOrder';
  static const String productOrderDetail = '/productOrderDetail';
  static const String registerCategoryRoutes = '/registerCategory';
  static const String firebaseVerificationRoutes = '/firebaseVerification';

  static String getInitialRoute() => initial;
  static String getIntroRoutes() => intro;
  static String getErrorRoutes() => errorRoutes;

  static String getWelcomeRoute() => welcome;
  static String getLoginRoute() => login;
  static String getRegisterRoute() => register;
  static String getForgotPasswordRoute() => forgotPassword;
  static String getTabsRoute() => tabs;
  static String getHomeRoute() => home;
  static String getAccountRoute() => account;
  static String getAnalyzeRoute() => analyze;
  static String getReviewRoute() => review;
  static String getProductReviewRoute() => productReview;
  static String getInboxRoute() => inbox;
  static String getChatRoute() => chat;
  static String getNotificationRoute() => notification;
  static String getLanguageRoute() => language;
  static String getServiceDetailRoute() => serviceDetail;
  static String getServiceRoute() => service;
  static String getAddServiceRoute() => addService;
  static String getEditProfileRoute() => editProfile;
  static String getContactUsRoute() => contactUs;
  static String getAppPageRoute() => appPage;
  static String getProductRoute() => product;
  static String getAddProductRoute() => addProduct;
  static String getServiceCategoryRoute() => serviceCategory;
  static String getProductCategoryRoute() => productCategory;
  static String getProductSubCategoryRoute() => productSubCategory;
  static String getServedCategoryRoute() => servedCategory;
  static String getCityRoute() => city;
  static String getSlotRoute() => slot;
  static String getAddSlotRoute() => addSlot;
  static String getProductOrderRoute() => productOrder;
  static String getProductOrderDetailRoute() => productOrderDetail;
  static String getRegisterCategoryRoutes() => registerCategoryRoutes;
  static String getFirebaseVerificationRoutes() => firebaseVerificationRoutes;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const SplashScreen(),
        binding: SplashBinging()),
    GetPage(
        name: intro,
        page: () => const SliderScreen(),
        binding: SliderBindings()),
    GetPage(name: errorRoutes, page: () => const ErrorScreen()),
    GetPage(
        name: welcome,
        page: () => const WelcomeScreen(),
        binding: WelcomeBindings()),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBindings(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: tabs,
      page: () => const TabsScreen(),
      binding: TabsBindings(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: analyze,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: review,
      page: () => const ReviewScreen(),
      binding: ReviewBindings(),
    ),
    GetPage(
      name: productReview,
      page: () => const ProductReviewScreen(),
      binding: ProductReviewBindings(),
    ),
    GetPage(
      name: inbox,
      page: () => const InboxScreen(),
      binding: InboxBindings(),
    ),
    GetPage(
      name: chat,
      page: () => const ChatScreen(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBindings(),
    ),
    GetPage(
      name: serviceDetail,
      page: () => const ServiceDetailScreen(),
      binding: ServiceDetailBindings(),
    ),
    GetPage(
      name: service,
      page: () => const ServiceScreen(),
      binding: ServiceBindings(),
    ),
    GetPage(
      name: addService,
      page: () => const AddServiceScreen(),
      binding: AddServiceBindings(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBindings(),
    ),
    GetPage(
      name: contactUs,
      page: () => const ContactUsScreen(),
      binding: ContactusBindings(),
    ),
    GetPage(
      name: appPage,
      page: () => const AppPageScreen(),
      binding: AppPageBindings(),
    ),
    GetPage(
      name: product,
      page: () => const ProductScreen(),
      binding: ProductBindings(),
    ),
    GetPage(
      name: addProduct,
      page: () => const AddProductScreen(),
      binding: AddProductBindings(),
    ),
    GetPage(
      name: serviceCategory,
      page: () => const ServiceCategoryScreen(),
      binding: ServiceCategoryBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: productCategory,
      page: () => const ProductCategoryScreen(),
      binding: ProductCategoryBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: productSubCategory,
      page: () => const ProductSubCategoryScreen(),
      binding: ProductSubCategoryBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: servedCategory,
      page: () => const ServedCategoryScreen(),
      binding: ServedCategoryBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: city,
      page: () => const CityScreen(),
      binding: CityBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: slot,
      page: () => const SlotScreen(),
      binding: SlotBindings(),
    ),
    GetPage(
      name: addSlot,
      page: () => const AddSlotScreen(),
      binding: AddSlotBindings(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: productOrder,
      page: () => const ProductOrderScreen(),
      binding: ProductOrderBindings(),
    ),
    GetPage(
      name: productOrderDetail,
      page: () => const ProductOrderDetailScreen(),
      binding: ProductOrderDetailBindings(),
    ),
    GetPage(
        name: registerCategoryRoutes,
        page: () => const RegisterCategoryScreen(),
        binding: RegisterCategoryBindings(),
        fullscreenDialog: true),
    GetPage(
        name: firebaseVerificationRoutes,
        page: () => const FirebaseVerificationScreen(),
        binding: FirebaseBinding())
  ];
}
