import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/verification_controller.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/view/screens/verification/mobile_verification/mobile_verification_done_screen.dart';
import 'package:tanlants_valley_application/view/screens/verification/shared_screen/shared_verification.dart';
import 'package:provider/provider.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({super.key});

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final TextEditingController firstControllerField = TextEditingController();
  final TextEditingController secoundControllerField = TextEditingController();
  final TextEditingController thirdControllerField = TextEditingController();
  final TextEditingController fourthControllerField = TextEditingController();
  final TextEditingController fifthControllerField = TextEditingController();
  final TextEditingController sixthControllerField = TextEditingController();
  final GlobalKey<FormState> otpKey = GlobalKey();
  @override
  void dispose() {
    firstControllerField.dispose();
    secoundControllerField.dispose();
    thirdControllerField.dispose();
    fourthControllerField.dispose();
    fifthControllerField.dispose();
    sixthControllerField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SharedVerification(
        otpKey: otpKey,
        firstControllerField: firstControllerField,
        secoundControllerField: secoundControllerField,
        thirdControllerField: thirdControllerField,
        fourthControllerField: fourthControllerField,
        fifthControllerField: fifthControllerField,
        sixthControllerField: sixthControllerField,
        icon: Icons.mobile_friendly_outlined,
        message:
            "We have sent you a verification code to your mobile number ${SharedPrefController().getUser().userInfo.mobile.replaceRange(0, SharedPrefController().getUser().userInfo.mobile.length - 3, "*******")} ",
        onTapResend: () {
          context.read<VerificationController>().resendSendPhoneCode(
              token: SharedPrefController().getUser().accessToken);
        },
        onPressedButton: () {
          String code = firstControllerField.text +
              secoundControllerField.text +
              thirdControllerField.text +
              fourthControllerField.text +
              fifthControllerField.text +
              sixthControllerField.text;
          if (otpKey.currentState!.validate()) {
            print(code);
            context.read<VerificationController>().verifyPhoneCode(
                token: SharedPrefController().getUser().accessToken,
                code: code);
          }
        });
  }
}
