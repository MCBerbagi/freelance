/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class ProductReivewModel {
  int? id;
  int? uid;
  String? productId;
  String? notes;
  int? rating;
  int? status;
  String? extraField;
  String? createdAt;
  User? user;

  ProductReivewModel(
      {this.id,
      this.uid,
      this.productId,
      this.notes,
      this.rating,
      this.status,
      this.extraField,
      this.createdAt,
      this.user});

  ProductReivewModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    productId = json['product_id'];
    notes = json['notes'];
    rating = int.parse(json['rating'].toString());
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['product_id'] = productId;
    data['notes'] = notes;
    data['rating'] = rating;
    data['status'] = status;
    data['extra_field'] = extraField;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? cover;
  String? firstName;
  String? lastName;

  User({this.id, this.cover, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    cover = json['cover'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
