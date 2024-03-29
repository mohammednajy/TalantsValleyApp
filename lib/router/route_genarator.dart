import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/counrty_controller.dart';
import 'package:tanlants_valley_application/data/controller/home_controller.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/transfers_controller.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_details_controller.dart';
import 'package:tanlants_valley_application/data/controller/verification_controller.dart';
import 'package:tanlants_valley_application/data/models/user_details_model.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/forget_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/new_password_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/otp_email_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/forget_screen/password_reset_done_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/login_screen.dart';
import 'package:tanlants_valley_application/view/screens/auth/signUp_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/add_bank_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/approval_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_financial_info_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_user_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/transfers_screens/transfers_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_ip_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/home_screen.dart';
import 'package:tanlants_valley_application/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/verification/address_verification/address_verification_screen.dart';
import 'package:tanlants_valley_application/view/screens/verification/email_verification/email_verification_screen.dart';
import 'package:tanlants_valley_application/view/screens/verification/id_verification/id_verification_screen.dart';
import 'package:tanlants_valley_application/view/screens/verification/mobile_verification/mobile_verification_screen.dart';
import 'package:tanlants_valley_application/view/screens/verification/verification_screen.dart';

import '../data/controller/form_validation.dart';
import '../data/controller/user_management_controller/user_management_controller.dart';
import '../view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import '../view/screens/home/bnb_pages/user_management_page/user_management_page.dart';

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
    case ScreenName.verificationScreen:
      result = ChangeNotifierProvider(
          create: (context) => VerificationController(),
          child: const VerificationScreen());
      break;
    case ScreenName.emailVerificationScreen:
      result = ChangeNotifierProvider(
          create: (context) => VerificationController(),
          child: const EmailVerificationScreen());
      break;
    case ScreenName.mobileVerificationScreen:
      result = ChangeNotifierProvider(
          create: (context) => VerificationController(),
          child: const MobileVerificationScreen());
      break;
    case ScreenName.idVerificationScreen:
      result = ChangeNotifierProvider(
          create: (context) => VerificationController(),
          child: const IdVerificationScreen());
      break;
    case ScreenName.addressVerificationScreen:

      //
      result = MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => VerificationController(),
          ),
          ChangeNotifierProvider(
            create: (context) => CounteryController(),
          ),
        ],
        child: const AddressVerificationScreen(),
      );
      break;
    case ScreenName.homeScreen:
      result = MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserManagementController(),
        ),
      ], child: const HomeScreen());

      break;
    case ScreenName.userIPScreen:
      result = const UserIPScreen();
      break;

    case ScreenName.userDetailsScreen:
      result = const UserDetailsScreen();
      break;
    case ScreenName.editFinancialInfoScreen:
      result = const EditFinancialInfoScreen();
      break;
    case ScreenName.transfersScreen:
      final arg = settings.arguments != null ? settings.arguments as int : 0;
      result = TransfersScreen(
        initialIndex: arg,
      );
      break;
    case ScreenName.addBankScreen:
      result = const AddBankScreen();
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
