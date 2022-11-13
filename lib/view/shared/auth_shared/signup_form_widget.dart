import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/counrty_controller.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import '../../../data/controller/auth_controller.dart';
import '../../../data/models/country_model.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/validation.dart';
import 'error_message_widget.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    Provider.of<CounteryController>(context, listen: false).countries();
    Provider.of<AuthController>(context, listen: false).errorMessage = "";
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    phoneNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounteryController>(
      builder: (context, value, child) => Form(
        key: signupKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    textInputType: TextInputType.text,
                    title: 'First Name',
                    controller: firstNameController,
                    hintText: 'Enter first name',
                    focusNode: firstNameNode,
                    messageKey: "firsName",
                    messageValue: isValidName,
                  ),
                ),
                addHorizontalSpace(24),
                Expanded(
                  child: TextFormFieldWidget(
                    textInputType: TextInputType.text,
                    title: 'Last Name',
                    controller: lastNameController,
                    hintText: 'Enter last name',
                    focusNode: lastNameNode,
                    messageKey: "lastName",
                    messageValue: isValidName,
                  ),
                ),
              ],
            ),
            addVerticalSpace(16),
            TextFormFieldWidget(
              textInputType: TextInputType.emailAddress,
              title: 'Email',
              hintText: 'email@gmail.com',
              controller: emailController,
              focusNode: emailNode,
              messageKey: "email",
              messageValue: isValidEmail,
            ),
            addVerticalSpace(16),
            TextFormFieldWidget(
              obscureIcon: true,
              title: 'Password',
              showStrongMessage: true,
              controller: passwordController,
              focusNode: passwordNode,
              messageKey: "password",
              messageValue: isValidPassword,
            ),
            addVerticalSpace(16),
            Text(
              'Phone Number',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            addVerticalSpace(5),
            Row(
              children: [
                const PhoneNumberWidget(),
                Expanded(
                    child: TextFormFieldWidget(
                  textInputType: TextInputType.phone,
                  maxLength: 9,
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
                    child: Text(
                      value.selectedPhoneNumber?.dialCode ?? "+972",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  leftBorder: true,
                  title: '',
                  controller: phoneController,
                  focusNode: phoneNode,
                  messageKey: "phoneNumber",
                  messageValue: isValidPhone,
                ))
              ],
            ),
            addVerticalSpace(16),
            Text(
              'Country',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            addVerticalSpace(5),
            DropdownButtonFormField<String>(
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                menuMaxHeight: 150,
                validator: (value) {
                  if (value == null) {
                    return "";
                  }
                  if (value.isEmpty) {
                    return "";
                  }
                },
                onChanged: (String? newValue) {
                  value.setSelectedCounrty(newValue);
                },
                items: value.result.map((e) {
                  return DropdownMenuItem(
                    value: e.name,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.name,
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }).toList()),
            ErrorMessageWidget(
              visibility: context.watch<AuthController>().errorMessage != "",
              message: context.watch<AuthController>().errorMessage,
            ),
            addVerticalSpace(40),
            Consumer<AuthController>(
              builder: (context, authcontroller, child) => ButtonWidget(
                  text: 'Sign Up',
                  visible: authcontroller.loading,
                  onPressed: () {
                    if (signupKey.currentState!.validate()) {
                      authcontroller.signUp(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phoneNumber: value.selectedPhoneNumber == null
                            ? "+972${phoneController.text}"
                            : "${value.selectedPhoneNumber!.dialCode}${phoneController.text}",
                        countery: value.selectedCounrty!,
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CounteryController>(
        builder: (context, value, child) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColor.lightgrey),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
              width: 80.w,
              height: 52.h,
              child: PopupMenuButton<CounteryModel>(
                  offset: Offset(5.w, 45.h),
                  onSelected: (select) {
                    value.setSelectedPhone(select);
                  },
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  itemBuilder: (context) {
                    return value.result
                        .map((e) {
                          return PopupMenuItem(
                            padding: const EdgeInsets.all(8),
                            value: e,
                            child: Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                          );
                        })
                        .toList()
                        .cast();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value.selectedPhoneNumber?.flag ?? "🇵🇸",
                        style: const TextStyle(fontSize: 30),
                      ),
                      const Icon(Icons.expand_more)
                    ],
                  )),
            ));
  }
}
