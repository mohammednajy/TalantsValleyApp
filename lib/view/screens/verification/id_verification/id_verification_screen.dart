import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/data/controller/verification_controller.dart';
import 'package:tanlants_valley_application/data/network/api/auth_api.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/utils/validation.dart';
import 'package:tanlants_valley_application/view/screens/verification/verification_screen.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../address_verification/address_verification_screen.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  // String? selected;
  TextEditingController idNumberController = TextEditingController();
  FocusNode idNumberNode = FocusNode();
  GlobalKey<FormFieldState> idKey = GlobalKey();
  @override
  void dispose() {
    idNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
          child: Consumer<VerificationController>(
            builder: (context, valueVer, child) => Column(
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
                const Text(
                    'Upload Document that Proof your Identity\nSuch as:\nIdentity Card, Passport, Driver License'),
                addVerticalSpace(25),
                PopUpVerificationWidget(
                    title: 'Document Type',
                    selected: valueVer.selected,
                    onSelected: (valuee) {
                      valueVer.setSelected(valuee);
                    },
                    documentType: valueVer.documentType),
                addVerticalSpace(16),
                TextFormFieldWidget(
                  textInputAction: TextInputAction.done,
                  hintText: 'Enter your ID number',
                  title: 'ID Number',
                  controller: idNumberController,
                  focusNode: idNumberNode,
                  messageKey: "phoneNumber",
                  messageValue: isValidId,
                  textKey: idKey,
                ),
                addVerticalSpace(32),
                FileWidget(
                  paths: valueVer.paths,
                  onPressed: () {
                    valueVer.pickFile();
                  },
                  addressMessage: false,
                  fileName: valueVer.fileName ?? '',
                  fileSize: getFileSize(valueVer.paths?.first.size ?? 0, 2),
                  onPressedClear: () {
                    valueVer.clearCachedFiles();
                  },
                  vaildFile: valueVer.validFile,
                ),
                addVerticalSpace(58),
                ElevatedButtonWithDisapleWidget(
                  loaderVisisble: context.watch<AuthController>().loading,
                  onPressed: () {
                    if (idKey.currentState!.validate()) {
                      valueVer.verifyId(
                          documentType: valueVer.documentType.keys.firstWhere(
                            (k) =>
                                valueVer.documentType[k] == valueVer.selected,
                          ),
                          idNumber: idNumberController.text,
                          token: SharedPrefController().getUser().accessToken,
                          file: valueVer.file);
                    }
                  },
                  visisble: !valueVer.disableButton.contains(false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFileSize(int bytes, int decimals) {
    print(bytes);

    // ignore: prefer_interpolation_to_compose_strings
    String result =
        (0.00000095367432 * bytes).toStringAsFixed(decimals) + ' ' + "MB";
    return result;
  }
}

class PopUpVerificationWidget extends StatelessWidget {
  const PopUpVerificationWidget(
      {super.key,
      required this.title,
      required this.selected,
      required this.onSelected,
      required this.documentType});
  final String title;
  final String? selected;
  final Function(String)? onSelected;
  final Map<String, String> documentType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        addVerticalSpace(4),
        PopupMenuButton<String>(
          offset: const Offset(0, 45),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 64,
            maxWidth: double.infinity,
          ),
          onSelected: onSelected,
          itemBuilder: (context) {
            return documentType.values.map((e) {
              return PopupMenuItem(
                height: 35,
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList();
          },
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.lightgrey)),
            height: 55.h,
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
        )
      ],
    );
  }
}
