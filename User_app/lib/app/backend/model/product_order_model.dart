/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'dart:convert';

import 'package:handyman/app/backend/model/address_model.dart';
import 'package:handyman/app/backend/model/product_model.dart';
import 'package:jiffy/jiffy.dart';

class ProductOrderModel {
  int? id;
  int? uid;
  String? freelancerId;
  String? dateTime;
  int? paidMethod;
  String? orderTo;
  List<ProductModel>? orders;
  String? notes;
  AddressModel? address;
  double? total;
  double? tax;
  double? grandTotal;
  double? discount;
  String? driverId;
  double? deliveryCharge;
  int? walletUsed;
  double? walletPrice;
  String? couponCode;
  String? extra;
  String? payKey;
  int? status;
  int? payStatus;
  String? extraField;
  FreelancerInfo? freelancerInfo;

  ProductOrderModel(
      {this.id,
      this.uid,
      this.freelancerId,
      this.dateTime,
      this.paidMethod,
      this.orderTo,
      this.orders,
      this.notes,
      this.address,
      this.total,
      this.tax,
      this.grandTotal,
      this.discount,
      this.driverId,
      this.deliveryCharge,
      this.walletUsed,
      this.walletPrice,
      this.couponCode,
      this.extra,
      this.payKey,
      this.status,
      this.payStatus,
      this.extraField,
      this.freelancerInfo});

  ProductOrderModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    freelancerId = json['freelancer_id'];
    dateTime = Jiffy(json['date_time']).yMMMMEEEEdjm;
    paidMethod = int.parse(json['paid_method'].toString());
    orderTo = json['order_to'];
    // orders = json['orders'];

    if (json['orders'] != null &&
        json['orders'] != 'NA' &&
        json['orders'] != '') {
      orders = <ProductModel>[];
      var order = jsonDecode(json['orders']);
      order.forEach((element) {
        orders!.add(ProductModel.fromJson(element));
      });
    }

    notes = json['notes'];
    // address = json['address'];
    address = json['address'] != null
        ? AddressModel.fromJson(jsonDecode(json['address']))
        : null;
    total = double.parse(json['total'].toString());
    tax = double.parse(json['tax'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    discount = double.parse(json['discount'].toString());
    driverId = json['driver_id'];
    deliveryCharge = double.parse(json['discount'].toString());
    walletUsed = json['wallet_used'] != null && json['wallet_used'] != ''
        ? int.parse(json['wallet_used'].toString())
        : 0;
    walletPrice = json['wallet_price'] != null && json['wallet_price'] != ''
        ? double.parse(json['wallet_price'].toString())
        : 0;

    couponCode = json['coupon_code'];
    extra = json['extra'];
    payKey = json['pay_key'];
    status = int.parse(json['status'].toString());
    payStatus = int.parse(json['payStatus'].toString());
    extraField = json['extra_field'];
    freelancerInfo = json['freelancerInfo'] != null
        ? FreelancerInfo.fromJson(json['freelancerInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['freelancer_id'] = freelancerId;
    data['date_time'] = dateTime;
    data['paid_method'] = paidMethod;
    data['order_to'] = orderTo;
    data['orders'] = orders;
    data['notes'] = notes;
    data['address'] = address;
    data['total'] = total;
    data['tax'] = tax;
    data['grand_total'] = grandTotal;
    data['discount'] = discount;
    data['driver_id'] = driverId;
    data['delivery_charge'] = deliveryCharge;
    data['wallet_used'] = walletUsed;
    data['wallet_price'] = walletPrice;
    data['coupon_code'] = couponCode;
    data['extra'] = extra;
    data['pay_key'] = payKey;
    data['status'] = status;
    data['payStatus'] = payStatus;
    data['extra_field'] = extraField;
    if (freelancerInfo != null) {
      data['freelancerInfo'] = freelancerInfo!.toJson();
    }
    return data;
  }
}

class FreelancerInfo {
  int? id;
  String? firstName;
  String? lastName;
  String? cover;
  String? mobile;
  String? email;

  FreelancerInfo({this.id, this.firstName, this.lastName, this.cover});

  FreelancerInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    cover = json['cover'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['cover'] = cover;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
