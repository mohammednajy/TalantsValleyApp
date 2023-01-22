import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/models/user_details_model.dart';
import 'package:tanlants_valley_application/router/router.dart';

import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/helper.dart';
import '../../../view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import '../../network/api/user_management_api/user_details_api.dart';

class UserDetailsController with ChangeNotifier {
  UserDetailsModel? userDetailsInfo;
  Transfers? userTransfer;
  List userIpRecords = [];
  userDetails({required String token, required String id}) async {
    Response response = await UserDetailsApi.userDetails(token: token, id: id);
    if (response.statusCode == 200) {
      final dataResponse = response.data["data"]["user"];

      userDetailsInfo = UserDetailsModel.fromJson(dataResponse);
      userTransfer = Transfers.fromJson(response.data["data"]["transfer"]);
      notifyListeners();

      Navigator.push(
        AppRouter.navigationKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const UserDetailsScreen(),
        ),
      );
    }
  }

  editUser({
    required String token,
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String idNumber,
    required String address1,
    required String address2,
    required String city,
    required String country,
  }) async {
    Response response = await UserDetailsApi.userDetailsEdit(
      token: token,
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobile: mobile,
      idNumber: idNumber,
      address1: address1,
      address2: address2,
      city: city,
      country: country,
    );

    if (response.statusCode == 200) {
      refreshEditedUser(token: token, id: id);

      UtilsConfig.showSnackBarMessage(
          message: 'Edited Sucessfully', status: true);
      AppRouter.back();
    }
  }

  refreshEditedUser({required String token, required String id}) async {
    Response response = await UserDetailsApi.userDetails(token: token, id: id);
    if (response.statusCode == 200) {
      final dataResponse = response.data["data"]["user"];
      userDetailsInfo = UserDetailsModel.fromJson(dataResponse);
      userTransfer = Transfers.fromJson(response.data["data"]["transfer"]);
      notifyListeners();
    }
  }

  userApproval(
      {required String token, required String id, required String type}) async {
    Response response =
        await UserDetailsApi.userApproval(token: token, id: id, type: type);
    if (response.statusCode == 200) {
      refreshEditedUser(token: token, id: id);
      UtilsConfig.showSnackBarMessage(
          message: 'Edited Sucessfully', status: true);
      AppRouter.back();
    }
  }

  userDisapproval(
      {required String token,
      required String id,
      required String type,
      required String note,
      required String reason}) async {
    Response response = await UserDetailsApi.userDisapproval(
      token: token,
      id: id,
      type: type,
      note: note,
      reason: reason,
    );
    if (response.statusCode == 200) {
      refreshEditedUser(token: token, id: id);
      UtilsConfig.showSnackBarMessage(
          message: 'Edited Sucessfully', status: true);
      AppRouter.back();
    }
  }

  Map<String, String> resonDisapproval = {
    "1": "Outdated Document",
    "2": "Fraud Document"
  };
  String? selected;
  setSelected(String? value) {
    selected = value;
    notifyListeners();
  }

  userIP({required String token, required String id}) async {
    Response response = await UserDetailsApi.userIP(token: token, id: id);
    if (response.statusCode == 200) {
      userIpRecords = response.data["data"]["records"];
      notifyListeners();
      AppRouter.goTo(ScreenName.userIPScreen);
    }
  }

  editFinancialInfo({
    required String token,
    required String id,
    required int profit,
    required int balance,
    required int revenue,
  }) async {
    Response response = await UserDetailsApi.editFinancialInfo(
        token: token,
        id: id,
        balance: balance,
        profit: profit,
        revenue: revenue);
    if (response.statusCode == 200) {
      refreshEditedUser(token: token, id: id);
      UtilsConfig.showSnackBarMessage(
          message: 'Edited Sucessfully', status: true);
      AppRouter.back();
    }
  }
}
