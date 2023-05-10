/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:handyman_freelancer/app/backend/model/address_model.dart';
import 'package:handyman_freelancer/app/backend/model/services_model.dart';
import 'package:jiffy/jiffy.dart';

class AppointmentsModel {
  int? id;
  int? uid;
  int? freelancerId;
  int? orderTo;
  // String? address;
  AddressModel? address;
  // String? items;
  List<ServicesModel>? items;
  int? couponId;
  String? coupon;
  double? discount;
  double? distanceCost;
  double? total;
  double? serviceTax;
  double? grandTotal;
  int? payMethod;
  String? paid;
  String? saveDate;
  String? slot;
  int? walletUsed;
  double? walletPrice;
  String? notes;
  String? extraField;
  int? status;
  UserInfo? userInfo;

  AppointmentsModel(
      {this.id,
      this.uid,
      this.freelancerId,
      this.orderTo,
      this.address,
      this.items,
      this.couponId,
      this.coupon,
      this.discount,
      this.distanceCost,
      this.total,
      this.serviceTax,
      this.grandTotal,
      this.payMethod,
      this.paid,
      this.saveDate,
      this.slot,
      this.walletUsed,
      this.walletPrice,
      this.notes,
      this.extraField,
      this.status,
      this.userInfo});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    freelancerId = int.parse(json['freelancer_id'].toString());
    orderTo = int.parse(json['order_to'].toString());
    // address = json['address'];
    // items = json['items'];
    address = json['address'] != null
        ? AddressModel.fromJson(jsonDecode(json['address']))
        : null;

    if (json['items'] != null && json['items'] != 'NA' && json['items'] != '') {
      items = <ServicesModel>[];
      var item = jsonDecode(json['items']);
      item.forEach((element) {
        items!.add(ServicesModel.fromJson(element));
      });
    }
    couponId = int.parse(json['coupon_id'].toString());
    coupon = json['coupon'];
    discount = double.parse(json['discount'].toString());
    total = double.parse(json['total'].toString());
    serviceTax = double.parse(json['serviceTax'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    payMethod = int.parse(json['pay_method'].toString());
    paid = json['paid'];
    // saveDate = json['save_date'];
    saveDate = Jiffy(json['save_date']).yMMMMd;

    slot = json['slot'];
    walletUsed = json['wallet_used'] != null && json['wallet_used'] != ''
        ? int.parse(json['wallet_used'].toString())
        : 0;
    walletPrice = json['wallet_price'] != null && json['wallet_price'] != ''
        ? double.parse(json['wallet_price'].toString())
        : 0;
    notes = json['notes'];
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    distanceCost = double.parse(json['distance_cost'].toString());
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['freelancer_id'] = freelancerId;
    data['order_to'] = orderTo;
    data['address'] = address;
    data['items'] = items;
    data['coupon_id'] = couponId;
    data['coupon'] = coupon;
    data['discount'] = discount;
    data['distance_cost'] = distanceCost;
    data['total'] = total;
    data['serviceTax'] = serviceTax;
    data['grand_total'] = grandTotal;
    data['pay_method'] = payMethod;
    data['paid'] = paid;
    data['save_date'] = saveDate;
    data['slot'] = slot;
    data['wallet_used'] = walletUsed;
    data['wallet_price'] = walletPrice;
    data['notes'] = notes;
    data['extra_field'] = extraField;
    data['status'] = status;
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
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
