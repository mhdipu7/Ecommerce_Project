import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/models/review/review_list_model.dart';
import 'package:crafty_bay/data/models/review/review_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class ProductReviewController extends GetxController {
  bool _inProgress = false;
  List<ReviewModel> _reviewList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;

  List<ReviewModel> get reviewList => _reviewList;

  String? get errorMessage => _errorMessage;

  Future<bool> getListReviewByProductID(int id) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.listReviewByProductUrl(id));

    if (response.isSuccess) {
      _errorMessage = null;
      _reviewList =
          ReviewListModel.fromJson(response.responseBody).reviewList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
