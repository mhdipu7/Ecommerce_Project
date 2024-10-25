import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/models/cart_list/cart_list_model.dart';
import 'package:crafty_bay/data/models/cart_list/cart_model.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<CartModel> _cartList = [];


  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<CartModel> get cartList => _cartList;


  Future<bool> getCartList({required String token}) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
      token: token,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _cartList = CartListModel.fromJson(response.responseBody).cartList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
