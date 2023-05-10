/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
class SearchResultModel {
  int? id;
  int? uid;
  String? name;
  String? cover;
  int? status;
  double? distance;

  SearchResultModel(
      {this.id, this.uid, this.name, this.cover, this.status, this.distance});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    name = json['name'];
    cover = json['cover'];
    status = int.parse(json['status'].toString());
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['cover'] = cover;
    data['status'] = status;
    data['distance'] = distance;
    return data;
  }
}
