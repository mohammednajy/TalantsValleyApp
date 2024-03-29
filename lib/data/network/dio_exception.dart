import 'package:dio/dio.dart';

import '../../utils/helper.dart';

class DioExceptions implements Exception {
  static late String message;

  static String fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        print('dddddddd ${dioError.message}');
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        print(dioError.response);
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
    return message;
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error["message"];
      case 422:
        print(error);
        return error["message"];
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';

      default:
        print(statusCode);
        return 'Oops something went wrong $statusCode';
    }
  }

  @override
  String toString() => message;

  static showMessage(DioError error) {
    UtilsConfig.showSnackBarMessage(
        message: fromDioError(error), status: false);
  }
}
