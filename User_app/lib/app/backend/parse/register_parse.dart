/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:handyman/app/util/constant.dart';

class RegisterParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onRegister(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.register, body);
    return response;
  }

  void saveToken(String token) {
    sharedPreferencesManager.putString('token', token);
  }

  void saveUID(String id) {
    sharedPreferencesManager.putString('uid', id);
  }

  void saveData(String cover, String firstName, String lastName, String mobile,
      String email) {
    debugPrint(firstName);
    debugPrint(lastName);
    debugPrint(mobile);
    debugPrint(email);

    sharedPreferencesManager.putString('cover', cover);
    sharedPreferencesManager.putString('first_name', firstName);
    sharedPreferencesManager.putString('last_name', lastName);
    sharedPreferencesManager.putString('phone', mobile);
    sharedPreferencesManager.putString('email', email);
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  int getVerificationMethod() {
    return sharedPreferencesManager.getInt('user_verify_with') ??
        AppConstants.defaultVerificationForSignup;
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  Future<Response> saveReferral(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.referralCode, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> sendVerificationMail(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.sendVerificationMail, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTP, param);
  }

  Future<Response> verifyMobileForeFirebase(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.verifyMobileForeFirebase, param);
  }

  Future<Response> sendRegisterOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.sendVerificationSMS, param);
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }
}
