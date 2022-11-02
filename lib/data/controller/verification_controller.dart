import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanlants_valley_application/data/models/user_model.dart';
import 'package:tanlants_valley_application/data/network/api/auth_api.dart';
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
      refreshUserInfo();
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
      refreshUserInfo();
      UtilsConfig.showSnackBarMessage(
          message: "Verified successfully", status: true);
      Navigator.push(
          AppRouter.navigationKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const MobileVerificationDoneScreen(),
          ));
    }
  }

  verifyId(
      {required String token,
      required File file,
      required String documentType,
      required String idNumber}) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: paths!.first.name,
      ),
      "idNumber": idNumber,
      "idDocumentType": documentType,
    });

    final Response response = await VerificationApi.verifyId(
      token: token,
      data: formData,
    );
    if (response.statusCode == 200) {
      await refreshUserInfo();
      await setIdVerificationState();
      notifyListeners();
      AppRouter.goAndRemove(ScreenName.verificationScreen);
      print(response.data);
    }
  }

  // set the pending and rejected state
  bool rejected =
      SharedPrefController().getUser().userInfo.verifiedId["status"] ==
          "rejected";
  bool pending =
      SharedPrefController().getUser().userInfo.verifiedId["status"] ==
          "pending";

  setIdVerificationState() async {
    await refreshUserInfo();
    rejected = SharedPrefController().getUser().userInfo.verifiedId["status"] ==
        "rejected";
    pending = SharedPrefController().getUser().userInfo.verifiedId["status"] ==
        "pending";
    notifyListeners();
  }

  refreshUserInfo() async {
    Response response = await AuthApi.getUserInfo(
        token: SharedPrefController().getUser().accessToken);
    if (response.statusCode == 200) {
      UserInfo userInfo = UserInfo.fromJson(response.data["data"]);
      UserModel newUser = UserModel(
        accessToken: SharedPrefController().getUser().accessToken,
        refreshToken: SharedPrefController().getUser().refreshToken,
        userInfo: userInfo,
      );
      await SharedPrefController().save(newUser);

      // print(SharedPrefController().getUser().userInfo.verifiedId);
    }
  }

  // for file picker
  String? fileName;
  List<PlatformFile>? paths;
  bool validFile = false;
  late File file;
  void pickFile() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'pdf', 'jpg']) as FilePickerResult;
      if (result != null) {
        fileName = result.files.first.name;
        paths = result.files;
        file = File(result.files.first.path!);
        if (paths!.first.size > 2097152) {
          validFile = false;
        } else {
          validFile = true;
          disableButton[2] = true;
        }
      }

      notifyListeners();
    } on Error catch (e) {
      UtilsConfig.showSnackBarMessage(message: e.toString(), status: false);
    }
  }

  void _resetState() {
    fileName = null;
    paths = null;
    validFile = false;
    disableButton[2] = false;
    notifyListeners();
  }

  void clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
    } on PlatformException catch (e) {
      UtilsConfig.showSnackBarMessage(
          message: 'Unsupported operation', status: false);
    } catch (e) {
      UtilsConfig.showSnackBarMessage(message: e.toString(), status: false);
    }
  }

  // to selected document type
  String? selected;
  setSelected(String? value) {
    selected = value;
    disableButton[0] = true;
    notifyListeners();
  }

  Map<String, String> documentType = {
    "passport": "Passport",
    "driving_license": "Driver License",
    "national_id": "Identity Card",
  };

  // disable cilck button

  List<bool> disableButton = [false, true, false];

  setDisableButton() {
    disableButton.contains(true);
  }
}
