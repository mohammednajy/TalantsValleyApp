import 'dart:convert';

import 'package:tanlants_valley_application/data/models/user_model.dart';

// void main(List<String> args) {
//   String jsonString='''
// {
//             "address": {
//                 "country": "Palestine",
//                 "city": "Gaza",
//                 "address1": "Tal Alhawa",
//                 "address2": "-"
//             },
//             "verifiedAddress": {
//                 "status": "approved",
//                 "addressDocumentType": "other",
//                 "addressFile": "https://firebasestorage.googleapis.com/v0/b/talents-valley.appspot.com/o/ADDRESS_Files%2F6337f7627ec5f471f88f78c8?alt=media&token=bcb9d671-a4bc-4b27-b7ba-fed8a6c6b3a8",
//                 "otherDocumentType": "rent contract",
//                 "note": null
//             },
//             "verifiedId": {
//                 "status": "rejected"
//             },
//             "_id": "6337f7627ec5f471f88f78c8",
//             "firstName": "Heba",
//             "lastName": "Test",
//             "email": "testewfc@gmail.com",
//             "mobile": "+970597044345",
//             "verifiedEmail": true,
//             "verifiedMobile": true,
//             "isBlocked": false,
//             "role": 0,
//             "balance": 1000,
//             "lastLoginIP": "192.158.1.38",
//             "profit": 100,
//             "revenue": 200,
//             "lastLogin": "2022-10-12T06:00:12.261Z",
//             "createdAt": "2022-10-01T08:16:34.315Z",
//             "updatedAt": "2022-10-12T06:02:26.563Z"
//         }''';

//     final jsonObject=jsonDecode(jsonString);
//     print(UserDetailsModel.fromJson(jsonObject).revenue);
// }

class UserDetailsModel extends UserInfo {
  final String? lastLoginIP;
  final int profit;
  final int revenue;
  final String lastLogin;
  final String createdAt;
  final String updatedAt;

  UserDetailsModel(
      {required this.lastLoginIP,
      required this.profit,
      required this.revenue,
      required this.lastLogin,
      required this.createdAt,
      required this.updatedAt,
      required super.id,
      required super.firstName,
      required super.lastName,
      required super.email,
      required super.mobile,
      required super.balance,
      required super.verifiedEmail,
      required super.verifiedMobile,
      required super.verificationAddress,
      required super.verifiedId,
      required super.role,
      required super.address,
      required super.isBlocked});

  factory UserDetailsModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserDetailsModel(
      lastLoginIP: jsonMap["lastLoginIP"],
      profit: jsonMap["profit"],
      revenue: jsonMap["revenue"],
      lastLogin: jsonMap["lastLogin"],
      createdAt: jsonMap["createdAt"],
      updatedAt: jsonMap["updatedAt"],
      id: jsonMap["_id"],
      firstName: jsonMap["firstName"],
      lastName: jsonMap["lastName"],
      email: jsonMap["email"],
      mobile: jsonMap["mobile"],
      balance: jsonMap["balance"],
      verifiedEmail: jsonMap["verifiedEmail"],
      verifiedMobile: jsonMap["verifiedMobile"],
      verificationAddress: jsonMap["verifiedAddress"],
      verifiedId: jsonMap["verifiedId"],
      role: jsonMap["role"],
      address: jsonMap["address"],
      isBlocked: jsonMap["isBlocked"],
    );
  }
}
/**
 "user": {
            "address": {
                "country": "Palestine",
                "city": "Gaza",
                "address1": "Tal Alhawa",
                "address2": "-"
            },
            "verifiedAddress": {
                "status": "approved",
                "addressDocumentType": "other",
                "addressFile": "https://firebasestorage.googleapis.com/v0/b/talents-valley.appspot.com/o/ADDRESS_Files%2F6337f7627ec5f471f88f78c8?alt=media&token=bcb9d671-a4bc-4b27-b7ba-fed8a6c6b3a8",
                "otherDocumentType": "rent contract",
                "note": null
            },
            "verifiedId": {
                "status": "rejected"
            },
            "_id": "6337f7627ec5f471f88f78c8",
            "firstName": "Heba",
            "lastName": "Test",
            "email": "testewfc@gmail.com",
            "mobile": "+970597044345",
            "verifiedEmail": true,
            "verifiedMobile": true,
            "isBlocked": false,
            "role": 0,
            "balance": 1000,
            "lastLoginIP": "192.158.1.38",
            "profit": 100,
            "revenue": 200,
            "lastLogin": "2022-10-12T06:00:12.261Z",
            "createdAt": "2022-10-01T08:16:34.315Z",
            "updatedAt": "2022-10-12T06:02:26.563Z"
        }
 */