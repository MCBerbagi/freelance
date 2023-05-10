/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:handyman_freelancer/app/backend/api/api.dart';
import 'package:handyman_freelancer/app/helper/shared_pref.dart';

class WelcomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  WelcomeParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveLanguage(String code) {
    sharedPreferencesManager.putString('language', code);
  }
}
