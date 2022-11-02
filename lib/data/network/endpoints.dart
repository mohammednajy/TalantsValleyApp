class EndPoints {
  EndPoints._();

  static const String baseUrl = 'https://talents-valley.herokuapp.com/api';

  //for auth
  static const String loginUrl = '$baseUrl/user/login';
  static const String signupUrl = '$baseUrl/user/signup';
  static const String forget = '$baseUrl/user/password/forgot';
  static const String otpEmail = '$baseUrl/user/password/verify-code';
  static const String newPassword = '$baseUrl/user/password/recover';

  //for verification
  //email verification
  static const String sendEmailCodeVerification =
      '$baseUrl/user/send-code-email';
  static const String verfiyEmailVerification = '$baseUrl/user/verify/email';
  //phone verification
  static const String sendPhoneCodeVerification =
      '$baseUrl/user/send-code-mobile';
  static const String verfiyPhoneVerification = '$baseUrl/user/verify/mobile';
  //id verification
  static const String verfiyId = '$baseUrl/user/verify/id';
// get user info
  static const String userInfo = '$baseUrl/settings/profile';

  static const int receiveTimeout = 35000;
}
