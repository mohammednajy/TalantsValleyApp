import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/utils/validation.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/error_message_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import 'package:provider/provider.dart';
import '../../../shared/auth_shared/text_field_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, this.recoveryToken});
  final String? recoveryToken;
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  FocusNode passwordNode = FocusNode();
  FocusNode confirmNode = FocusNode();
  TextEditingController confirmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.recoveryToken.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              addVerticalSpace(60),
              const AuthHeaderWidget(
                headTitle: 'Create New Password',
                heightSpace: 60,
                showArrow: true,
                fontSize: 20,
              ),
              addVerticalSpace(50),
              TextFormFieldWidget(
                showStrongMessage: true,
                obscureIcon: true,
                title: 'New Password',
                controller: passwordController,
                focusNode: passwordNode,
                messageKey: "password",
                messageValue: isValidPassword,
                hintText: "****************",
              ),
              addVerticalSpace(20),
              TextFormFieldWidget(
                obscureIcon: true,
                title: 'Re-Enter Password',
                controller: confirmController,
                focusNode: confirmNode,
                messageKey: "confirmPassword",
                messageValue: confirmPassword,
                hintText: "****************",
              ),
              ErrorMessageWidget(
                visibility: context.watch<AuthController>().errorMessage != "",
                message: context.watch<AuthController>().errorMessage,
              ),
              addVerticalSpace(64),
              ButtonWidget(
                  text: 'Confirm',
                  visible: context.watch<AuthController>().loading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthController>().createNewPassword(
                          password: passwordController.text,
                          recoverToken: widget.recoveryToken ?? 'defult');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
