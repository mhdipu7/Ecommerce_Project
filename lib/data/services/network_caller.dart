import 'dart:convert';
import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:crafty_bay/data/entities/network/network_response.dart';
import 'package:crafty_bay/data/services/logger_service.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';

class NetworkCaller {
  final LoggerService loggerServices;
  final AuthController authController;

  NetworkCaller({
    required this.loggerServices,
    required this.authController,
  });

  Future<NetworkResponse> getRequest(
      {required String url, String? token}) async {
    try {
      final Uri uri = Uri.parse(url);
      loggerServices.requestLog(url, {}, {}, AuthController.accessToken ?? '');
      final Response response = await get(
        uri,
        headers: {
          'token': '${token ?? AuthController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        loggerServices.responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodedBody,
        );
      } else {
        loggerServices.responseLog(
            url, response.statusCode, response.body, response.headers, false);
        if (response.statusCode == 401) {
          _moveToNext();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      loggerServices.responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body, String? token}) async {
    try {
      final Uri uri = Uri.parse(url);
      loggerServices.requestLog(url, {}, body ?? {}, token ?? '');
      final Response response = await post(
        uri,
        headers: {
          'token': "${token ?? AuthController.accessToken}",
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        loggerServices.responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseBody: decodedBody,
        );
      } else {
        loggerServices.responseLog(
            url, response.statusCode, response.body, response.headers, false);
        if (response.statusCode == 401) {
          _moveToNext();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      loggerServices.responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _moveToNext() async {
    authController.clearUserData();
    getx.Get.toNamed(RoutesName.emailVerificationScreen);
  }
}
