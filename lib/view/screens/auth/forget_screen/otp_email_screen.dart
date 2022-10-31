import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/error_message_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/rich_text_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import 'package:provider/provider.dart';
import '../../../../data/controller/auth_controller.dart';
import '../../../../router/router.dart';
import '../../../../utils/constant_utils.dart';
import '../../../shared/auth_shared/otp_widget.dart';

class OtpEmailScreen extends StatefulWidget {
  const OtpEmailScreen({
    super.key,
    this.id,
    this.email,
  });

  final String? id;
  final String? email;

  @override
  State<OtpEmailScreen> createState() => _OtpEmailScreenState();
}

class _OtpEmailScreenState extends State<OtpEmailScreen> {
  final TextEditingController _firstControllerField = TextEditingController();
  final TextEditingController _secoundControllerField = TextEditingController();
  final TextEditingController _thirdControllerField = TextEditingController();
  final TextEditingController _fourthControllerField = TextEditingController();
  final TextEditingController _fifthControllerField = TextEditingController();
  final TextEditingController _sixthControllerField = TextEditingController();

  final GlobalKey<FormState> otpKey = GlobalKey();
  @override
  void dispose() {
    _firstControllerField.dispose();
    _secoundControllerField.dispose();
    _thirdControllerField.dispose();
    _fourthControllerField.dispose();
    _fifthControllerField.dispose();
    _sixthControllerField.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(context, listen: false).errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: otpKey,
            child: Column(
              children: [
                addVerticalSpace(60),
                const AuthHeaderWidget(
                  headTitle: 'Check Your Email',
                  heightSpace: 56,
                  showArrow: true,
                  fontSize: 20,
                ),
                addVerticalSpace(30),
                Text(
                  'We have sent you an email that contains a code to reset your password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                addVerticalSpace(38),
                OTPCodeWidget(
                  firstControllerField: _firstControllerField,
                  secoundControllerField: _secoundControllerField,
                  thirdControllerField: _thirdControllerField,
                  fourthControllerField: _fourthControllerField,
                  fifthControllerField: _fifthControllerField,
                  sixthControllerField: _sixthControllerField,
                ),
                ErrorMessageWidget(
                  visibility:
                      context.watch<AuthController>().errorMessage != "",
                  message: context.watch<AuthController>().errorMessage,
                ),
                addVerticalSpace(56),
                ButtonWidget(
                    text: 'Continue',
                    visible: context.watch<AuthController>().loading,
                    onPressed: () {
                      if (otpKey.currentState!.validate()) {
                        String code = _firstControllerField.text +
                            _secoundControllerField.text +
                            _thirdControllerField.text +
                            _fourthControllerField.text +
                            _fifthControllerField.text +
                            _sixthControllerField.text;
                        context
                            .read<AuthController>()
                            .sendOtpCode(id: widget.id ?? "defult", code: code);
                      }
                    }),
                addVerticalSpace(50),
                RichTextWidget(
                  left: 'Didn\'t get the code?',
                  right: ' Resend',
                  onTap: () {
                    Provider.of<AuthController>(
                            AppRouter.navigationKey.currentContext!,
                            listen: false)
                        .endLoading();
                    context
                        .read<AuthController>()
                        .forgetPasswordResend(email: widget.email ?? 'defult');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
