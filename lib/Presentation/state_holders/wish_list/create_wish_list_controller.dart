import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool _isProductAdded = false;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  bool get isProductAdded => _isProductAdded;



  void isAddedWishProduct(int productID) {

    bool isContain = Get.find<WishListController>()
        .wishList
        .any((product) => product.productId == productID);

    if (isContain) {
      _isProductAdded = true;
    } else {
      _isProductAdded = false;
    }

    update();
  }



  Future<bool> createWishList({
    required String token,
    required int productID,
  }) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.createWishListUrl(productID),
      token: token,
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
