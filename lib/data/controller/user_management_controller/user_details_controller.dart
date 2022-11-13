import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/models/user_details_model.dart';
import 'package:tanlants_valley_application/router/router.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/utils/helper.dart';
import '../../../view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import '../../network/api/user_management_api/user_details_api.dart';

class UserDetailsController with ChangeNotifier {
  UserDetailsModel? userDetailsInfo;

  userDetails({required String token, required String id}) async {
    Response response = await UserDetailsApi.userDetails(token: token, id: id);
    if (response.statusCode == 200) {
      final dataResponse = response.data["data"]["user"];

      userDetailsInfo = UserDetailsModel.fromJson(dataResponse);

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
      print(response.data);
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
      notifyListeners();
    }
  }
}
