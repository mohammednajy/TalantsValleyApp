import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../data/controller/auth_controller.dart';
import '../../../../utils/constant_utils.dart';
import '../../../shared/auth_shared/auth_header_widget.dart';
import '../../../shared/auth_shared/otp_widget.dart';
import '../../../shared/auth_shared/rich_text_widget.dart';
import '../../../shared/buttons/button_widget.dart';

class SharedVerification extends StatelessWidget {
  const SharedVerification({
    Key? key,
    required this.otpKey,
    required this.firstControllerField,
    required this.secoundControllerField,
    required this.thirdControllerField,
    required this.fourthControllerField,
    required this.fifthControllerField,
    required this.sixthControllerField,
    required this.icon,
    required this.message,
    required this.onTapResend,
    required this.onPressedButton,
  }) : super(key: key);

  final GlobalKey<FormState> otpKey;
  final TextEditingController firstControllerField;
  final TextEditingController secoundControllerField;
  final TextEditingController thirdControllerField;
  final TextEditingController fourthControllerField;
  final TextEditingController fifthControllerField;
  final TextEditingController sixthControllerField;
  final IconData icon;
  final String message;
  final Function()? onTapResend;
  final Function() onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: otpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(60),
                const AuthHeaderWidget(
                    showArrow: true, headTitle: '', heightSpace: 0),
                Icon(
                  icon,
                  color: Colors.blue,
                  size: 80,
                ),
                addVerticalSpace(32),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                addVerticalSpace(30),
                OTPCodeWidget(
                    firstControllerField: firstControllerField,
                    secoundControllerField: secoundControllerField,
                    thirdControllerField: thirdControllerField,
                    fourthControllerField: fourthControllerField,
                    fifthControllerField: fifthControllerField,
                    sixthControllerField: sixthControllerField),
                addVerticalSpace(37),
                RichTextWidget(
                  left: 'Didn\'t get the code?',
                  right: ' Resend',
                  onTap: onTapResend,
                ),
                addVerticalSpace(60),
                ButtonWidget(
                  text: 'Verify',
                  visible: context.watch<AuthController>().loading,
                  onPressed: onPressedButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
