/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:get/get.dart';
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/parse/app_page_parse.dart';

class AppPageController extends GetxController implements GetxService {
  final AppPageParser parser;
  String title = '';
  String pageId = '';
  String content = '';
  bool apiCalled = false;
  AppPageController({required this.parser});

  @override
  void onInit() async {
    super.onInit();
    var name = Get.arguments[0];
    var dbPageId = Get.arguments[1];
    title = name;
    pageId = dbPageId;
    update();
    getContent();
  }

  Future<void> getContent() async {
    Response response = await parser.getContentById(pageId);
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      if (body['content'] != '' && body['content'] != null) {
        content = body['content'];
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
  }
}
