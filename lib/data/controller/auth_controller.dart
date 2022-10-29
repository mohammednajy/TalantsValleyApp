import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/form_validation.dart';
import 'package:tanlants_valley_application/data/network/api/auth_api.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/helper.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/new_password_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/otp_email_screen.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  bool loading = false;
  String errorMessage = "";
  bool cnacelResendLoading = false;

  login(
      {required String email,
      required String password,
      required GlobalKey<FormState> signinKey}) async {
    if (signinKey.currentState!.validate()) {
      final Response response =
          await AuthApi.login(email: email, password: password);
      if (response.data["statusCode"] == 200) {
        AppRouter.goAndRemove(ScreenName.homeScreen);
      }
    }
  }

  signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String countery,
  }) async {
    final Response response = await AuthApi.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      countery: countery,
    );
    if (response.data["statusCode"] == 200) {
      AppRouter.goAndRemove(ScreenName.loginScreen);
    }
  }

  forgetPassword({required String email}) async {
    final Response response = await AuthApi.forgetPassword(email: email);
    if (response.data["statusCode"] == 200) {
      Navigator.push(
          AppRouter.navigationKey.currentContext!,
          MaterialPageRoute(
            builder: (context) =>
                OtpEmailScreen(email: email, id: response.data["data"]["_id"]),
          ));
    }
  }

  sendOtpCode({required String id, required String code}) async {
    final Response response = await AuthApi.sendOtpCode(id: id, code: code);
    if (response.data["statusCode"] == 200) {
      print('ttttt');
      Navigator.push(
        AppRouter.navigationKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<FormValidation>(
                create: (context) => FormValidation(),
                child: NewPasswordScreen(
                    recoveryToken: response.data["data"]["recoverToken"]))),
      );
    }
  }

  forgetPasswordResend({required String email}) async {
    cnacelResendLoading = true;
    notifyListeners();
    final Response response = await AuthApi.forgetPassword(email: email);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: response.data["message"], status: true);
    }
    cnacelResendLoading = false;
    notifyListeners();
  }

  createNewPassword(
      {required String password, required String recoverToken}) async {
    final Response response = await AuthApi.newPassword(
        password: password, recoverToken: recoverToken);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: response.data["message"], status: true);
      AppRouter.goTo(ScreenName.passwordResetDoneScreen);
    }
  }

  startLoading() {
    loading = true;
    notifyListeners();
  }

  endLoading() {
    loading = false;
    notifyListeners();
  }

  addErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }
}
