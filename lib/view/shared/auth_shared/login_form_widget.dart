import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import '../../../utils/validation.dart';
import '../../../utils/constant_utils.dart';
import 'package:provider/provider.dart';

import 'error_message_widget.dart';

class SignInFormWidget extends StatefulWidget {
  const SignInFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  GlobalKey<FormState> signinKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(context, listen: false).errorMessage = "";
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signinKey,
      child: Consumer<AuthController>(
        builder: (context, authProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              title: 'Email',
              hintText: 'email@gmail.com',
              controller: emailController,
              focusNode: emailNode,
              messageKey: "email",
              messageValue: isValidEmail,
            ),
            addVerticalSpace(24),
            TextFormFieldWidget(
              obscureIcon: true,
              title: 'Password',
              controller: passwordController,
              focusNode: passwordNode,
              messageKey: "password",
              messageValue: isValidPassword,
              textInputAction: TextInputAction.done,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ErrorMessageWidget(
                visibility: authProvider.errorMessage != "",
                message: authProvider.errorMessage,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 20),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight),
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 13),
                ),
                onPressed: () {
                  AppRouter.goTo(ScreenName.forgetScreen);
                },
              ),
            ]),
            addVerticalSpace(60),
            ButtonWidget(
                text: 'Sign In',
                visible: context.watch<AuthController>().loading,
                onPressed: () {
                  authProvider.login(
                      email: emailController.text,
                      password: passwordController.text,
                      signinKey: signinKey);
                })
          ],
        ),
      ),
    );
  }
}
