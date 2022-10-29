// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tanlants_valley_application/utils/constant_utils.dart';
// import '../../../utils/validation.dart';
// import 'package:provider/provider.dart';

// void main(List<String> args) {
//   runApp(ChangeNotifierProvider(
//       create: (context) => FormValidation(), child: TextTextForm1()));
// }

// class TextTextForm1 extends StatefulWidget {
//   const TextTextForm1({super.key});

//   @override
//   State<TextTextForm1> createState() => _TextTextFormState();
// }

// class _TextTextFormState extends State<TextTextForm1> {
//   TextEditingController counteryController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();

//   FocusNode countyFoucse = FocusNode();
//   FocusNode phoneFoucse = FocusNode();

//   GlobalKey<FormState> formKey = GlobalKey();
//   bool visisble = false;

//   // String? Counrtyerror;
//   // String? Phoneerror;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Consumer<FormValidation>(
//           builder: (context, errorProvider, child) => Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // TextFormFieldWidget(
//                 //   controller: counteryController,
//                 //   title: 'email', focusNode:countyFoucse , messageKey: "email", messageValue: counteryController.text.isValidEmail),
//                 // TextFormFieldWidget(
//                 //   controller: phoneController,
//                 //     title: 'password',
//                 //     focusNode: phoneFoucse,
//                 //     messageKey: "password",
//                 //     messageValue:  phoneController.text.isValidPassword),

//                 CustomTextField(
//                     controller: counteryController,
//                     focusNode: countyFoucse,
//                     messageKey: "email",
//                     messageValue: counteryController.text.isValidEmail),
//                 CustomTextField(
//                     controller: phoneController,
//                     focusNode: phoneFoucse,
//                     messageKey: "password",
//                     messageValue: phoneController.text.isValidPassword),
//                 // TextFormField(
//                 //   controller: counteryController,
//                 //   focusNode: countyFoucse,
//                 //   validator: (value) {
//                 //     return value!.isValidEmail;
//                 //   },
//                 //   onChanged: (value) {
//                 //     countyFoucse.addListener(() {
//                 //       if (!countyFoucse.hasFocus) {
//                 //         errorProvider.setErrorMessage(
//                 //             "email", value.isValidEmail);
//                 //         // setState(() {
//                 //         //   Counrtyerror = value.isValidEmail;
//                 //         // });
//                 //       }
//                 //       if (countyFoucse.hasFocus) {
//                 //         errorProvider.setErrorMessage("email", null);
//                 //         // setState(() {
//                 //         //   Counrtyerror = null;
//                 //         // });
//                 //       }
//                 //     });
//                 //   },
//                 //   decoration: InputDecoration(
//                 //     hintText: 'country',
//                 //     errorText: errorProvider.errorMessages["email"],
//                 //   ),
//                 // ),
//                 // addVerticalSpace(20),

//                 // addVerticalSpace(20),
//                 ElevatedButton(
//                     onPressed: () {
//                       formKey.currentState!.validate();
//                     },
//                     child: Text('send'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FormValidation extends ChangeNotifier {
//   Map<String, String?> errorMessages = {
//     "email": null,
//     "password": null,
//   };
//   setErrorMessage(String key, String? value) {
//     errorMessages[key] = value;
//     notifyListeners();
//   }
// }

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.messageKey,
//     required this.messageValue,
//   });
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final String? messageValue;
//   final String messageKey;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FormValidation>(
//       builder: (context, errorProvider, child) => TextFormField(
//         controller: controller,
//         focusNode: focusNode,
//         validator: (value) {
//           return value!.isValidEmail;
//         },
//         onChanged: (value) {
//           focusNode.addListener(() {
//             if (!focusNode.hasFocus) {
//               print('out');
//               errorProvider.setErrorMessage(messageKey, messageValue);
//               // setState(() {
//               //   Counrtyerror = value.isValidEmail;
//               // });
//             }
//             if (focusNode.hasFocus) {
//               print('in');

//               errorProvider.setErrorMessage(messageKey, null);
//               // setState(() {
//               //   Counrtyerror = null;
//               // });
//             }
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'country',
//           errorText: errorProvider.errorMessages[messageKey],
//         ),
//       ),
//     );
//   }
// }
