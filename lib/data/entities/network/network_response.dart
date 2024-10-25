class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  dynamic responseBody;
  String? errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseBody,
    this.errorMessage = "Something went wrong",
  });
}
