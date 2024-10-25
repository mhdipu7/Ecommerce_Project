import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/models/product_details/product_details_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  ProductDetailsModel? _productDetailsModel;
  String? _errorMessage;
  int _quantity = 1;
  int _price = 0;
  int _unitePrice = 0;

  bool get inProgress => _inProgress;

  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? get errorMessage => _errorMessage;

  int get quantity => _quantity;

  int get price => _price;

  void incrementItem() {
    if (_productDetailsModel != null && _unitePrice > 0) {
      _quantity++;
      _price = _unitePrice * _quantity;
    }
    update();
  }

  void decrementItem() {
    if (_quantity > 1 && _productDetailsModel != null && _unitePrice > 0) {
      _quantity--;
      _price = _unitePrice * _quantity;
    }
    update();
  }

  Future<bool> getProductDetailsById(int id) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productDetailsByIdUrl(id));

    if (response.isSuccess) {

      if(response.responseBody['data'] != null && response.responseBody['data'].isNotEmpty){
        _errorMessage = null;
        _productDetailsModel =
            ProductDetailsModel.fromJson(response.responseBody['data'][0]);
        _unitePrice =
            int.tryParse(_productDetailsModel!.product?.price ?? '0') ?? 0;
        _price = _unitePrice * _quantity;
        isSuccess = true;
      } else{
        _productDetailsModel = null;
        _errorMessage = "No product details available.";
      }


    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
