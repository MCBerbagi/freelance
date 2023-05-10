/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/backend/binding/account_binding.dart';
import 'package:handyman/app/backend/binding/add_address_binding.dart';
import 'package:handyman/app/backend/binding/add_card_binding.dart';
import 'package:handyman/app/backend/binding/add_product_review_binding.dart';
import 'package:handyman/app/backend/binding/add_review_binding.dart';
import 'package:handyman/app/backend/binding/address_binding.dart';
import 'package:handyman/app/backend/binding/address_list_binding.dart';
import 'package:handyman/app/backend/binding/app_page_binding.dart';
import 'package:handyman/app/backend/binding/appointment_detail_binding.dart';
import 'package:handyman/app/backend/binding/booking_binding.dart';
import 'package:handyman/app/backend/binding/category_binding.dart';
import 'package:handyman/app/backend/binding/chat_binding.dart';
import 'package:handyman/app/backend/binding/checkout_binding.dart';
import 'package:handyman/app/backend/binding/choose_location_binding.dart';
import 'package:handyman/app/backend/binding/complaints_binding.dart';
import 'package:handyman/app/backend/binding/contactus_binding.dart';
import 'package:handyman/app/backend/binding/coupens_binding.dart';
import 'package:handyman/app/backend/binding/edit_profile_binding.dart';
import 'package:handyman/app/backend/binding/favorite_binding.dart';
import 'package:handyman/app/backend/binding/filter_binding.dart';
import 'package:handyman/app/backend/binding/find_location_binding.dart';
import 'package:handyman/app/backend/binding/firebase_binding.dart';
import 'package:handyman/app/backend/binding/forgot_password_binding.dart';
import 'package:handyman/app/backend/binding/freelancer_product_binding.dart';
import 'package:handyman/app/backend/binding/handyman_profile_binding.dart';
import 'package:handyman/app/backend/binding/history_binding.dart';
import 'package:handyman/app/backend/binding/home_binding.dart';
import 'package:handyman/app/backend/binding/inbox_binding.dart';
import 'package:handyman/app/backend/binding/language_binding.dart';
import 'package:handyman/app/backend/binding/login_binding.dart';
import 'package:handyman/app/backend/binding/notification_binding.dart';
import 'package:handyman/app/backend/binding/popular_binding.dart';
import 'package:handyman/app/backend/binding/popular_product_binding.dart';
import 'package:handyman/app/backend/binding/product_category_binding.dart';
import 'package:handyman/app/backend/binding/product_checkout_binding.dart';
import 'package:handyman/app/backend/binding/product_detail_binding.dart';
import 'package:handyman/app/backend/binding/product_history_binding.dart';
import 'package:handyman/app/backend/binding/product_listing_binding.dart';
import 'package:handyman/app/backend/binding/product_order_detail_binding.dart';
import 'package:handyman/app/backend/binding/refer_binding.dart';
import 'package:handyman/app/backend/binding/register_binding.dart';
import 'package:handyman/app/backend/binding/search_binding.dart';
import 'package:handyman/app/backend/binding/service_detail_binding.dart';
import 'package:handyman/app/backend/binding/services_binding.dart';
import 'package:handyman/app/backend/binding/single_product_review_binding.dart';
import 'package:handyman/app/backend/binding/slider_binding.dart';
import 'package:handyman/app/backend/binding/splash_binding.dart';
import 'package:handyman/app/backend/binding/stripe_pay_binding.dart';
import 'package:handyman/app/backend/binding/subcategory_binding.dart';
import 'package:handyman/app/backend/binding/tabs_binding.dart';
import 'package:handyman/app/backend/binding/top_freelancers_binding.dart';
import 'package:handyman/app/backend/binding/top_products_binding.dart';
import 'package:handyman/app/backend/binding/track_booking_binding.dart';
import 'package:handyman/app/backend/binding/wallet_binding.dart';
import 'package:handyman/app/backend/binding/web_payment_binding.dart';
import 'package:handyman/app/backend/binding/web_payment_product_binding.dart';
import 'package:handyman/app/backend/binding/welcome_binding.dart';
import 'package:handyman/app/view/account_screen.dart';
import 'package:handyman/app/view/add_address_screen.dart';
import 'package:handyman/app/view/add_card.dart';
import 'package:handyman/app/view/add_product_review.dart';
import 'package:handyman/app/view/add_review_screen.dart';
import 'package:handyman/app/view/address_list_screen.dart';
import 'package:handyman/app/view/address_screen.dart';
import 'package:handyman/app/view/app_page_screen.dart';
import 'package:handyman/app/view/appointment_detail.dart';
import 'package:handyman/app/view/booking_screen.dart';
import 'package:handyman/app/view/category_screen.dart';
import 'package:handyman/app/view/chat_screen.dart';
import 'package:handyman/app/view/checkout_screen.dart';
import 'package:handyman/app/view/choose_location_screen.dart';
import 'package:handyman/app/view/complaints.dart';
import 'package:handyman/app/view/contactus_screen.dart';
import 'package:handyman/app/view/coupens_screen.dart';
import 'package:handyman/app/view/edit_profile_screen.dart';
import 'package:handyman/app/view/error_screen.dart';
import 'package:handyman/app/view/favorite_screen.dart';
import 'package:handyman/app/view/filter_screen.dart';
import 'package:handyman/app/view/find_location.dart';
import 'package:handyman/app/view/firebase.dart';
import 'package:handyman/app/view/forgot_password_screen.dart';
import 'package:handyman/app/view/freelancer_product_screen.dart';
import 'package:handyman/app/view/handyman_profile_screen.dart';
import 'package:handyman/app/view/history_screen.dart';
import 'package:handyman/app/view/home_screen.dart';
import 'package:handyman/app/view/inbox_screen.dart';
import 'package:handyman/app/view/language_screen.dart';
import 'package:handyman/app/view/login_screen.dart';
import 'package:handyman/app/view/notification_screen.dart';
import 'package:handyman/app/view/popular_product_screen.dart';
import 'package:handyman/app/view/popular_screen.dart';
import 'package:handyman/app/view/product_category_screen.dart';
import 'package:handyman/app/view/product_checkout_screen.dart';
import 'package:handyman/app/view/product_detail.dart';
import 'package:handyman/app/view/product_history_screen.dart';
import 'package:handyman/app/view/product_listing.dart';
import 'package:handyman/app/view/product_order_detail_screen.dart';
import 'package:handyman/app/view/refer_screen.dart';
import 'package:handyman/app/view/register_screen.dart';
import 'package:handyman/app/view/search_screep.dart';
import 'package:handyman/app/view/service_detail_screen.dart';
import 'package:handyman/app/view/services_screen.dart';
import 'package:handyman/app/view/single_product_review.dart';
import 'package:handyman/app/view/slider_screen.dart';
import 'package:handyman/app/view/splash_screen.dart';
import 'package:handyman/app/view/stripe_pay.dart';
import 'package:handyman/app/view/subcategory_screen.dart';
import 'package:handyman/app/view/tabs_screen.dart';
import 'package:handyman/app/view/top_freelancers.dart';
import 'package:handyman/app/view/top_products_screen.dart';
import 'package:handyman/app/view/track_booking_screen.dart';
import 'package:handyman/app/view/wallet_screen.dart';
import 'package:handyman/app/view/web_payment.dart';
import 'package:handyman/app/view/web_payment_product.dart';
import 'package:handyman/app/view/welcome_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String intro = '/intro';
  static const String errorRoutes = '/error';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String tabs = '/tabs';
  static const String home = '/home';
  static const String services = '/services';
  static const String handymanProfile = '/handymanProfile';
  static const String history = '/history';
  static const String subcategory = '/subcategory';
  static const String category = '/category';
  static const String booking = '/booking';
  static const String filter = '/filter';
  static const String checkout = '/checkout';
  static const String addReview = '/addReview';
  static const String favorite = '/favorite';
  static const String notification = '/notification';
  static const String popular = '/popular';
  static const String popularProduct = '/popularProduct';
  static const String account = '/account';
  static const String chooseLocation = '/chooseLocation';
  static const String findLocation = '/findLocation';
  static const String inbox = '/inbox';
  static const String chat = '/chat';
  static const String trackBooking = '/trackBooking';
  static const String address = '/address';
  static const String wallet = '/wallet';
  static const String refer = '/refer';
  static const String language = '/language';
  static const String contactus = '/contactus';
  static const String appointmentDetail = '/appointmentDetail';
  static const String productCategory = '/productCategory';
  static const String productDetail = '/productDetail';
  static const String productListing = '/productListing';
  static const String productCheckout = '/productCheckout';
  static const String serviceDetail = '/serviceDetail';
  static const String addAddress = '/addAddress';
  static const String addressList = '/addressList';
  static const String coupons = '/coupons';
  static const String addNewCard = '/addNewStripeCard';
  static const String stripePayRoutes = '/stripePay';
  static const String webPaymentsRoutes = '/webPayments';
  static const String webPaymentsProductRoutes = '/webPaymentsProduct';
  static const String productHistory = '/productHistory';
  static const String productOrderDetail = '/productOrderDetail';
  static const String freelancerProduct = '/freelancerProduct';
  static const String addProductReview = '/addProductReview';
  static const String singleProductReview = '/singleProductReview';
  static const String editProfile = '/editProfile';
  static const String search = '/search';
  static const String appPage = '/appPage';
  static const String firebaseAuth = '/firebaseAuth';
  static const String topFreelancers = '/topFreelancers';
  static const String topProducts = '/topProducts';
  static const String complaintsRoutes = '/complaints';

  static String getInitialRoute() => initial;
  static String getIntroRoutes() => intro;
  static String getErrorRoutes() => errorRoutes;
  static String getWelcomeRoute() => welcome;
  static String getRegisterRoute() => register;
  static String getLoginRoute() => login;
  static String getForgotPasswordRoute() => forgotPassword;
  static String getTabsRoute() => tabs;
  static String getHomeRoute() => home;
  static String getServicesRoute() => services;
  static String getHandymanProfileRoute() => handymanProfile;
  static String getHistoryRoute() => history;
  static String getSubcategoryRoute() => subcategory;
  static String getCategoryRoute() => category;
  static String getBookingRoute() => booking;
  static String getFilterRoute() => filter;
  static String getCheckoutRoute() => checkout;
  static String getAddReviewRoute() => addReview;
  static String getFavoriteRoute() => favorite;
  static String getNotificationRoute() => notification;
  static String getPopularRoute() => popular;
  static String getPopularProductRoute() => popularProduct;
  static String getAccountRoute() => account;
  static String getChooseLocationRoute() => chooseLocation;
  static String getFindLocationRoute() => findLocation;
  static String getInboxRoute() => inbox;
  static String getChatRoute() => chat;
  static String getTrackBookingRoute() => trackBooking;
  static String getAddressRoute() => address;
  static String getWalletRoute() => wallet;
  static String getReferRoute() => refer;
  static String getLanguageRoute() => language;
  static String getContactUsRoute() => contactus;
  static String getAppointmentDetailRoute() => appointmentDetail;
  static String getProductCategoryRoute() => productCategory;
  static String getProductDetailRoute() => productDetail;
  static String getProductListingRoute() => productListing;
  static String getProductCheckoutRoute() => productCheckout;
  static String getServiceDetailRoute() => serviceDetail;
  static String getAddAddressRoute() => addAddress;
  static String getAddressListRoute() => addressList;
  static String getcouponRoute() => coupons;
  static String getNewCardRoutes() => addNewCard;
  static String getStripePayRoutes() => stripePayRoutes;
  static String getWebPayment() => webPaymentsRoutes;
  static String getWebPaymentProduct() => webPaymentsProductRoutes;
  static String getProductHistoryRoute() => productHistory;
  static String getProductOrderDetailRoute() => productOrderDetail;
  static String getFreelancerProductRoute() => freelancerProduct;
  static String getAddProductReviewRoute() => addProductReview;
  static String getSingleProductReviewRoute() => singleProductReview;
  static String getEditProfileRoute() => editProfile;
  static String getSearchRoute() => search;
  static String getAppPageRoute() => appPage;
  static String getFirebaseAuthRoutes() => firebaseAuth;
  static String getTopFreelancerRoutes() => topFreelancers;
  static String getTopProductsRoutes() => topProducts;
  static String getComplaintsRoutes() => complaintsRoutes;

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
        name: register,
        page: () => const RegisterScreen(),
        binding: RegisterBindings()),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
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
      name: services,
      page: () => const ServicesScreen(),
      binding: ServicesBindings(),
    ),
    GetPage(
      name: handymanProfile,
      page: () => const HandymanProfileScreen(),
      binding: HandymanProfileBindings(),
    ),
    GetPage(
      name: history,
      page: () => const HistoryScreen(),
      binding: HistoryBindings(),
    ),
    GetPage(
      name: subcategory,
      page: () => const SubcategoryScreen(),
      binding: SubcategoryBindings(),
    ),
    GetPage(
      name: category,
      page: () => const CategoryScreen(),
      binding: CategoryBindings(),
    ),
    GetPage(
      name: booking,
      page: () => const BookingScreen(),
      binding: BookingBindings(),
    ),
    GetPage(
      name: account,
      page: () => const AccountScreen(),
      binding: AccountBindings(),
    ),
    GetPage(
        name: chooseLocation,
        page: () => const ChooseLocationScreen(),
        binding: ChooseLocationBindings(),
        fullscreenDialog: true),
    GetPage(
        name: findLocation,
        page: () => const FindLocationScreen(),
        binding: FindLocationBindings(),
        fullscreenDialog: true),
    GetPage(
      name: filter,
      page: () => const FilterScreen(),
      binding: FilterBindings(),
    ),
    GetPage(
      name: checkout,
      page: () => const CheckoutScreen(),
      binding: CheckoutBindings(),
    ),
    GetPage(
      name: addReview,
      page: () => const AddReviewScreen(),
      binding: AddReviewBindings(),
    ),
    GetPage(
      name: favorite,
      page: () => const FavoriteScreen(),
      binding: FavoriteBindings(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: popular,
      page: () => const PopularScreen(),
      binding: PopularBindings(),
    ),
    GetPage(
      name: popularProduct,
      page: () => const PopularProductScreen(),
      binding: PopularProductBindings(),
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
      name: trackBooking,
      page: () => const TrackBookingScreen(),
      binding: TrackBookingBindings(),
    ),
    GetPage(
      name: address,
      page: () => const AddressScreen(),
      binding: AddressBindings(),
    ),
    GetPage(
      name: wallet,
      page: () => const WalletScreen(),
      binding: WalletBindings(),
    ),
    GetPage(
      name: refer,
      page: () => const ReferScreen(),
      binding: ReferBindings(),
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBindings(),
    ),
    GetPage(
      name: contactus,
      page: () => const ContactUsScreen(),
      binding: ContactusBindings(),
    ),
    GetPage(
      name: appointmentDetail,
      page: () => const AppointmentDetailScreen(),
      binding: AppointmentDetailBindings(),
    ),
    GetPage(
      name: productCategory,
      page: () => const ProductCategoryScreen(),
      binding: ProductCategoryBindings(),
    ),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBindings(),
    ),
    GetPage(
      name: productListing,
      page: () => const ProductListingScreen(),
      binding: ProductListingBindings(),
    ),
    GetPage(
      name: productCheckout,
      page: () => const ProductCheckoutScreen(),
      binding: ProductCheckoutBindings(),
    ),
    GetPage(
      name: serviceDetail,
      page: () => const ServiceDetailScreen(),
      binding: ServiceDetailBindings(),
    ),
    GetPage(
      name: addAddress,
      page: () => const AddAddressScreen(),
      binding: AddAddressBindings(),
    ),
    GetPage(
      name: addressList,
      page: () => const AddressListScreen(),
      binding: AddressListBindings(),
    ),
    GetPage(
        name: coupons,
        page: () => const CoupensScreen(),
        binding: CoupensBinding(),
        fullscreenDialog: true),
    GetPage(
      name: addNewCard,
      page: () => const AddCardScreen(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: stripePayRoutes,
      page: () => const StripePay(),
      binding: StripePayBinding(),
    ),
    GetPage(
      name: webPaymentsRoutes,
      page: () => const WebPayment(),
      binding: WebPaymentBinding(),
    ),
    GetPage(
      name: webPaymentsProductRoutes,
      page: () => const WebPaymentProduct(),
      binding: WebPaymentProductBinding(),
    ),
    GetPage(
      name: productHistory,
      page: () => const ProductHistoryScreen(),
      binding: ProductHistoryBindings(),
    ),
    GetPage(
      name: productOrderDetail,
      page: () => const ProductOrderDetailScreen(),
      binding: ProductOrderDetailBindings(),
    ),
    GetPage(
        name: freelancerProduct,
        page: () => const FreelancerProductScreen(),
        binding: FreelancerProductBindings(),
        fullscreenDialog: true),
    GetPage(
        name: addProductReview,
        page: () => const AddProductReviewScreen(),
        binding: AddProductReviewBindings(),
        fullscreenDialog: true),
    GetPage(
        name: singleProductReview,
        page: () => const SingleProductReviewScreen(),
        binding: SingleProductReviewBindings(),
        fullscreenDialog: true),
    GetPage(
        name: search,
        page: () => const SearchScreen(),
        binding: SearchBindings(),
        fullscreenDialog: true),
    GetPage(
        name: editProfile,
        page: () => const EditProfileScreen(),
        binding: EditProfileBindings(),
        fullscreenDialog: true),
    GetPage(
      name: appPage,
      page: () => const AppPageScreen(),
      binding: AppPageBindings(),
    ),
    GetPage(
        name: firebaseAuth,
        page: () => const FirebaseVerificationScreen(),
        binding: FirebaseBinding()),
    GetPage(
        name: topFreelancers,
        page: () => const TopFreelancerScreen(),
        binding: TopFreelancersBindings()),
    GetPage(
        name: topProducts,
        page: () => const TopProductScreen(),
        binding: TopProductsBindings()),
    GetPage(
        name: complaintsRoutes,
        page: () => const ComplaintScreen(),
        binding: ComplaintsBinding()),
  ];
}
