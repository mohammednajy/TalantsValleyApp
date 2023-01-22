import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_details_controller.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/validation.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../../../../data/controller/user_management_controller/transfers_controller.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../shared/user_managment_shared/custom_appBar_back.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode numberNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    accountNameController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarWithBack(title: 'Add Bank Account'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  90,
              child: Consumer2<TransfersController, UserDetailsController>(
                builder: (context, providerValueTransfer, providerValueDetails,
                        child) =>
                    Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Freelancer Name',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14),
                          ),
                          addVerticalSpace(5),
                          TextFormField(
                            enabled: false,
                            controller: TextEditingController(
                                text:
                                    '${providerValueDetails.userDetailsInfo?.firstName ?? ''} ${providerValueDetails.userDetailsInfo?.lastName ?? ''}'),
                            decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColor.lightgrey,
                              ),
                            )),
                          ),
                        ],
                      ),
                      TextFormFieldWidget(
                        title: 'Account Holder Full Name',
                        controller: accountNameController,
                        focusNode: nameNode,
                        messageKey: "",
                        messageValue: isNotEmpty,
                      ),
                      DdbWidget(
                        title: 'Branch',
                        dataList: providerValueTransfer.branchList,
                        onChanged: (value) {
                          providerValueTransfer.onSelecteBranch(value);
                        },
                      ),
                      TextFormFieldWidget(
                        title: 'Account Number',
                        controller: accountNumberController,
                        focusNode: numberNode,
                        messageKey: " ",
                        messageValue: isNotEmpty,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Currency',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14),
                          ),
                          addVerticalSpace(5),
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                hintText: '1 - USD',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColor.lightgrey,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      DdbWidget(
                          title: 'Ledger',
                          dataList: providerValueTransfer.ledgerList,
                          onChanged: (value) {
                            providerValueTransfer.onSelecteLedger(value);
                          }),
                      ButtonWidget(
                          text: 'Confirm',
                          visible: false,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              providerValueTransfer.addBankAccount(
                                token: SharedPrefController()
                                    .getUser()
                                    .accessToken,
                                freelancerId:
                                    providerValueDetails.userDetailsInfo?.id ??
                                        '',
                                accountName: accountNameController.text,
                                accountNumber: accountNumberController.text,
                                bankBranch: providerValueTransfer.branch ?? '',
                                ledger: providerValueTransfer.ledger ?? '',
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class DdbWidget extends StatelessWidget {
  const DdbWidget({
    Key? key,
    required this.title,
    required this.dataList,
    this.onChanged,
  }) : super(key: key);
  final String title;
  final List<String> dataList;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        ),
        addVerticalSpace(5),
        DropdownButtonFormField(
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            items: dataList
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
            onChanged: onChanged)
      ],
    );
  }
}
