import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/otp_widget.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import '../../../../data/controller/auth_controller.dart';
import '../../../../data/controller/verification_controller.dart';
import '../../../../router/router.dart';
import '../../../shared/auth_shared/rich_text_widget.dart';
import '../shared_screen/shared_verification.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
      icon: Icons.mark_email_read_outlined,
      message:
          'We have sent you a verification code to your ${SharedPrefController().getUser().userInfo.email.replaceRange(5, SharedPrefController().getUser().userInfo.email.length - 13, "*****")}',
      onTapResend: () {
        context.read<VerificationController>().resendsendEmailCode(
            token: SharedPrefController().getUser().accessToken);
      },
      onPressedButton: () {
        if (otpKey.currentState!.validate()) {
          String code = firstControllerField.text +
              secoundControllerField.text +
              thirdControllerField.text +
              fourthControllerField.text +
              fifthControllerField.text +
              sixthControllerField.text;
          context.read<VerificationController>().verifyEmailCode(
              token: SharedPrefController().getUser().accessToken, code: code);
        }
      },
    );
  }
}
