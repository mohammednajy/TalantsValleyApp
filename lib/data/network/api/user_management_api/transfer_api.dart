import 'package:dio/dio.dart';

import '../../base_client.dart';
import '../../endpoints.dart';

class TransferApi{

   static Future<Response> transferBankCash({
    required String token,
    required String id,
  }) async {
    return await BaseClientHelper().get('${EndPoints.getTansferBankCash}$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
  }

  static Future<Response> addBankAccount({
    required String token,
    required String freelancerId,
     required String accountName,
      required String accountNumber,
       required String bankBranch,
        required String ledger,
  }) async {
    return await BaseClientHelper().post(EndPoints.addBankAccount,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "freelancerId": freelancerId,
          "accountName": accountName,
          "accountNumber": accountNumber,
          "bankBranch": bankBranch,
          "ledger":ledger
        });
  }
}