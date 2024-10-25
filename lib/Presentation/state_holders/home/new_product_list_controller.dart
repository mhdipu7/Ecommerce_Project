import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/models/product/product_list_model.dart';
import 'package:crafty_bay/data/models/product/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class NewProductListController extends GetxController {
  bool _inProgress = false;
  List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;

  List<ProductModel> get productList => _productList;

  String? get errorMessage => _errorMessage;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.listProductByRemarkUrl('new'));

    if (response.isSuccess) {
      _errorMessage = null;
      _productList =
          ProductListModel.fromJson(response.responseBody).productList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
