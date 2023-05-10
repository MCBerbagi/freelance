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
import 'package:handyman/app/backend/model/services_model.dart';
import 'package:jiffy/jiffy.dart';

class AppointmentsModel {
  int? id;
  int? uid;
  int? freelancerId;
  int? orderTo;
  // String? address;
  AddressModel? address;
  List<ServiceModel>? items;
  int? couponId;
  String? coupon;
  double? discount;
  double? total;
  double? serviceTax;
  double? grandTotal;
  int? payMethod;
  String? paid;
  String? saveDate;
  double? distanceCost;
  String? slot;
  int? walletUsed;
  double? walletPrice;
  String? notes;
  String? extraField;
  int? status;
  Freelancer? freelancer;

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
      this.freelancer});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    freelancerId = int.parse(json['freelancer_id'].toString());
    orderTo = int.parse(json['order_to'].toString());
    address = json['address'] != null
        ? AddressModel.fromJson(jsonDecode(json['address']))
        : null;

    if (json['items'] != null && json['items'] != 'NA' && json['items'] != '') {
      items = <ServiceModel>[];
      var item = jsonDecode(json['items']);
      item.forEach((element) {
        items!.add(ServiceModel.fromJson(element));
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
    freelancer = json['freelancer'] != null
        ? Freelancer.fromJson(json['freelancer'])
        : null;
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
    if (freelancer != null) {
      data['freelancer'] = freelancer!.toJson();
    }
    return data;
  }
}

class Freelancer {
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
  String? email;
  String? mobile;

  Freelancer(
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
      this.status});

  Freelancer.fromJson(Map<String, dynamic> json) {
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
    verified = int.parse(json['verified'].toString());
    available = int.parse(json['available'].toString());
    haveShop = int.parse(json['have_shop'].toString());
    popular = int.parse(json['popular'].toString());
    inHome = int.parse(json['in_home'].toString());
    extraField = json['extra_field'];
    status = int.parse(json['status'].toString());
    email = json['email'];
    mobile = json['mobile'];
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
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}
