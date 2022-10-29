// import 'package:flutter/material.dart';
// import 'package:tanlants_valley_application/data/controller/counrty_controller.dart';
// import 'package:tanlants_valley_application/utils/constant_utils.dart';
// import '../../../utils/validation.dart';

// class TextTextForm extends StatefulWidget {
//   const TextTextForm({super.key});

//   @override
//   State<TextTextForm> createState() => _TextTextFormState();
// }

// class _TextTextFormState extends State<TextTextForm> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController counteryController = TextEditingController();
//   FocusNode emailFoucse = FocusNode();
//   FocusNode passwordFoucse = FocusNode();
//   FocusNode countyFoucse = FocusNode();

//   GlobalKey<FormFieldState> emailKey = GlobalKey();
//   GlobalKey<FormFieldState> passwordKey = GlobalKey();

//   GlobalKey<FormState> formKey = GlobalKey();
//   bool visisble = false;

//   String? error;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               key: emailKey,
//               validator: (value) {
//                 return value!.isValidEmail;
//               },
//               controller: email,
//               focusNode: emailFoucse,
//               onChanged: (value) {
//                 emailFoucse.addListener(() {
//                   if (!emailFoucse.hasFocus) {
//                     emailKey.currentState!.validate();
//                   }
//                 });
//               },
//               decoration: InputDecoration(hintText: 'email'),
//             ),
//             addVerticalSpace(10),
//             TextFormField(
//               key: passwordKey,
//               controller: password,
//               focusNode: passwordFoucse,
//               validator: (value) {
//                 return value!.isValidPassword;
//               },
//               onChanged: (value) {
//                 passwordFoucse.addListener(() {
//                   if (!passwordFoucse.hasFocus) {
//                     passwordKey.currentState!.validate();
//                   }
//                 });
//                 if (password.text.isValidPassword == null) {
//                   setState(() {
//                     visisble = true;
//                   });
//                 }
//                 if (password.text.isValidPassword != null) {
//                   setState(() {
//                     visisble = false;
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'password',
//               ),
//             ),
//             Visibility(visible: visisble, child: Text('strogn')),
//             addVerticalSpace(10),
//             TextFormField(
//               controller: counteryController,
//               focusNode: countyFoucse,
//               validator: (value) {
//                 if (value == "m") {
//                   return "error";
//                 }
//               },
//               onChanged: (value) {
//                 countyFoucse.addListener(() {
//                   if (!countyFoucse.hasFocus) {
//                     setState(() {
//                       error = value.isValidEmail;
//                     });
//                   }
//                   if (countyFoucse.hasFocus) {
//                     setState(() {
//                       error = null;
//                     });
//                   }
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'country',
//                 errorText: error,
//               ),
//             ),
//             addVerticalSpace(20),
//             ElevatedButton(
//                 onPressed: () {
//                   formKey.currentState!.validate();
//                 },
//                 child: Text('send'))
//           ],
//         ),
//       ),
//     );
//   }
// }
