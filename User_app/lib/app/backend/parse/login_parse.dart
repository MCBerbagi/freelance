/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/api.dart';
import 'package:handyman/app/helper/shared_pref.dart';
import 'package:handyman/app/util/constant.dart';

class LoginParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onLogin(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.login, body);
    return response;
  }

  Future<Response> loginWithPhonePasswordPost(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.loginWithPhonePassword, param);
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

  int userLogin() {
    return sharedPreferencesManager.getInt('userLogin') ??
        AppConstants.userLogin;
  }

  String smsName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  Future<Response> verifyPhoneWithFirebase(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyPhoneFirebase, param);
  }

  Future<Response> verifyPhone(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyPhone, param);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTP, param);
  }

  Future<Response> loginWithPhoneToken(dynamic param) async {
    return await apiService.postPublic(
        AppConstants.loginWithMobileToken, param);
  }

  Future<Response> updateProfile(var body, var token) async {
    var response =
        await apiService.postPrivate(AppConstants.updateFCM, body, token);
    return response;
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }
}
