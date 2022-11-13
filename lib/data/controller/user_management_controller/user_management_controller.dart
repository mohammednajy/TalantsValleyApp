import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/data/models/user_model.dart';
import 'package:tanlants_valley_application/data/network/api/user_management_api/user_management_api.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/router/router.dart';


class UserManagementController extends ChangeNotifier {
  List<UserInfo> users = [];
  int offset = 20;
  int limit = 20;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;

  loadMore({
    required String token,
    String? search,
    bool isBlocked = false,
    bool isTeam = false,
    String sort = "-createdAt",
  }) async {
    isLoadMoreRunning = true;
    hasNextPage = true;
    notifyListeners();
    Response response = await UserManagementApi.getUsers(
      token: token,
      search: search,
      isBlocked: isBlocked,
      isTeam: isTeam,
      sort: sort,
      offset: offset,
      limit: limit,
    );
    if (response.statusCode == 200) {
      final List data = response.data["data"]["users"];
      if (data.isNotEmpty) {
        List<UserInfo> moreUsers =
            data.map((e) => UserInfo.fromJson(e)).toList();
        users.addAll(moreUsers);
        notifyListeners();
      } else {
        hasNextPage = false;
        Timer(
          const Duration(seconds: 1),
          () {
            hasNextPage = true;
            notifyListeners();
          },
        );

        notifyListeners();
      }
    }

    isLoadMoreRunning = false;
    offset = users.length;
    notifyListeners();
  }

  getUser({
    required String token,
    String? search,
    bool isBlocked = false,
    bool isTeam = false,
    String sort = "-createdAt",
    int offset = 0,
    int limit = 20,
  }) async {
    Provider.of<AuthController>(AppRouter.navigationKey.currentContext!,
            listen: false)
        .cnacelResendLoading = true;
    Response response = await UserManagementApi.getUsers(
      token: token,
      search: search,
      isBlocked: isBlocked,
      isTeam: isTeam,
      sort: sort,
      offset: offset,
      limit: limit,
    );
    if (response.statusCode == 200) {
      final List data = response.data["data"]["users"];
      print(data.length);
      users = data.map((e) => UserInfo.fromJson(e)).toList();
      notifyListeners();
    }
    Provider.of<AuthController>(AppRouter.navigationKey.currentContext!,
            listen: false)
        .cnacelResendLoading = false;
    notifyListeners();
  }

  setAsTeam({required String token, required String id}) async {
    Response response = await UserManagementApi.setAsTeam(token: token, id: id);
    if (response.statusCode == 200) {
      int index = users.indexWhere((element) => element.id == id);
      // print(response.data["data"]["role"].toString());
      users[index].role = response.data["data"]["role"];
      notifyListeners();
    }
  }

  blockUnBlock({required String token, required String id}) async {
    Response response =
        await UserManagementApi.blockUnBlock(token: token, id: id);
    if (response.statusCode == 200) {
      int index = users.indexWhere((element) => element.id == id);
      users[index].isBlocked = response.data["data"]["isBlocked"];
      notifyListeners();
    }
  }

  deleteUser({required String token, required String id}) async {
    Response response =
        await UserManagementApi.deleteUser(token: token, id: id);
    if (response.statusCode == 200) {
      int index = users.indexWhere((element) => element.id == id);
      users.removeAt(index);
      notifyListeners();
    }
  }

// for filter
  Map<int, bool> filterValues = {
    0: false,
    1: false,
    2: false,
    3: false,
  };

  void changeFilterValues({required int index}) {
    filterValues[index] = !filterValues[index]!;
    notifyListeners();
  }

  
}
