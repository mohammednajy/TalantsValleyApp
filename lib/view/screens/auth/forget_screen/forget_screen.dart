import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/error_message_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constant_utils.dart';
import '../../../../utils/validation.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  GlobalKey<FormFieldState> emailKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
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
          child: Column(
            children: [
              addVerticalSpace(60),
              const AuthHeaderWidget(
                headTitle: 'Forgot Password?',
                heightSpace: 56,
                showArrow: true,
                fontSize: 20,
              ),
              addVerticalSpace(30),
              Text(
                'We\'ll send a code to your email to reset password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              addVerticalSpace(38),
              TextFormFieldWidget(
                title: 'Email',
                hintText: 'email@gmail.com',
                textKey: emailKey,
                controller: emailController,
                focusNode: emailNode,
                messageKey: "email",
                messageValue: isValidEmail,
              ),
              ErrorMessageWidget(
                visibility: context.watch<AuthController>().errorMessage != "",
                message: context.watch<AuthController>().errorMessage,
              ),
              addVerticalSpace(56),
              ButtonWidget(
                  text: 'Send code',
                  visible: context.watch<AuthController>().loading,
                  onPressed: () {
                    if (emailKey.currentState!.validate()) {
                      context
                          .read<AuthController>()
                          .forgetPassword(email: emailController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
