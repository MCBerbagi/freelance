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
import 'package:handyman/app/backend/api/handler.dart';
import 'package:handyman/app/backend/model/search_result_model.dart';
import 'package:handyman/app/backend/parse/search_parse.dart';

class SearchController extends GetxController implements GetxService {
  final SearchParser parser;

  TextEditingController searchController = TextEditingController();
  RxBool isEmpty = true.obs;
  List<SearchResultModel> _result = <SearchResultModel>[];
  List<SearchResultModel> get result => _result;

  SearchController({required this.parser});

  searchProducts(String name) {
    if (name.isNotEmpty && name != '') {
      getSearchResult(name);
    } else {
      _result = [];
      isEmpty = true.obs;
      update();
    }
  }

  void getSearchResult(String query) async {
    var param = {
      "param": query,
      "lat": parser.getLat(),
      "lng": parser.getLng()
    };
    Response response = await parser.getSearchResult(param);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      dynamic body = myMap["data"];
      _result = [];
      isEmpty = false.obs;
      body.forEach((data) {
        SearchResultModel datas = SearchResultModel.fromJson(data);
        _result.add(datas);
      });
    } else {
      isEmpty = false.obs;
      ApiChecker.checkApi(response);
    }
    update();
  }

  void clearData() {
    searchController.clear();
    _result = [];
    isEmpty = true.obs;
    update();
  }
}
