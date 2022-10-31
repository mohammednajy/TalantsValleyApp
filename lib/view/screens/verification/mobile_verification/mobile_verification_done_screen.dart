import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/view/screens/verification/shared_screen/shared_done_verification.dart';

class MobileVerificationDoneScreen extends StatelessWidget {
  const MobileVerificationDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedDoneVerfication(
        message: 'You Verified Your Phone Number Successfully',
        onPressed: () {
          AppRouter.goAndRemove(ScreenName.verificationScreen);
        });
  }
}
