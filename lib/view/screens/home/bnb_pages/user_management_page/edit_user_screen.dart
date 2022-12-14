import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_management_controller.dart';
import 'package:tanlants_valley_application/data/models/user_details_model.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import '../../../../../data/controller/auth_controller.dart';
import '../../../../../data/controller/counrty_controller.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../../utils/validation.dart';
import '../../../../shared/auth_shared/error_message_widget.dart';
import '../../../../shared/auth_shared/signup_form_widget.dart';
import '../../../../shared/auth_shared/text_field_widget.dart';
import '../../../../shared/buttons/button_widget.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode idNumberNode = FocusNode();
  FocusNode focusNodeAddress1 = FocusNode();
  FocusNode focusNodeAddress2 = FocusNode();
  FocusNode cityNodeAddress = FocusNode();

  GlobalKey<FormState> editKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Provider.of<CounteryController>(context, listen: false).countries();
    firstNameController.text =
        context.read<UserDetailsController>().userDetailsInfo!.firstName;
    lastNameController.text =
        context.read<UserDetailsController>().userDetailsInfo!.lastName;
    emailController.text =
        context.read<UserDetailsController>().userDetailsInfo!.email;
    phoneController.text =
        context.read<UserDetailsController>().userDetailsInfo!.mobile ??
            'no mobile';
    idNumberController.text = context
            .read<UserDetailsController>()
            .userDetailsInfo!
            .verifiedId["idNumber"] ??
        '';
    address1Controller.text = context
            .read<UserDetailsController>()
            .userDetailsInfo!
            .address!["address1"] ??
        '';
    address2Controller.text = context
            .read<UserDetailsController>()
            .userDetailsInfo!
            .address!["address2"] ??
        '';
    cityController.text = context
            .read<UserDetailsController>()
            .userDetailsInfo!
            .address!["city"] ??
        '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        '${Provider.of<UserDetailsController>(context).userDetailsInfo?.firstName.toString()} provider');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'Edit',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerRight,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Consumer<CounteryController>(
        builder: (context, value, child) => Form(
          key: editKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  addVerticalSpace(15),
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
                  addVerticalSpace(14),
                  TextFormFieldWidget(
                    textInputType: TextInputType.emailAddress,
                    title: 'Email',
                    hintText: 'email@gmail.com',
                    controller: emailController,
                    focusNode: emailNode,
                    messageKey: "email",
                    messageValue: isValidEmail,
                  ),
                  addVerticalSpace(14),
                  Text(
                    'Phone Number',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 13),
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
                  addVerticalSpace(14),
                  TextFormFieldWidget(
                    textInputAction: TextInputAction.done,
                    hintText: 'Enter your ID number',
                    title: 'ID Number',
                    controller: idNumberController,
                    focusNode: idNumberNode,
                    messageKey: "phoneNumber",
                    messageValue: isValidId,
                  ),
                  addVerticalSpace(14),
                  TextFormFieldWidget(
                    title: 'Address 1',
                    controller: address1Controller,
                    focusNode: focusNodeAddress1,
                    messageKey: "address1",
                    messageValue: isNotEmpty,
                    hintText: 'Neighborhood, building..',
                  ),
                  addVerticalSpace(14),
                  TextFormFieldWidget(
                    title: 'Address 2',
                    controller: address2Controller,
                    focusNode: focusNodeAddress2,
                    messageKey: "address2",
                    messageValue: isNotEmpty,
                    hintText: 'Street',
                  ),
                  addVerticalSpace(14),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          title: 'City',
                          controller: cityController,
                          focusNode: cityNodeAddress,
                          messageKey: "city",
                          messageValue: isNotEmpty,
                        ),
                      ),
                      addHorizontalSpace(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Counrty',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 14),
                            ),
                            addVerticalSpace(5),
                            Consumer<CounteryController>(
                              builder: (context, value, child) =>
                                  DropdownButtonFormField<String>(
                                    
                                      icon: const Icon(Icons.expand_more),
                                      menuMaxHeight: 150,
                                      isExpanded: true,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "";
                                        }
                                      },
                                      hint: Text(
                                          Provider.of<UserDetailsController>(
                                                  context,
                                                  listen: false)
                                              .userDetailsInfo!
                                              .address!["country"]),
                                      // value: "Palestine",
                                      // value.selectedCounrty,
                                      items: value.result
                                          .map((e) => DropdownMenuItem(
                                                value: e.name,
                                                child: Text(
                                                  e.name.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        value.setSelectedCounrty(val);
                                      }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  ErrorMessageWidget(
                    visibility:
                        context.watch<AuthController>().errorMessage != "",
                    message: context.watch<AuthController>().errorMessage,
                  ),
                  addVerticalSpace(30),
                  Consumer<UserDetailsController>(
                    builder: (context, value, child) => ButtonWidget(
                      text: 'Save',
                      visible: Provider.of<AuthController>(context).loading,
                      onPressed: () {
                        value.editUser(
                            token: SharedPrefController().getUser().accessToken,
                            id: value.userDetailsInfo!.id,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            mobile: phoneController.text,
                            idNumber: idNumberController.text,
                            address1: address1Controller.text,
                            address2: address2Controller.text,
                            city: cityController.text,
                            country: Provider.of<CounteryController>(context,
                                        listen: false)
                                    .selectedCounrty ??
                                Provider.of<UserDetailsController>(context,
                                        listen: false)
                                    .userDetailsInfo!
                                    .address!["country"]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
