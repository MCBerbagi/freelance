/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class ProductReviewModel {
  int? id;
  String? name;
  int? freelacerId;
  String? notes;
  double? rating;
  int? uid;
  String? firstName;
  String? lastName;
  String? userCover;
  String? productCover;
  String? createdAt;

  ProductReviewModel(
      {this.id,
      this.name,
      this.freelacerId,
      this.notes,
      this.rating,
      this.uid,
      this.firstName,
      this.lastName,
      this.userCover,
      this.productCover,
      this.createdAt});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    freelacerId = int.parse(json['freelacer_id'].toString());
    notes = json['notes'];
    rating = double.parse(json['rating'].toString());
    uid = int.parse(json['uid'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    userCover = json['user_cover'];
    productCover = json['product_cover'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['freelacer_id'] = freelacerId;
    data['notes'] = notes;
    data['rating'] = rating;
    data['uid'] = uid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_cover'] = userCover;
    data['product_cover'] = productCover;
    data['created_at'] = createdAt;
    return data;
  }
}
