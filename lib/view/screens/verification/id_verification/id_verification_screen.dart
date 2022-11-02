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
                          valueVer.selected ?? 'Choose your document type',
                          style: valueVer.selected == null
                              ? const TextStyle(
                                  color: Color.fromARGB(255, 172, 171, 171))
                              : null,
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                  onSelected: (valuee) {
                    valueVer.setSelected(valuee);
                    print(valueVer.documentType.keys.firstWhere(
                      (k) => valueVer.documentType[k] == valueVer.selected,
                    ));
                  },
                  itemBuilder: (context) {
                    return valueVer.documentType.values.map((e) {
                      return PopupMenuItem(
                        height: 35,
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList();
                  },
                ),
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
                valueVer.paths == null
                    ? ElevatedButton(
                        onPressed: () {
                          valueVer.pickFile();
                        },
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // ignore: sort_child_properties_last
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  '${valueVer.fileName}\n' +
                                      getFileSize(
                                          valueVer.paths!.first.size, 2),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                      alignment: Alignment.centerRight,
                                      onPressed: () {
                                        valueVer.clearCachedFiles();
                                      },
                                      icon: const Icon(
                                          Icons.disabled_by_default_outlined)),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: !valueVer.validFile
                                        ? Colors.red
                                        : Colors.transparent)),
                          ),
                          Row(
                            children: [
                              Visibility(
                                  visible: !valueVer.validFile,
                                  child: Text('Your file is too big. ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 12,
                                              color: Colors.red))),
                              Text(
                                '2 MP maximum',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          )
                        ],
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
