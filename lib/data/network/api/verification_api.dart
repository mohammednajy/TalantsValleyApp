import 'package:dio/dio.dart';

import '../base_client.dart';
import '../endpoints.dart';

class VerificationApi {
  VerificationApi._();

  static Future<Response> sendEmailCode({required String token}) async {
    return await BaseClientHelper().post(EndPoints.sendEmailCodeVerification,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response> verifyEmailCode({
    required String token,
    required String code,
  }) async {
    return await BaseClientHelper().post(
      EndPoints.verfiyEmailVerification,
      data: {"verificationCode": code},
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  static Future<Response> sendPhoneCode({required String token}) async {
    return await BaseClientHelper().post(EndPoints.sendPhoneCodeVerification,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response> verifyPhoneCode({
    required String token,
    required String code,
  }) async {
    return await BaseClientHelper().post(
      EndPoints.verfiyPhoneVerification,
      data: {"verificationCode": code},
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  static Future<Response> verifyId({
    dynamic data,
    required String token,
  }) async {
    return await BaseClientHelper().post(
      EndPoints.verfiyId,
      data: data,
      options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          contentType:
              "multipart/form-data; boundary=<calculated when request is sent>"),
    );
  }

   static Future<Response> verfiyAddress({
    dynamic data,
    required String token,
  }) async {
    return await BaseClientHelper().post(
      EndPoints.verfiyAddress,
      data: data,
      options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
    );
  }
}
