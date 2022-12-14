import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';

import '../../../storage/sherd_perf.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => SharedPrefController().getLogedin()
          ? SharedPrefController().getUser().userInfo.role == 0
              ? AppRouter.goAndRemove(ScreenName.verificationScreen)
              : AppRouter.goAndRemove(ScreenName.homeScreen)
          : AppRouter.goAndRemove(ScreenName.loginScreen),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetPath.appLogo),
          ],
        ),
      ),
    );
  }
}
