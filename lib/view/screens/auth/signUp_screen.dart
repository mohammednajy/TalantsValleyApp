import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';

import '../../../router/router.dart';
import '../../../router/routes_name.dart';
import '../../../utils/constant_utils.dart';
import '../../shared/auth_shared/auth_header_widget.dart';
import '../../shared/auth_shared/login_form_widget.dart';
import '../../shared/auth_shared/rich_text_widget.dart';
import '../../shared/auth_shared/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              const AuthHeaderWidget(heightSpace: 32, headTitle: 'Sign Up'),
              addVerticalSpace(39),
              SignUpFormWidget(),
              addVerticalSpace(30),
              RichTextWidget(
                left: 'Already have an account?',
                right: ' Sign In',
                onTap: () {
                  AppRouter.goAndRemove(ScreenName.loginScreen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
