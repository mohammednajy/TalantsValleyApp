import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';

import '../shared_screen/shared_done_verification.dart';

class EmailVerficationDoneScreen extends StatelessWidget {
  const EmailVerficationDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedDoneVerfication(
      message: 'You Verified Your Email Successfully',
      onPressed: () {
        AppRouter.goAndRemove(ScreenName.verificationScreen);
      },
    );
  }
}
