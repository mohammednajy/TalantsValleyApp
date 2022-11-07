import 'package:dio/dio.dart';
import 'package:tanlants_valley_application/data/network/endpoints.dart';

import '../base_client.dart';

class UserManagementApi {
  static Future<Response> getUsers({
    required String token,
    String? search,
    bool isBlocked = false,
    bool isTeam = false,
    String sort = "-createdAt",
  }) async {
    return await BaseClientHelper().get(EndPoints.getAllUsers,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
        queryParameters: {
          "search": search,
          "isBlocked": isBlocked,
          "isTeam": isTeam,
          "sort": sort
        });
  }

  static Future<Response> setAsTeam({
    required String token,
    required String id,
  }) async {
    return await BaseClientHelper().put('${EndPoints.setAsTeam}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

  static Future<Response> blockUnBlock({
    required String token,
    required String id,
  }) async {
    return await BaseClientHelper().put('${EndPoints.blockUnBlock}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

  static Future<Response> deleteUser({
    required String token,
    required String id,
  }) async {
    return await BaseClientHelper().delete('${EndPoints.deleteUser}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

}
