import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/auth_shared/auth_header_widget.dart';
import '../../shared/auth_shared/login_form_widget.dart';
import '../../shared/auth_shared/rich_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(60),
              const AuthHeaderWidget(heightSpace: 104, headTitle: 'Sign In'),
              addVerticalSpace(55),
              const SignInFormWidget(),
              addVerticalSpace(38),
              RichTextWidget(
                left: 'Don\'t have an account?',
                right: ' Sign up',
                onTap: () {
                  AppRouter.goAndRemove(ScreenName.singupScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
