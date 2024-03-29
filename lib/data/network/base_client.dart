import 'package:dio/dio.dart';
import 'package:tanlants_valley_application/data/network/endpoints.dart';
import 'package:tanlants_valley_application/data/network/interceptor/error_interceptor.dart';

class BaseClientHelper {
  BaseClientHelper._();

  static final BaseClientHelper _instanse = BaseClientHelper._();

  factory BaseClientHelper() {
    return _instanse;
  }

  final dio = Dio(BaseOptions(
    connectTimeout: EndPoints.receiveTimeout,
    baseUrl: EndPoints.baseUrl,
    receiveDataWhenStatusError: true,
    receiveTimeout: EndPoints.receiveTimeout,
  ))
    ..interceptors.add(ErrorInterceptor());

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get(path,
        queryParameters: queryParameters, options: options);
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.put(path,
        data: data, queryParameters: queryParameters, options: options);
  }

   Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.delete(path,
        data: data, queryParameters: queryParameters, options: options);
  }
}
