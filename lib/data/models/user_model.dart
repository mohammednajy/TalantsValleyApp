// import 'dart:convert';

// void main(List<String> args) {
//   String jsonString = '''
// {
//         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM1YTY0M2I3OTE5NjU0YzljMGI5ZTdkIiwicm9sZSI6MH0sImV4cCI6MTY2NzEyNTg4NywiaWF0IjoxNjY3MDM5NDg3fQ.Lqu4XFyYcpWnXWIaILCDt5-aJ8RgXRA1RdqgzhfYuTY",
//         "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM1YTY0M2I3OTE5NjU0YzljMGI5ZTdkIiwicm9sZSI6MH0sImV4cCI6MTY2OTYzMTQ4NywiaWF0IjoxNjY3MDM5NDg3fQ.GtN391OnSd_H3akpQSfzrI7xk0TrVMYozQmt2516MUA",
//         "user": {
//             "_id": "635a643b7919654c9c0b9e7d",
//             "firstName": "mohammed",
//             "lastName": "naji",
//             "email": "mohammed.najy55@gmail.com",
//             "mobile": "+972592663280",
//             "balance": 0,
//             "verifiedEmail": false,
//             "verifiedMobile": false,
//             "verifiedAddress": {
//                 "disapproveReason": {},
//                 "status": "not_uploaded"
//             },
//             "verifiedId": {
//                 "disapproveReason": {},
//                 "status": "not_uploaded"
//             },
//             "role": 0,
//             "address": {
//                 "country": "Palestinian"
//             },
//             "isBlocked": false
//         }
//     }
// ''';
//   final json = jsonDecode(jsonString);
//   UserModel userModel = UserModel.fromJson(json);

//   print(userModel.accessToken);

//   print(userModel.toJson());
// }

class UserModel {
  final String accessToken;
  final String refreshToken;
  final UserInfo userInfo;

  UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonMap) {
    UserInfo userInfo = UserInfo.fromJson(jsonMap["user"]);
    return UserModel(
      accessToken: jsonMap["accessToken"],
      refreshToken: jsonMap["refreshToken"],
      userInfo: userInfo,
    );
  }
  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "user": userInfo.toJson(),
      };
}

class UserInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final int balance;
  final bool verifiedEmail;
  final bool verifiedMobile;
  final Map verificationAddress;
  final Map verifiedId;
  final int role;
  final Map address;
  final bool isBlocked;

  UserInfo(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.balance,
      required this.verifiedEmail,
      required this.verifiedMobile,
      required this.verificationAddress,
      required this.verifiedId,
      required this.role,
      required this.address,
      required this.isBlocked});

  factory UserInfo.fromJson(Map<String, dynamic> jsonMap) {
    return UserInfo(
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "balance": balance,
        "verifiedEmail": verifiedEmail,
        "verifiedMobile": verifiedMobile,
        "verifiedAddress": verificationAddress,
        "verifiedId": verifiedId,
        "role": role,
        "address": address,
        "isBlocked": isBlocked
      };
  @override
  String toString() {
    return '$id $firstName $lastName $email $mobile $balance $verificationAddress';
  }
}
