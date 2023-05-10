/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class PaymentModel {
  int? id;
  String? name;
  int? env;
  int? status;
  String? currencyCode;
  String? cover;
  String? extraField;

  PaymentModel(
      {this.id,
      this.name,
      this.env,
      this.status,
      this.currencyCode,
      this.cover,
      this.extraField});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    env = int.parse(json['env'].toString());
    status = int.parse(json['status'].toString());
    currencyCode = json['currency_code'];
    cover = json['cover'];
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['env'] = env;
    data['status'] = status;
    data['currency_code'] = currencyCode;
    data['cover'] = cover;
    data['extra_field'] = extraField;
    return data;
  }
}
