import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/verification_controller.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/utils/validation.dart';
import 'package:tanlants_valley_application/view/screens/verification/id_verification/id_verification_screen.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';

import '../../../../data/controller/auth_controller.dart';
import '../verification_screen.dart';

class AddressVerificationScreen extends StatefulWidget {
  const AddressVerificationScreen({super.key});

  @override
  State<AddressVerificationScreen> createState() =>
      _AddressVerificationScreenState();
}

class _AddressVerificationScreenState extends State<AddressVerificationScreen> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  FocusNode focusNodeAddress1 = FocusNode();
  FocusNode focusNodeAddress2 = FocusNode();
  FocusNode cityNodeAddress = FocusNode();
  FocusNode counrtyNodeAddress = FocusNode();
  GlobalKey<FormState> addressKey = GlobalKey();
  @override
  void dispose() {
    address1Controller.dispose();
    address2Controller.dispose();
    focusNodeAddress1.dispose();
    focusNodeAddress2.dispose();
    cityNodeAddress.dispose();
    counrtyNodeAddress.dispose();
    cityController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              alignment: Alignment.centerRight,
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
        child: Consumer<VerificationController>(
          builder: (context, value, child) => SingleChildScrollView(
            child: Form(
              key: addressKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(AssetPath.verifiyAddressIcon),
                  ),
                  addVerticalSpace(25),
                  const Text(
                      'Upload Document that Proof your Address\nSuch as:\nBill (Phone, Electricity, Water, Bank statement)'),
                  addVerticalSpace(15),
                  PopUpVerificationWidget(
                      title: 'Document Type',
                      selected: value.selectedAddress,
                      onSelected: (valuee) {
                        value.setSelectedAddress(valuee);
                      },
                      documentType: value.documentTypeAddress),
                  addVerticalSpace(16),
                  TextFormFieldWidget(
                    title: 'Address 1',
                    controller: address1Controller,
                    focusNode: focusNodeAddress1,
                    messageKey: "address1",
                    messageValue: isNotEmpty,
                    hintText: 'Neighborhood, building..',
                  ),
                  addVerticalSpace(16),
                  TextFormFieldWidget(
                    title: 'Address 2',
                    controller: address2Controller,
                    focusNode: focusNodeAddress2,
                    messageKey: "address2",
                    messageValue: isNotEmpty,
                    hintText: 'Street',
                  ),
                  addVerticalSpace(16),
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
                        child: TextFormFieldWidget(
                          title: 'Country',
                          controller: countryController,
                          focusNode: counrtyNodeAddress,
                          messageKey: "country",
                          messageValue: isNotEmpty,
                          textInputAction: TextInputAction.done,
                        ),
                      )
                    ],
                  ),
                  addVerticalSpace(24),
                  FileWidget(
                    paths: value.paths,
                    onPressed: () {
                      value.pickFile();
                    },
                    addressMessage: true,
                    fileName: value.fileName ?? '',
                    fileSize: getFileSize(value.paths?.first.size ?? 0, 2),
                    onPressedClear: () {
                      value.clearCachedFiles();
                    },
                    vaildFile: value.validFile,
                  ),
                  addVerticalSpace(15),
                  ElevatedButtonWithDisapleWidget(
                      loaderVisisble: context.watch<AuthController>().loading,
                      onPressed: () {
                        if (addressKey.currentState!.validate()) {
        
                          value.verifyAddress(
                            token: SharedPrefController().getUser().accessToken,
                            documentType:
                                value.documentTypeAddress.keys.firstWhere(
                              (k) =>
                                  value.documentTypeAddress[k] ==
                                  value.selectedAddress,
                            ),
                            address1: address1Controller.text,
                            address2: address2Controller.text,
                            city: cityController.text,
                            country: countryController.text,
                            file: value.file,
                          );
                        }
                      },
                      visisble: !value.disableAddressButton.contains(false)
                      //  !value.disableButton.contains(false),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getFileSize(int bytes, int decimals) {
    // ignore: prefer_interpolation_to_compose_strings
    String result =
        (0.00000095367432 * bytes).toStringAsFixed(decimals) + ' ' + "MB";
    return result;
  }
}

class FileWidget extends StatelessWidget {
  const FileWidget({
    super.key,
    required this.paths,
    required this.onPressed,
    this.addressMessage = false,
    required this.fileName,
    required this.fileSize,
    required this.onPressedClear,
    required this.vaildFile,
  });
  final List<PlatformFile>? paths;
  final Function()? onPressed;
  final bool addressMessage;
  final String fileName;
  final String fileSize;
  final Function()? onPressedClear;
  final bool vaildFile;
  @override
  Widget build(BuildContext context) {
    return paths == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: onPressed,
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
              addressMessage
                  ? const Text(
                      'Your document shouldn\'t be three months old',
                      style: TextStyle(fontSize: 12, height: 1),
                      textAlign: TextAlign.left,
                    )
                  : const SizedBox()
            ],
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
                      '$fileName\n' + fileSize,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: onPressedClear,
                          icon: const Icon(Icons.disabled_by_default_outlined)),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: !vaildFile ? Colors.red : Colors.transparent)),
              ),
              Row(
                children: [
                  Visibility(
                      visible: !vaildFile,
                      child: Text('Your file is too big. ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12, color: Colors.red))),
                  Text(
                    '2 MP maximum',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          );
  }
}
