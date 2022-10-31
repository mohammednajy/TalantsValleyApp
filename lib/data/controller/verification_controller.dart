import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/models/user_model.dart';
import 'package:tanlants_valley_application/data/network/api/verification_api.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import '../../utils/helper.dart';
import '../../view/screens/verification/email_verification/email_verification_done_screen.dart';
import '../../view/screens/verification/mobile_verification/mobile_verification_done_screen.dart';

class VerificationController extends ChangeNotifier {
  sendEmailCode({required String token}) async {
    final Response response = await VerificationApi.sendEmailCode(token: token);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: "Send code successfully", status: true);
      AppRouter.goTo(ScreenName.emailVerificationScreen);
    }
  }

  resendsendEmailCode({required String token}) async {
    final Response response = await VerificationApi.sendEmailCode(token: token);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: "Send code successfully", status: true);
    }
  }

  verifyEmailCode({required String token, required String code}) async {
    final Response response =
        await VerificationApi.verifyEmailCode(token: token, code: code);
    if (response.data["statusCode"] == 200) {
      refreshVarityEmailState();
      UtilsConfig.showSnackBarMessage(
          message: "Verified successfully", status: true);
      Navigator.push(
          AppRouter.navigationKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const EmailVerficationDoneScreen(),
          ));
    }
  }

  sendPhoneCode({required String token}) async {
    final Response response = await VerificationApi.sendPhoneCode(token: token);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: "Send code successfully", status: true);
      AppRouter.goTo(ScreenName.mobileVerificationScreen);
    }
  }

  resendSendPhoneCode({required String token}) async {
    final Response response = await VerificationApi.sendPhoneCode(token: token);
    if (response.data["statusCode"] == 200) {
      UtilsConfig.showSnackBarMessage(
          message: "Send code successfully", status: true);
    }
  }

  verifyPhoneCode({required String token, required String code}) async {
    final Response response =
        await VerificationApi.verifyPhoneCode(token: token, code: code);
    if (response.data["statusCode"] == 200) {
      refreshVarityPhoneState();
      UtilsConfig.showSnackBarMessage(
          message: "Verified successfully", status: true);
      Navigator.push(
          AppRouter.navigationKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const MobileVerificationDoneScreen(),
          ));
    }
  }

  refreshVarityEmailState() {
    UserModel user = SharedPrefController().getUser();
    UserInfo userInfo = user.userInfo;
    UserModel newUser = UserModel(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      userInfo: UserInfo(
        id: userInfo.id,
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        email: userInfo.email,
        mobile: userInfo.mobile,
        balance: userInfo.balance,
        verifiedEmail: true,
        verifiedMobile: userInfo.verifiedMobile,
        verificationAddress: userInfo.verificationAddress,
        verifiedId: userInfo.verifiedId,
        role: userInfo.role,
        address: userInfo.address,
        isBlocked: userInfo.isBlocked,
      ),
    );
    SharedPrefController().save(newUser);
  }

  refreshVarityPhoneState() {
    UserModel user = SharedPrefController().getUser();
    UserInfo userInfo = user.userInfo;
    UserModel newUser = UserModel(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      userInfo: UserInfo(
        id: userInfo.id,
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        email: userInfo.email,
        mobile: userInfo.mobile,
        balance: userInfo.balance,
        verifiedEmail: userInfo.verifiedEmail,
        verifiedMobile: true,
        verificationAddress: userInfo.verificationAddress,
        verifiedId: userInfo.verifiedId,
        role: userInfo.role,
        address: userInfo.address,
        isBlocked: userInfo.isBlocked,
      ),
    );
    SharedPrefController().save(newUser);
  }
}
