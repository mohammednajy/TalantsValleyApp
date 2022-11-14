import 'package:dio/dio.dart';

import '../../base_client.dart';
import '../../endpoints.dart';

class UserDetailsApi {
  static Future<Response> userDetails({
    required String token,
    required String id,
  }) async {
    return await BaseClientHelper().get('${EndPoints.userDetails}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

  static Future<Response> userDetailsEdit({
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
    return await BaseClientHelper().put('${EndPoints.userDetailsEdit}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "mobile": mobile,
          "idNumber": idNumber,
          "address": {
            "address1": address1,
            "address2": address2,
            "city": city,
            "country": country
          }
        });
  }

  static Future<Response> userApproval(
      {required String token, required String id, required String type}) async {
    return await BaseClientHelper().put('${EndPoints.userApprove}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "type": type,
          "isApproved": true,
        });
  }

  static Future<Response> userDisapproval({
    required String token,
    required String id,
    required String type,
    required String reason,
    required String note,
  }) async {
    return await BaseClientHelper().put('${EndPoints.userApprove}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "type": type,
          "isApproved": false,
          "disapproveReason": {
            "reason": reason,
            "note": note
          }
        });
  }
}
