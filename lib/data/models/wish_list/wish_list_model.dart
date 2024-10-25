import 'package:crafty_bay/data/models/wish_list/wish_list_data_model.dart';

class WishListModel {
  String? msg;
  List<WishListDataModel>? productWishList;

  WishListModel({this.msg, this.productWishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productWishList = <WishListDataModel>[];
      json['data'].forEach((v) {
        productWishList!.add(WishListDataModel.fromJson(v));
      });
    }
  }
}
