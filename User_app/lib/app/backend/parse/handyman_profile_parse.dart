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

class HandymanProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HandymanProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getFreelancerByID(var body) async {
    var response =
        await apiService.postPublic(AppConstants.getFreelancerByID, body);
    return response;
  }

  Future<Response> getAllFreelancerReviews(var body) async {
    var response =
        await apiService.postPublic(AppConstants.getAllFreelancerReviews, body);
    return response;
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  bool isLoggedIn() {
    return sharedPreferencesManager.getString('uid') != null &&
            sharedPreferencesManager.getString('uid') != ''
        ? true
        : false;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> myFavList(var body) async {
    var response = await apiService.postPrivate(AppConstants.myFavList, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> addToFavourite(var body) async {
    var response = await apiService.postPrivate(AppConstants.addToFavList, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> removeFromFavList(var body) async {
    var response = await apiService.postPrivate(AppConstants.removeFromFavList,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
