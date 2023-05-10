/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman_freelancer/app/backend/api/api.dart';
import 'package:handyman_freelancer/app/helper/shared_pref.dart';
import 'package:handyman_freelancer/app/util/constant.dart';
import 'package:image_picker/image_picker.dart';

class RegisterParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  RegisterParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onRegister(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.register, body);
    return response;
  }

  Future<Response> checkPhoneExist(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.checkPhoneExist, body);
    return response;
  }

  Future<Response> saveMyRequest(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.saveMyRequest, body);
    return response;
  }

  Future<Response> verifyEmail(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.verifyEmail, body);
    return response;
  }

  Future<Response> verifyPhone(dynamic body) async {
    var response =
        await apiService.postPublic(AppConstants.verifyPhoneRegister, body);
    return response;
  }

  Future<Response> getHomeCities() async {
    var response = await apiService.getPublic(AppConstants.getHomeCities);
    return response;
  }

  void saveToken(String token) {
    sharedPreferencesManager.putString('token', token);
  }

  void saveUID(String id) {
    sharedPreferencesManager.putString('uid', id);
  }

  String getSMSName() {
    return sharedPreferencesManager.getString('smsName') ??
        AppConstants.defaultSMSGateway;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> verifyOTP(dynamic param) async {
    return await apiService.postPublic(AppConstants.verifyOTPEmail, param);
  }

  String getFcmToken() {
    return sharedPreferencesManager.getString('fcm_token') ?? 'NA';
  }
}
