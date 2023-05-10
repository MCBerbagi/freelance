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
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:handyman/app/util/constant.dart';

class CheckoutParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CheckoutParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getFreelancerByID(var body) async {
    var response =
        await apiService.postPublic(AppConstants.getFreelancerByID, body);
    return response;
  }

  Future<Response> getPayments() async {
    var response = await apiService.getPrivate(AppConstants.getPayments,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getSavedAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.getSavedAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> createOrder(var body) async {
    var response = await apiService.postPrivate(AppConstants.createOrder, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> sendNotification(var body) async {
    var response = await apiService.postPrivate(AppConstants.sendNotification,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getInstaMojoPayLink(var param) async {
    return await apiService.postPrivate(AppConstants.payWithInstaMojo, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getMyWalletBalance() async {
    return await apiService.postPrivate(
        AppConstants.getMyWalletBalance,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  String getPhone() {
    return sharedPreferencesManager.getString('phone') ?? '';
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }

  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getAppLogo() {
    return sharedPreferencesManager.getString('appLogo') ?? '';
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }
}
