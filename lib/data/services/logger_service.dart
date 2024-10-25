import 'package:logger/logger.dart';

class LoggerService {
  final Logger logger;

  LoggerService({required this.logger});

  void requestLog(String url, Map<String, dynamic> params,
      Map<String, dynamic> body, String token) {
    logger.i('''
    [Request]
    Url: $url
    Params: $params
    Body: $body
    Token: $token
    ''');
  }

  void responseLog(String url, int statusCode, dynamic responseBody,
      Map<String, dynamic> headers, bool isSuccess,
      [dynamic error]) {
    String message = '''
    [Response]
    Url: $url
    Status Code: $statusCode
    Headers: $headers
    Response Body: $responseBody
    ''';

    if (error != null) {
      message += '$error\n';
    }

    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}
