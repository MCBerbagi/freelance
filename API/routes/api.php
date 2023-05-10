<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\v1\AuthController;
use App\Http\Controllers\v1\CitiesController;
use App\Http\Controllers\v1\CategoryController;
use App\Http\Controllers\v1\FreelancerController;
use App\Http\Controllers\v1\FreelancerServiceController;
use App\Http\Controllers\v1\BannersController;
use App\Http\Controllers\v1\ProductCategoryController;
use App\Http\Controllers\v1\ProductSubCategoryController;
use App\Http\Controllers\v1\ProductsController;
use App\Http\Controllers\v1\TimeslotController;
use App\Http\Controllers\v1\PaymentsController;
use App\Http\Controllers\v1\AddressController;
use App\Http\Controllers\v1\PaytmPayController;
use App\Http\Controllers\v1\SettingsController;
use App\Http\Controllers\v1\AppointmentsController;
use App\Http\Controllers\v1\OffersController;
use App\Http\Controllers\v1\ProductOrdersController;
use App\Http\Controllers\v1\FreelancerReviewsController;
use App\Http\Controllers\v1\ProductReviewsController;
use App\Http\Controllers\v1\PagesController;
use App\Http\Controllers\v1\ReferralController;
use App\Http\Controllers\v1\ReferralCodesController;
use App\Http\Controllers\v1\ChatRoomsController;
use App\Http\Controllers\v1\ConversionsController;
use App\Http\Controllers\v1\OtpController;
use App\Http\Controllers\v1\ContactsController;
use App\Http\Controllers\v1\FreelancerRequestController;
use App\Http\Controllers\v1\FavouritesController;
use App\Http\Controllers\v1\CommissionController;
use App\Http\Controllers\v1\ComplaintsController;
use App\Http\Controllers\v1\BlogsController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/', function () {
    return [
        'app' => 'HandyService Appointments API by initappz',
        'version' => '1.0.0',
    ];
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('/v1')->group(function () {
    Route::get('users/get_admin', [AuthController::class, 'get_admin']);
    Route::post('auth/login', [AuthController::class, 'login']);
    Route::post('auth/loginWithPhonePassword', [AuthController::class, 'loginWithPhonePassword']);
    Route::post('auth/verifyPhoneForFirebase', [AuthController::class, 'verifyPhoneForFirebase']);
    Route::post('otp/verifyPhone',[OtpController::class, 'verifyPhone'] );
    Route::post('auth/create_admin_account', [AuthController::class, 'create_admin_account']);
    Route::post('auth/loginWithMobileOtp', [AuthController::class, 'loginWithMobileOtp']);
    Route::post('auth/user_register', [AuthController::class, 'user_register']);
    Route::post('auth/adminLogin', [AuthController::class, 'adminLogin']);
    Route::post('uploadImage', [AuthController::class, 'uploadImage']);
    Route::post('auth/verifyEmailForReset', [AuthController::class, 'verifyEmailForReset']);
    Route::get('auth/firebaseauth', [AuthController::class, 'firebaseauth']);
    Route::group(['middleware' => ['jwt', 'jwt.auth']], function () {

        Route::post('auth/freelancer_logout', [AuthController::class, 'logout']);
        Route::post('auth/user_logout', [AuthController::class, 'logout']);
        Route::post('auth/store_logout', [AuthController::class, 'logout']);

        Route::post('profile/getByID', [AuthController::class,'getByID']);
        Route::post('profile/update', [AuthController::class,'update']);
        Route::post('profile/getMyWalletBalance', [AuthController::class,'getMyWalletBalance']);
        Route::post('profile/getMyWallet', [AuthController::class,'getMyWallet']);
        Route::get('users/admins', [AuthController::class, 'admins']);
        Route::post('profile/update', [AuthController::class, 'update']);
        Route::post('users/adminNewAdmin', [AuthController::class, 'adminNewAdmin']);
        Route::post('users/deleteUser', [AuthController::class, 'delete']);
        Route::get('users/getAllUsers', [AuthController::class, 'getAllUsers']);
        Route::post('users/userInfoAdmin', [AuthController::class, 'getInfo']);

        Route::post('notification/sendToAllUsers', [AuthController::class, 'sendToAllUsers']);
        Route::post('notification/sendToUsers', [AuthController::class, 'sendToUsers']);
        Route::post('notification/sendToStores', [AuthController::class, 'sendToStores']);
        Route::post('notification/sendNotification', [AuthController::class, 'sendNotification']);

        Route::post('users/sendMailToUsers', [AuthController::class, 'sendMailToUsers']);
        Route::post('users/sendMailToAll', [AuthController::class, 'sendMailToAll']);
        Route::post('users/sendMailToStores', [AuthController::class, 'sendMailToStores']);

        // ADMIN Routes
        Route::post('cities/importData', [CitiesController::class, 'importData']);
        Route::post('category/importData', [CategoryController::class, 'importData']);

        Route::get('settings/getById', [SettingsController::class, 'getById']);
        Route::post('setttings/update', [SettingsController::class, 'update']);
        Route::post('setttings/save', [SettingsController::class, 'save']);

        Route::get('contacts/getAll',[ContactsController::class, 'getAll'] );
        Route::post('contacts/update',[ContactsController::class, 'update'] );
        Route::post('mails/replyContactForm',[ContactsController::class, 'replyContactForm']);

        Route::get('freelancer_request/getAll',[FreelancerRequestController::class, 'getAll'] );
        Route::post('freelancer_request/destroy',[FreelancerRequestController::class, 'delete'] );

        Route::post('stats/getAppointmentsStats', [AppointmentsController::class, 'getAppointmentsStats']);
        Route::post('stats/getOrderStats', [ProductOrdersController::class, 'getOrderStats']);

        // Blogs Routes
        Route::get('blogs/getAll', [BlogsController::class, 'getAll']);
        Route::post('blogs/create', [BlogsController::class, 'save']);
        Route::post('blogs/update', [BlogsController::class, 'update']);
        Route::post('blogs/destroy', [BlogsController::class, 'delete']);
        Route::post('blogs/getById', [BlogsController::class, 'getById']);

        // Cities Routes
        Route::get('cities/getAll', [CitiesController::class, 'getAll']);
        Route::post('cities/create', [CitiesController::class, 'save']);
        Route::post('cities/update', [CitiesController::class, 'update']);
        Route::post('cities/destroy', [CitiesController::class, 'delete']);
        Route::post('cities/getById', [CitiesController::class, 'getById']);

        // Category Routes
        Route::get('category/getAll', [CategoryController::class, 'getAll']);
        Route::get('category/getStores', [CategoryController::class, 'getStores']);
        Route::post('category/create', [CategoryController::class, 'save']);
        Route::post('category/update', [CategoryController::class, 'update']);
        Route::post('category/destroy', [CategoryController::class, 'delete']);
        Route::post('category/getById', [CategoryController::class, 'getById']);
        Route::get('category/getActiveItem', [CategoryController::class, 'getActiveItem']);
        Route::post('category/updateStatus', [CategoryController::class, 'updateStatus']);

        // Freelancer Routes
        Route::post('auth/createFreelancerAccount', [AuthController::class, 'createFreelancerAccount']);
        Route::get('freelancer/getAll', [FreelancerController::class, 'getAll']);
        Route::post('freelancer/create', [FreelancerController::class, 'save']);
        Route::post('freelancer/update', [FreelancerController::class, 'update']);
        Route::post('freelancer/destroy', [FreelancerController::class, 'delete']);
        Route::post('freelancer/getById', [FreelancerController::class, 'getByUID']);
        Route::post('freelancer/updateInfo', [FreelancerController::class, 'updateInfo']);
        Route::post('freelancer/updateMyInfo', [FreelancerController::class, 'updateMyInfo']);
        Route::post('freelancer/getMyCategories', [FreelancerController::class, 'getMyCategories']);
        Route::get('freelancer/getAdminHome', [FreelancerController::class, 'getAdminHome']);
        Route::post('commission/save', [CommissionController::class, 'save']);


        // Freelancer Service Routes
        Route::get('freelancer_services/getAll', [FreelancerServiceController::class, 'getAll']);
        Route::post('freelancer_services/create', [FreelancerServiceController::class, 'save']);
        Route::post('freelancer_services/update', [FreelancerServiceController::class, 'update']);
        Route::post('freelancer_services/destroy', [FreelancerServiceController::class, 'delete']);
        Route::post('freelancer_services/getById', [FreelancerServiceController::class, 'getByUID']);
        Route::post('freelancer_services/getServiceById', [FreelancerServiceController::class, 'getServiceById']);
        Route::post('freelancer_services/getMyServices', [FreelancerServiceController::class, 'getMyServices']);

        // Banners Routes
        Route::post('banners/save',[BannersController::class, 'save'] );
        Route::post('banners/getById', [BannersController::class, 'getById']);
        Route::post('banners/getInfoById', [BannersController::class, 'getInfoById']);
        Route::get('banners/getAll', [BannersController::class, 'getAll']);
        Route::get('banners/getMoreData', [BannersController::class, 'getMoreData']);
        Route::post('banners/update', [BannersController::class, 'update']);
        Route::post('banners/destroy', [BannersController::class, 'delete']);

        // product categories Routes
        Route::post('product_categories/importData', [ProductCategoryController::class, 'importData']);
        Route::get('product_categories/getAll', [ProductCategoryController::class, 'getAll']);
        Route::get('product_categories/getActive', [ProductCategoryController::class, 'getActive']);
        Route::post('product_categories/create', [ProductCategoryController::class, 'save']);
        Route::post('product_categories/update', [ProductCategoryController::class, 'update']);
        Route::post('product_categories/destroy', [ProductCategoryController::class, 'delete']);
        Route::post('product_categories/getById', [ProductCategoryController::class, 'getById']);
        Route::post('product_categories/updateStatus', [ProductCategoryController::class, 'updateStatus']);

        // subCategory Routes
        Route::post('product_sub_categories/importData', [ProductSubCategoryController::class, 'importData']);
        Route::get('product_sub_categories/getAll', [ProductSubCategoryController::class, 'getAll']);
        Route::get('product_sub_categories/getStores', [ProductSubCategoryController::class, 'getStores']);
        Route::post('product_sub_categories/create', [ProductSubCategoryController::class, 'save']);
        Route::post('product_sub_categories/update', [ProductSubCategoryController::class, 'update']);
        Route::post('product_sub_categories/destroy', [ProductSubCategoryController::class, 'delete']);
        Route::post('product_sub_categories/getById', [ProductSubCategoryController::class, 'getById']);
        Route::post('product_sub_categories/updateStatus', [ProductSubCategoryController::class, 'updateStatus']);
        Route::post('product_sub_categories/getFromCateId', [ProductSubCategoryController::class, 'getFromCateId']);


        // Products Routes
        Route::get('products/getAll', [ProductsController::class, 'getAll']);
        Route::post('products/getWithFreelancers', [ProductsController::class, 'getWithFreelancers']);
        Route::post('products/create', [ProductsController::class, 'save']);
        Route::post('products/update', [ProductsController::class, 'update']);
        Route::post('products/destroy', [ProductsController::class, 'delete']);
        Route::post('products/getById', [ProductsController::class, 'getById']);
        Route::post('products/updateStatus', [ProductsController::class, 'updateStatus']);
        Route::post('products/updateOffers', [ProductsController::class, 'updateOffers']);
        Route::post('products/updateHome', [ProductsController::class, 'updateHome']);
        // ADMIN Routes

        // Timeslots Routes
        Route::get('timeslots/getAll', [TimeslotController::class, 'getAll']);
        Route::post('timeslots/create', [TimeslotController::class, 'save']);
        Route::post('timeslots/update', [TimeslotController::class, 'update']);
        Route::post('timeslots/destroy', [TimeslotController::class, 'delete']);
        Route::post('timeslots/getById', [TimeslotController::class, 'getById']);
        Route::post('timeslots/getByUid', [TimeslotController::class, 'getByUid']);


        // Admin Routes For Payments
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/getById', [PaymentsController::class, 'getById']);
        Route::post('payments/getPaymentInfo', [PaymentsController::class, 'getPaymentInfo']);
        Route::get('payments/getAll', [PaymentsController::class, 'getAll']);
        Route::post('payments/update', [PaymentsController::class, 'update']);
        Route::post('payments/delete', [PaymentsController::class, 'delete']);
        Route::post('payments/refundFlutterwave', [PaymentsController::class, 'refundFlutterwave']);
        Route::post('payments/payPalRefund', [PaymentsController::class, 'payPalRefund']);
        Route::post('payments/refundPayStack',[PaymentsController::class, 'refundPayStack']);
        Route::post('payments/razorPayRefund',[PaymentsController::class, 'razorPayRefund']);
        Route::post('payments/refundStripePayments',[PaymentsController::class, 'refundStripePayments']);
        Route::post('payments/instaMOJORefund',[PaymentsController::class, 'instaMOJORefund']);

        // Payments Routes For Users
        Route::post('payments/createStripeToken', [PaymentsController::class, 'createStripeToken']);
        Route::post('payments/createCustomer', [PaymentsController::class, 'createCustomer']);
        Route::post('payments/getStripeCards', [PaymentsController::class, 'getStripeCards']);
        Route::post('payments/addStripeCards', [PaymentsController::class, 'addStripeCards']);
        Route::post('payments/createStripePayments', [PaymentsController::class, 'createStripePayments']);
        Route::get('getPayPalKey', [PaymentsController::class, 'getPayPalKey']);
        Route::get('getFlutterwaveKey', [PaymentsController::class, 'getFlutterwaveKey']);
        Route::get('getPaystackKey', [PaymentsController::class, 'getPaystackKey']);
        Route::get('getRazorPayKey', [PaymentsController::class, 'getRazorPayKey']);
        Route::get('payments/getPayments', [PaymentsController::class, 'getPayments']);


        // address Routes
        Route::post('address/save',[AddressController::class, 'save'] );
        Route::post('address/getById', [AddressController::class, 'getById']);
        Route::post('address/getByUID', [AddressController::class, 'getByUID']);
        Route::get('address/getAll', [AddressController::class, 'getAll']);
        Route::post('address/update', [AddressController::class, 'update']);
        Route::post('address/delete', [AddressController::class, 'delete']);


        // freelancer_reviews Routes
        Route::post('freelancer_reviews/save',[FreelancerReviewsController::class, 'save'] );
        Route::post('freelancer_reviews/getById', [FreelancerReviewsController::class, 'getById']);
        Route::post('freelancer_reviews/getByUID', [FreelancerReviewsController::class, 'getByUID']);
        Route::get('freelancer_reviews/getAll', [FreelancerReviewsController::class, 'getAll']);
        Route::post('freelancer_reviews/update', [FreelancerReviewsController::class, 'update']);
        Route::post('freelancer_reviews/delete', [FreelancerReviewsController::class, 'delete']);
        Route::post('freelancer_reviews/getFreelancerReviews', [FreelancerReviewsController::class, 'getFreelancerReviews']);

        // product_reviews Routes
        Route::post('product_reviews/save',[ProductReviewsController::class, 'save'] );
        Route::post('product_reviews/getById', [ProductReviewsController::class, 'getById']);
        Route::post('product_reviews/getByUID', [ProductReviewsController::class, 'getByUID']);
        Route::get('product_reviews/getAll', [ProductReviewsController::class, 'getAll']);
        Route::post('product_reviews/update', [ProductReviewsController::class, 'update']);
        Route::post('product_reviews/delete', [ProductReviewsController::class, 'delete']);
        Route::post('product_reviews/getProductReviews', [ProductReviewsController::class, 'getProductReviews']);


        // Appoinments Routes
        Route::post('appointments/save',[AppointmentsController::class, 'save'] );
        Route::post('appointments/getById', [AppointmentsController::class, 'getById']);
        Route::post('appointments/getByUID', [AppointmentsController::class, 'getByUID']);
        Route::get('appointments/getAll', [AppointmentsController::class, 'getAll']);
        Route::post('appointments/update', [AppointmentsController::class, 'update']);
        Route::post('appointments/updateStatusAdmin', [AppointmentsController::class, 'update']);
        Route::post('appointments/delete', [AppointmentsController::class, 'delete']);
        Route::post('appointments/getByFreelancers', [AppointmentsController::class, 'getByFreelancers']);
        Route::post('appointments/getDetails', [AppointmentsController::class, 'getDetails']);
        Route::post('appointments/getStats',[AppointmentsController::class, 'getStats'] );
        Route::post('appointments/getMonthsStats',[AppointmentsController::class, 'getMonthsStats']);
        Route::post('appointments/getAllStats',[AppointmentsController::class, 'getAllStats']);
        Route::post('appointments/getDetailAdmin',[AppointmentsController::class, 'getDetailAdmin']);


        // Offers Routes //

        Route::get('offers/getAll', [OffersController::class, 'getAll']);
        Route::get('offers/getStores', [OffersController::class, 'getStores']);
        Route::post('offers/create', [OffersController::class, 'save']);
        Route::post('offers/update', [OffersController::class, 'update']);
        Route::post('offers/destroy', [OffersController::class, 'delete']);
        Route::post('offers/getById', [OffersController::class, 'getById']);
        Route::post('offers/updateStatus', [OffersController::class, 'updateStatus']);

        // ProductsOrder Routes
        Route::post('product_order/save',[ProductOrdersController::class, 'save'] );
        Route::post('product_order/getById', [ProductOrdersController::class, 'getById']);
        Route::post('product_order/getDetailAdmin', [ProductOrdersController::class, 'getDetailAdmin']);
        Route::post('product_order/update', [ProductOrdersController::class, 'update']);
        Route::post('product_order/updateAdmin', [ProductOrdersController::class, 'update']);
        Route::post('product_order/delete', [ProductOrdersController::class, 'delete']);
        Route::post('product_order/getByUID', [ProductOrdersController::class, 'getByUID']);
        Route::post('product_order/getFreelancerOrder', [ProductOrdersController::class, 'getFreelancerOrder']);
        Route::post('product_order/getOrderDetailsFromFreelancer', [ProductOrdersController::class, 'getOrderDetailsFromFreelancer']);
        Route::post('product_order/getStats',[ProductOrdersController::class, 'getStats'] );
        Route::post('product_order/getMonthsStats',[ProductOrdersController::class, 'getMonthsStats']);
        Route::post('product_order/getAllStats',[ProductOrdersController::class, 'getAllStats']);
        Route::get('product_order/getAll',[ProductOrdersController::class, 'getAll']);


        Route::post('freelancers/getMyReviews', [FreelancerReviewsController::class, 'getMyReviews']);
        Route::post('freelancers/getMyProductReviews', [ProductReviewsController::class, 'getMyProductReviews']);

        // Pages Routes
        Route::post('pages/getById', [PagesController::class, 'getById']);
        Route::get('pages/getAll', [PagesController::class, 'getAllPages']);
        Route::post('pages/update', [PagesController::class, 'update']);

        Route::get('referral/getAll', [ReferralController::class, 'getAll']);
        Route::post('referral/save', [ReferralController::class, 'save']);
        Route::post('referral/update', [ReferralController::class, 'update']);

        Route::post('referral/redeemReferral', [ReferralController::class, 'redeemReferral']);
        Route::post('referralcode/getMyCode', [ReferralCodesController::class, 'getMyCode']);

        Route::post('chats/getChatRooms', [ChatRoomsController::class, 'getChatRooms']);
        Route::post('chats/createChatRooms', [ChatRoomsController::class, 'createChatRooms']);
        Route::post('chats/getChatListBUid', [ChatRoomsController::class, 'getChatListBUid']);
        Route::post('chats/getById', [ConversionsController::class, 'getById']);
        Route::post('chats/sendMessage', [ConversionsController::class, 'save']);

        Route::post('password/updateUserPasswordWithEmail', [AuthController::class, 'updateUserPasswordWithEmail']);

        Route::post('favourite/inMyList', [FavouritesController::class, 'inMyList']);
        Route::post('favourite/save', [FavouritesController::class, 'save']);
        Route::post('favourite/delete', [FavouritesController::class, 'delete']);

        Route::post('user/getMyFavList', [FreelancerController::class, 'getMyFavList']);

        // Complaints Routes
        Route::get('complaints/getAll',[ComplaintsController::class, 'getAll'] );
        Route::post('complaints/update',[ComplaintsController::class, 'update'] );
        Route::post('complaints/replyContactForm',[ComplaintsController::class, 'replyContactForm']);
        Route::post('complaints/registerNewComplaints', [ComplaintsController::class, 'save']);
    });


    Route::post('freelancer/getHomeData', [FreelancerController::class, 'getHomeData']);
    Route::post('freelancer/getByUID', [FreelancerController::class, 'getByUID']);
    Route::post('freelancer_services/getFreelancerServices', [FreelancerServiceController::class, 'getMyServices']);
    Route::post('freelancer_services/getInfo', [FreelancerServiceController::class, 'getServiceById']);
    Route::post('user/getFreelancerFromCategory', [FreelancerController::class, 'getFreelancerFromCategory']);
    Route::get('category/getCategories', [CategoryController::class, 'getActiveItem']);
    Route::post('timeslots/getSlotsByForBookings', [TimeslotController::class, 'getSlotsByForBookings']);


    Route::get('success_payments',[PaymentsController::class, 'success_payments']);
    Route::get('failed_payments',[PaymentsController::class, 'failed_payments']);
    Route::get('instaMOJOWebSuccess',[PaymentsController::class, 'instaMOJOWebSuccess']);
    Route::get('payments/payPalPay', [PaymentsController::class, 'payPalPay']);
    Route::get('payments/razorPay', [PaymentsController::class, 'razorPay']);
    Route::get('payments/VerifyRazorPurchase', [PaymentsController::class, 'VerifyRazorPurchase']);
    Route::post('payments/capureRazorPay', [PaymentsController::class, 'capureRazorPay']);
    Route::post('payments/instamojoPay', [PaymentsController::class, 'instamojoPay']);
    Route::get('payments/flutterwavePay', [PaymentsController::class, 'flutterwavePay']);
    Route::get('payments/paystackPay', [PaymentsController::class, 'paystackPay']);
    Route::get('payments/payKunPay', [PaymentsController::class, 'payKunPay']);

    // Payments Routes For User Public
    Route::get('payNow',[PaytmPayController::class, 'payNow']);
    Route::get('payNowWeb',[PaytmPayController::class, 'payNowWeb']);
    Route::get('payProductWeb',[PaytmPayController::class, 'payProductWeb']);
    Route::post('paytm-callback',[PaytmPayController::class, 'paytmCallback']);
    Route::post('paytm-webCallback',[PaytmPayController::class, 'webCallback']);
    Route::post('paytm-webCallbackProduct',[PaytmPayController::class, 'webCallbackProduct']);
    Route::get('refundUserRequest',[PaytmPayController::class, 'refundUserRequest']);


    Route::get('settings/getDefault', [SettingsController::class, 'getDefault']);
    Route::get('offers/getActive', [OffersController::class, 'getActive']);
    Route::get('product_categories/for_user', [ProductCategoryController::class, 'getActive']);
    Route::post('product_sub_categories/getbycate', [ProductSubCategoryController::class, 'getFromCateId']);
    Route::post('products/getByCateAndSubCate', [ProductsController::class, 'getByCateAndSubCate']);
    Route::post('products/getProductInfo', [ProductsController::class, 'getById']);
    Route::post('products/getFreelancerProducts', [ProductsController::class, 'getFreelancerProducts']);
    Route::post('freelancer_reviews/getMyReviews', [FreelancerReviewsController::class, 'getMyReviews']);
    Route::post('product_reviews/getMyReviews', [ProductReviewsController::class, 'getMyReviews']);

    Route::post('pages/getContent', [PagesController::class, 'getById']);
    Route::post('otp/verifyOTPReset',[OtpController::class, 'verifyOTPReset'] );

    Route::post('contacts/create',[ContactsController::class, 'save'] );
    Route::post('sendMailToAdmin',[ContactsController::class, 'sendMailToAdmin']);
    Route::get('cities/getHome', [CitiesController::class, 'getActiveCities']);
    Route::get('category/getHome', [CategoryController::class, 'getActiveItem']);

    Route::post('auth/verifyEmail', [AuthController::class, 'verifyEmail']);
    Route::post('auth/verifyPhone', [AuthController::class, 'verifyPhone']);
    Route::post('auth/checkPhoneExist', [AuthController::class, 'checkPhoneExist']);
    Route::get('success_verified',[AuthController::class, 'success_verified']);
    Route::post('otp/verifyOTP',[OtpController::class, 'verifyOTP'] );
    Route::post('freelancer_request/save',[FreelancerRequestController::class, 'save'] );
    Route::post('searchQuery', [FreelancerController::class, 'searchQuery']);
    Route::post('topFreelancers', [FreelancerController::class, 'topFreelancers']);
    Route::post('products/topProducts', [ProductsController::class, 'topProducts']);

    Route::post('sendVerificationOnMail', [AuthController::class, 'sendVerificationOnMail']);
    Route::post('auth/verifyPhoneForFirebaseRegistrations', [AuthController::class, 'verifyPhoneForFirebaseRegistrations']);
    Route::post('verifyPhoneSignup', [AuthController::class, 'verifyPhoneSignup']);

    Route::get('appointments/printInvoice', [AppointmentsController::class, 'printInvoice']);
    Route::get('appointments/orderInvoice', [AppointmentsController::class, 'orderInvoice']);

    Route::get('product_order/printInvoice', [ProductOrdersController::class, 'printInvoice']);
    Route::get('product_order/orderInvoice', [ProductOrdersController::class, 'orderInvoice']);

    Route::get('blogs/getTop', [BlogsController::class, 'getTop']);
    Route::get('blogs/getPublic', [BlogsController::class, 'getPublic']);
    Route::post('blogs/getDetails', [BlogsController::class, 'getById']);
});
