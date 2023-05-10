/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:handyman_freelancer/app/backend/model/language_model.dart';
import 'package:handyman_freelancer/app/env.dart';

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
  static const String defaultSMSGateway = '2';

  // API Routes
  static const String appSettings = 'api/v1/settings/getDefault';
  static const String login = 'api/v1/auth/login';
  static const String loginWithPhonePassword =
      'api/v1/auth/loginWithPhonePassword';
  static const String verifyPhoneFirebase =
      'api/v1/auth/verifyPhoneForFirebase';
  static const String register = 'api/v1/auth/';
  static const String getCategories = 'api/v1/freelancer/getMyCategories';
  static const String uploadImage = 'api/v1/uploadImage';
  static const String serviceCreate = 'api/v1/freelancer_services/create';
  static const String getMyServices =
      'api/v1/freelancer_services/getMyServices';
  static const String getServiceByID =
      'api/v1/freelancer_services/getServiceById';
  static const String updateService = 'api/v1/freelancer_services/update';
  static const String deleteService = 'api/v1/freelancer_services/destroy';
  static const String getUserByID = 'api/v1/freelancer/getById';
  static const String updateInfo = 'api/v1/freelancer/updateInfo';
  static const String updateFreelancerInfo = 'api/v1/freelancer/updateMyInfo';
  static const String getAllServedCategory = 'api/v1/category/getAll';
  static const String getAllCity = 'api/v1/cities/getAll';
  static const String productCreate = 'api/v1/products/create';
  static const String getMyProducts = 'api/v1/products/getWithFreelancers';
  static const String getProductByID = 'api/v1/products/getById';
  static const String updateProduct = 'api/v1/products/update';
  static const String updateStatusOfProduct = 'api/v1/products/updateStatus';
  static const String deleteProduct = 'api/v1/products/destroy';
  static const String getMyProductCategory =
      'api/v1/product_categories/getActive';
  static const String getMyProductSubCategory =
      'api/v1/product_sub_categories/getFromCateId';
  static const String slotCreate = 'api/v1/timeslots/create';
  static const String getSlotById = 'api/v1/timeslots/getByUid';
  static const String slotUpdate = 'api/v1/timeslots/update';
  static const String slotDelete = 'api/v1/timeslots/delete';
  static const String slotById = 'api/v1/timeslots/getById';
  static const String getAppointmentsByFreelancerId =
      'api/v1/appointments/getByFreelancers';
  static const String getAppointmentDetails = 'api/v1/appointments/getDetails';
  static const String updateAppointmentStatus = 'api/v1/appointments/update';
  static const String getMyProductOrders =
      'api/v1/product_order/getFreelancerOrder';
  static const String getOrderById =
      'api/v1/product_order/getOrderDetailsFromFreelancer';
  static const String updateProductOrderStatus = 'api/v1/product_order/update';
  static const String getMyReviews = 'api/v1/freelancers/getMyReviews';
  static const String getMyProductReviews =
      'api/v1/freelancers/getMyProductReviews';
  static const String getChatRooms = 'api/v1/chats/getChatRooms';
  static const String createChatRooms = 'api/v1/chats/createChatRooms';
  static const String getChatList = 'api/v1/chats/getById';
  static const String sendMessage = 'api/v1/chats/sendMessage';
  static const String getChatConversionList = 'api/v1/chats/getChatListBUid';
  static const String pageContent = 'api/v1/pages/getContent';
  static const String resetWithEmail = 'api/v1/auth/verifyEmailForReset';
  static const String verifyOTPForReset = 'api/v1/otp/verifyOTPReset';
  static const String verifyOTPEmail = 'api/v1/otp/verifyOTP';
  static const String updatePasswordWithToken =
      'api/v1/password/updateUserPasswordWithEmail';
  static const String saveaContacts = 'api/v1/contacts/create';
  static const String sendMailToAdmin = 'api/v1/sendMailToAdmin';
  static const String getStats = 'api/v1/appointments/getStats';
  static const String getMonthsStats = 'api/v1/appointments/getMonthsStats';
  static const String getAllStats = 'api/v1/appointments/getAllStats';

  static const String getStatsProducts = 'api/v1/product_order/getStats';
  static const String getMonthsStatsProducts =
      'api/v1/product_order/getMonthsStats';
  static const String getAllStatsProducts = 'api/v1/product_order/getAllStats';
  static const String getHomeCities = 'api/v1/cities/getHome';
  static const String getHomeCategories = 'api/v1/category/getHome';
  static const String verifyEmail = 'api/v1/auth/verifyEmail';
  static const String checkPhoneExist = 'api/v1/auth/checkPhoneExist';
  static const String openFirebaseVerification = 'api/v1/auth/firebaseauth?';
  static const String verifyPhoneRegister = 'api/v1/auth/verifyPhone';
  static const String verifyPhoneLogin = 'api/v1/otp/verifyPhone';
  static const String saveMyRequest = 'api/v1/freelancer_request/save';
  static const String verifyOTP = 'api/v1/otp/verifyOTP';
  static const String loginWithMobileToken = 'api/v1/auth/loginWithMobileOtp';
  static const String getAppointmentInvoice =
      'api/v1/appointments/orderInvoice?id=';
  static const String getProductOrderInvoice =
      'api/v1/product_order/orderInvoice?id=';
  static const String updateFCM = 'api/v1/profile/update';
  static const String sendNotification = 'api/v1/notification/sendNotification';
  static const String logout = 'api/v1/auth/freelancer_logout';

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

  // API Routes
}
