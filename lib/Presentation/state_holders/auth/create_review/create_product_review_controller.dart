import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductReviewController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  double _ratings = 0;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  double get ratings => _ratings;

  void onUpdateRatings(double value) {
    _ratings = value;
    update();
    debugPrint(_ratings.toString());
  }

  Future<bool> createReviewAndRating({
    required String productDescription,
    required int productID,
    required double rating,
    required String token,
  }) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      url: Urls.createProductReviewUrl,
      body: {
        "description": productDescription,
        "product_id": productID,
        "rating": rating.toInt(),
      },
      token: token,
    );

    if (response.isSuccess && response.responseBody['msg'] == 'success') {
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
