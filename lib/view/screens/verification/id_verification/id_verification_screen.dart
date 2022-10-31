import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/utils/validation.dart';
import 'package:tanlants_valley_application/view/screens/verification/verification_screen.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/auth_header_widget.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';

import '../../../../storage/sherd_perf.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  String? selected;
  TextEditingController idNumberController = TextEditingController();
  FocusNode idNumberNode = FocusNode();

  @override
  void dispose() {
    idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25,
              ));
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.account_box_outlined,
                  color: Colors.blue,
                  size: 80,
                ),
              ),
              addVerticalSpace(20),
              Text(
                  'Upload Document that Proof your Identity\nSuch as:\nIdentity Card, Passport, Driver License'),
              addVerticalSpace(25),
              Text(
                'Document Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              addVerticalSpace(4),
              PopupMenuButton<String>(
                offset: const Offset(0, 45),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 64,
                  maxWidth: double.infinity,
                ),
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.lightgrey)),
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selected ?? 'Choose your document type',
                        style: selected == null
                            ? const TextStyle(
                                color: Color.fromARGB(255, 172, 171, 171))
                            : null,
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      height: 35,
                      value: 'Identity Card',
                      child: Text(
                        'Identity Card',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      height: 35,
                      value: 'Passport',
                      child: Text(
                        'Passport',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      height: 35,
                      value: 'Driver License',
                      child: Text(
                        'Driver License',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ];
                },
              ),
              addVerticalSpace(16),
              TextFormFieldWidget(
                hintText: 'Enter your ID number',
                title: 'ID Number',
                controller: idNumberController,
                focusNode: idNumberNode,
                messageKey: "phoneNumber",
                messageValue: isValidId,
              ),
              addVerticalSpace(32),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: AppColor.lightgrey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.file_upload_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    Text(
                      ' Upload a File',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(58),
              ElevatedButtonWithDisapleWidget(
                loaderVisisble: false,
                onPressed: () {},
                visisble: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
