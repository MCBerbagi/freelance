/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:handyman/app/backend/model/language_model.dart';
import 'package:handyman/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String defaultCurrencyCode =
      'USD'; // your currency code in 3 digit
  static const String defaultCurrencySide =
      'right'; // default currency position
  static const String defaultCurrencySymbol = '\$'; // default currency symbol
  static const int defaultShippingMethod = 0;
  static const double defaultDeliverRadius = 50;
  static const String defaultLanguageApp = 'en';
  static const int userLogin = 0;
  static const String defaultSMSGateway = '1'; // 2 = firebase // 1 = rest
  static const int defaultVerificationForSignup = 0; // 0 = email // 1= phone

  // API Routes
  static const String appSettings = 'api/v1/settings/getDefault';
  static const String login = 'api/v1/auth/login';
  static const String loginWithPhonePassword =
      'api/v1/auth/loginWithPhonePassword';
  static const String verifyPhoneFirebase =
      'api/v1/auth/verifyPhoneForFirebase';
  static const String verifyPhone = 'api/v1/otp/verifyPhone';
  static const String loginWithMobileToken = 'api/v1/auth/loginWithMobileOtp';
  static const String register = 'api/v1/auth/user_register';
  static const String referralCode = 'api/v1/referral/redeemReferral';
  static const String getWalletAmounts = 'api/v1/profile/getMyWallet';
  static const String getHomeData = 'api/v1/freelancer/getHomeData';
  static const String getAllCategories = 'api/v1/category/getCategories';
  static const String getFreelancerFromCategory =
      'api/v1/user/getFreelancerFromCategory';
  static const String getFreelancerByID = 'api/v1/freelancer/getByUID';
  static const String getFreelancerServices =
      'api/v1/freelancer_services/getFreelancerServices';
  static const String getServicesDetail = 'api/v1/freelancer_services/getInfo';
  static const String getFreelancerProducts =
      'api/v1/products/getFreelancerProducts';
  static const String getUserByID = 'api/v1/profile/getByID';
  static const String updateInfo = 'api/v1/profile/update';
  static const String updateFCM = 'api/v1/profile/update';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String getAllFreelancerReviews =
      'api/v1/freelancer_reviews/getMyReviews';
  static const String getAllProductReviews =
      'api/v1/product_reviews/getMyReviews';
  static const String getSlotsForBookings =
      'api/v1/timeslots/getSlotsByForBookings';
  static const String getPayments = 'api/v1/payments/getPayments';
  static const String getMyAppointments = 'api/v1/appointments/getByUID';
  static const String getAppointmentById = 'api/v1/appointments/getById';
  static const String updateAppointmentStatus = 'api/v1/appointments/update';
  static const String getMyProductOrders = 'api/v1/product_order/getByUID';
  static const String getOrderById = 'api/v1/product_order/getById';
  static const String updateProductOrderStatus = 'api/v1/product_order/update';
  static const String getAllProductCategories =
      'api/v1/product_categories/for_user';
  static const String productSubCategorybyCate =
      'api/v1/product_sub_categories/getbycate';
  static const String getProductByCateandSubCate =
      'api/v1/products/getByCateAndSubCate';
  static const String getProductInfo = 'api/v1/products/getProductInfo';
  static const String getFreelancerReviews =
      'api/v1/freelancer_reviews/getFreelancerReviews';
  static const String getProductReviews =
      'api/v1/product_reviews/getProductReviews';
  static const String topFreelancer = 'api/v1/topFreelancers';
  static const String topProducts = 'api/v1/products/topProducts';
  static const String saveFreelancerReviews = 'api/v1/freelancer_reviews/save';
  static const String updateFreelancerInfo = 'api/v1/freelancer/updateMyInfo';
  static const String saveProductReviews = 'api/v1/product_reviews/save';
  static const String updateProductInfo = 'api/v1/products/update';
  static const String saveAddress = 'api/v1/address/save';
  static const String getSavedAddress = 'api/v1/address/getByUID';
  static const String addressById = 'api/v1/address/getById';
  static const String updateAddress = 'api/v1/address/update';
  static const String deleteAddress = 'api/v1/address/delete';
  static const String getUserProfile = 'api/v1/profile/getByID';
  static const String updateProfile = 'api/v1/profile/update';
  static const String createStripeToken = 'api/v1/payments/createStripeToken';
  static const String createStripeCustomer = 'api/v1/payments/createCustomer';
  static const String addStripeCard = 'api/v1/payments/addStripeCards';
  static const String getStripeCards = 'api/v1/payments/getStripeCards';
  static const String stripeCheckout = 'api/v1/payments/createStripePayments';
  static const String getActiveOffers = 'api/v1/offers/getActive';
  static const String getStoreInfo = 'api/v1/store/getStoreInfoByUid';
  static const String createOrder = 'api/v1/appointments/save';
  static const String payPalPayLink = 'api/v1/payments/payPalPay?amount=';
  static const String payTmPayLink = 'api/v1/payNow?amount=';
  static const String razorPayLink = 'api/v1/payments/razorPay?';
  static const String verifyRazorPayments =
      'api/v1/payments/VerifyRazorPurchase?id=';
  static const String payWithInstaMojo = 'api/v1/payments/instamojoPay';
  static const String paystackCheckout = 'api/v1/payments/paystackPay?';
  static const String flutterwaveCheckout = 'api/v1/payments/flutterwavePay?';
  static const String createProductOrdedr = 'api/v1/product_order/save';
  static const String getMyWalletBalance = 'api/v1/profile/getMyWalletBalance';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String searchQuery = 'api/v1/searchQuery';
  static const String myFavList = 'api/v1/favourite/inMyList';
  static const String addToFavList = 'api/v1/favourite/save';
  static const String removeFromFavList = 'api/v1/favourite/delete';
  static const String getMyFavList = 'api/v1/user/getMyFavList';
  static const String getMyReferralCode = 'api/v1/referralcode/getMyCode';
  static const String sendVerificationMail = 'api/v1/sendVerificationOnMail';
  static const String verifyOTP = 'api/v1/otp/verifyOTP';
  static const String openFirebaseVerification = 'api/v1/auth/firebaseauth?';
  static const String verifyMobileForeFirebase =
      'api/v1/auth/verifyPhoneForFirebaseRegistrations';
  static const String sendVerificationSMS = 'api/v1/verifyPhoneSignup';
  static const String registerComplaints =
      'api/v1/complaints/registerNewComplaints';
  static const String getAppointmentsInvoice =
      'api/v1/appointments/printInvoice?id=';
  static const String getProductInvoice =
      'api/v1/product_order/printInvoice?id=';
  static const String sendNotification = 'api/v1/notification/sendNotification';
  static const String logout = 'api/v1/auth/user_logout';
  // API Routes

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'عربي',
        countryCode: 'AE',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: '',
        languageName: 'हिन्दी',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Español',
        countryCode: 'De',
        languageCode: 'es'),
  ];
}
