import 'package:tanlants_valley_application/data/models/user_model.dart';

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

class Transfers {
  final Map bank;
  final Map cash;
  Transfers({required this.bank, required this.cash});

  factory Transfers.fromJson(Map<String, dynamic> map) {
    return Transfers(bank: map["bank"], cash: map["cash"]);
  }
}
