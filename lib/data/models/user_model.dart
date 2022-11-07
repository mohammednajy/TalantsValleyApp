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
  final String? mobile;
  final int balance;
  final bool verifiedEmail;
  final bool verifiedMobile;
  final Map verificationAddress;
  final Map verifiedId;
   int role;
  final Map? address;
   bool isBlocked;

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
