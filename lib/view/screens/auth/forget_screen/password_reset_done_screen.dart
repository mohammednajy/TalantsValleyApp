import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';

class PasswordResetDoneScreen extends StatelessWidget {
  const PasswordResetDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(60),
            const AuthHeaderWidget(
              headTitle: 'Password Reset',
              heightSpace: 30,
              fontSize: 20,
              showArrow: true,
              iconSpace: 50,
              visibleIcon: true,
            ),
            addVerticalSpace(20),
            Text(
              'Your Password has been Successfully Reset Click below to Login',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            addVerticalSpace(70),
            ButtonWidget(
                text: 'Login',
                visible: false,
                onPressed: () {
                  AppRouter.goAndRemove(ScreenName.loginScreen);
                })
          ],
        ),
      ),
    );
  }
}
