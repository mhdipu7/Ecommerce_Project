import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/models/wish_list/wish_list_data_model.dart';
import 'package:crafty_bay/data/models/wish_list/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  List<WishListDataModel> _wishList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;

  List<WishListDataModel> get wishList => _wishList;

  String? get errorMessage => _errorMessage;

  Future<bool> getWishList({
    required String token,
  }) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productWishListUrl,
      token: token,
    );

    if (response.isSuccess) {
      _errorMessage = null;
      _wishList =
          WishListModel.fromJson(response.responseBody).productWishList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
