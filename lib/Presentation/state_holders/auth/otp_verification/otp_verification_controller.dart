import 'package:crafty_bay/data/Utils/api_urls/urls.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  String _accessToken = '';

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  String get accessToken => _accessToken;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = true;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.verifyOtpUrl(email, otp),
    );


    if (response.isSuccess && response.responseBody['msg'] == 'success') {
      _errorMessage = null;
      _accessToken = response.responseBody['data'];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }


    _inProgress = false;
    update();
    return isSuccess;
  }
}
