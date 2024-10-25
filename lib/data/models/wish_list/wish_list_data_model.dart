import 'package:crafty_bay/data/models/wish_list/wish_list_product_model.dart';

class WishListDataModel {
  int? id;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  WishListProductModel? product;

  WishListDataModel(
      {this.id,
      this.productId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.product});

  WishListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null
        ? WishListProductModel.fromJson(json['product'])
        : null;
  }
}
