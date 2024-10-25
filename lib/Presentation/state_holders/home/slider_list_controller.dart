import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/models/slider/slider_list_model.dart';
import 'package:crafty_bay/data/models/slider/slider_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<SliderModel> _sliderList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<SliderModel> get sliderList => _sliderList;

  Future<bool> getSliderList() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Urls.sliderListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _sliderList = SliderListModel.fromJson(response.responseBody).sliderList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
