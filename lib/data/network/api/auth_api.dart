import 'package:dio/dio.dart';
import 'package:tanlants_valley_application/data/network/base_client.dart';
import 'package:tanlants_valley_application/data/network/endpoints.dart';

class AuthApi {
  AuthApi._();

  static Future<Response> login(
      {required String email, required String password}) async {
    return await BaseClientHelper()
        .post(EndPoints.loginUrl, data: {"email": email, "password": password});
  }

  static Future<Response> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String phoneNumber,
      required String countery}) async {
    return await BaseClientHelper().post(EndPoints.signupUrl, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobile": phoneNumber,
      "password": password,
      "country": countery
    });
  }

  static Future<Response> forgetPassword({required String email}) async {
    return await BaseClientHelper()
        .post(EndPoints.forget, data: {"email": email});
  }

  static Future<Response> sendOtpCode(
      {required String id, required String code}) async {
    return await BaseClientHelper()
        .post(EndPoints.otpEmail, data: {"_id": id, "verificationCode": code});
  }

  static Future<Response> newPassword(
      {required String password, required String recoverToken}) async {
    return await BaseClientHelper().post(
      EndPoints.newPassword,
      data: {
        "password": password,
        "recoverToken": recoverToken,
      },
    );
  }
}
