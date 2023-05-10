/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class FreelancerModel {
  int? id;
  int? uid;
  String? name;
  String? cover;
  String? servedCategory;
  String? lat;
  String? lng;
  double? hourlyPrice;
  String? gallery;
  String? descriptions;
  int? totalExperience;
  int? cid;
  String? zipcode;
  double? rating;
  int? totalRating;
  int? verified;
  int? available;
  int? haveShop;
  int? popular;
  int? inHome;
  String? extraField;
  int? status;
  List<WebCatesData>? webCatesData;
  CityData? cityData;
  UserInfo? userInfo;

  FreelancerModel(
      {this.id,
      this.uid,
      this.name,
      this.cover,
      this.servedCategory,
      this.lat,
      this.lng,
      this.hourlyPrice,
      this.gallery,
      this.descriptions,
      this.totalExperience,
      this.cid,
      this.zipcode,
      this.rating,
      this.totalRating,
      this.verified,
      this.available,
      this.haveShop,
      this.popular,
      this.inHome,
      this.extraField,
      this.status,
      this.webCatesData,
      this.cityData,
      this.userInfo});

  FreelancerModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    name = json['name'];
    cover = json['cover'];
    servedCategory = json['served_category'];
    lat = json['lat'];
    lng = json['lng'];
    hourlyPrice = double.parse(json['hourly_price'].toString());
    gallery = json['gallery'];
    descriptions = json['descriptions'];
    totalExperience = int.parse(json['total_experience'].toString());
    cid = int.parse(json['cid'].toString());
    zipcode = json['zipcode'];
    rating = double.parse(json['rating'].toString());
    totalRating = int.parse(json['total_rating'].toString());
    verified = json['verified'] != null && json['verified'] != ''
        ? int.parse(json['verified'].toString())
        : 0;
    available = json['available'] != null && json['available'] != ''
        ? int.parse(json['available'].toString())
        : 0;
    haveShop = json['have_shop'] != null && json['have_shop'] != ''
        ? int.parse(json['have_shop'].toString())
        : 0;

    popular = json['popular'] != null && json['popular'] != ''
        ? int.parse(json['popular'].toString())
        : 0;

    inHome = json['in_home'] != null && json['in_home'] != ''
        ? int.parse(json['in_home'].toString())
        : 0;
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    if (json['web_cates_data'] != null) {
      webCatesData = <WebCatesData>[];
      json['web_cates_data'].forEach((v) {
        webCatesData!.add(WebCatesData.fromJson(v));
      });
    }
    cityData =
        json['city_data'] != null ? CityData.fromJson(json['city_data']) : null;
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['cover'] = cover;
    data['served_category'] = servedCategory;
    data['lat'] = lat;
    data['lng'] = lng;
    data['hourly_price'] = hourlyPrice;
    data['gallery'] = gallery;
    data['descriptions'] = descriptions;
    data['total_experience'] = totalExperience;
    data['cid'] = cid;
    data['zipcode'] = zipcode;
    data['rating'] = rating;
    data['total_rating'] = totalRating;
    data['verified'] = verified;
    data['available'] = available;
    data['have_shop'] = haveShop;
    data['popular'] = popular;
    data['in_home'] = inHome;
    data['extra_field'] = extraField;
    data['status'] = status;
    if (webCatesData != null) {
      data['web_cates_data'] = webCatesData!.map((v) => v.toJson()).toList();
    }
    if (cityData != null) {
      data['city_data'] = cityData!.toJson();
    }
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class WebCatesData {
  int? id;
  String? name;
  String? cover;
  String? extraField;
  int? status;

  WebCatesData({this.id, this.name, this.cover, this.extraField, this.status});

  WebCatesData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    cover = json['cover'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}

class CityData {
  int? id;
  String? name;
  String? lat;
  String? lng;
  String? extraField;
  int? status;

  CityData(
      {this.id, this.name, this.lat, this.lng, this.extraField, this.status});

  CityData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    data['extra_field'] = extraField;
    data['status'] = status;
    return data;
  }
}

class UserInfo {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? cover;
  int? gender;
  String? type;
  String? fcmToken;
  String? stripeKey;
  String? extraField;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobile,
      this.cover,
      this.gender,
      this.type,
      this.fcmToken,
      this.stripeKey,
      this.extraField,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    cover = json['cover'];
    gender = int.parse(json['gender'].toString());
    type = json['type'];
    fcmToken = json['fcm_token'];
    stripeKey = json['stripe_key'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['cover'] = cover;
    data['gender'] = gender;
    data['type'] = type;
    data['fcm_token'] = fcmToken;
    data['stripe_key'] = stripeKey;
    data['extra_field'] = extraField;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
