import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/counrty_controller.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/forget_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/new_password_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/otp_email_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/password_reset_done_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/login_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/signUp_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/home_screen.dart';
import 'package:tanlants_valley_application/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import '../data/controller/form_validation.dart';

Route onGenerateRoute(RouteSettings settings) {
  dynamic result;
  switch (settings.name) {
    case ScreenName.splashScreen:
      result = const SplashScreen();
      break;
    case ScreenName.loginScreen:
      result = ChangeNotifierProvider<FormValidation>(
          create: (context) => FormValidation(), child: const LoginScreen());
      break;
    case ScreenName.singupScreen:
      result = MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => CounteryController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FormValidation(),
        )
      ], child: const SignUpScreen());

      break;
    case ScreenName.forgetScreen:
      result = ChangeNotifierProvider<FormValidation>(
        create: (context) => FormValidation(),
        child: const ForgetPasswordScreen(),
      );
      break;

    case ScreenName.otpEmailScreen:
      result = ChangeNotifierProvider<FormValidation>(
        create: (context) => FormValidation(),
        child: const OtpEmailScreen(),
      );
      break;
    case ScreenName.newPasswordScreen:
      result = ChangeNotifierProvider<FormValidation>(
        create: (context) => FormValidation(),
        child: const NewPasswordScreen(),
      );
      break;
    case ScreenName.passwordResetDoneScreen:
      result = const PasswordResetDoneScreen();
      break;
    case ScreenName.homeScreen:
      result = const HomeScreen();
      break;
    default:
      const Scaffold(
        body: Center(child: Text('error path')),
      );
  }
  return MaterialPageRoute(
    builder: (context) => result,
  );
}
