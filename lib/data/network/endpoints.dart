class EndPoints {
  EndPoints._();

  static const String baseUrl = 'https://talents-valley.herokuapp.com/api';

  static const String loginUrl = '$baseUrl/user/login';
  static const String signupUrl = '$baseUrl/user/signup';
  static const String forget = '$baseUrl/user/password/forgot';
  static const String otpEmail = '$baseUrl/user/password/verify-code';
  static const String newPassword = '$baseUrl/user/password/recover';

  
  static const int receiveTimeout = 35000;
}
