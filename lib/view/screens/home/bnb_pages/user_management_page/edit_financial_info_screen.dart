import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import 'package:tanlants_valley_application/view/shared/auth_shared/text_field_widget.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';
import '../../../../../utils/validation.dart';

class EditFinancialInfoScreen extends StatefulWidget {
  const EditFinancialInfoScreen({super.key});
  @override
  State<EditFinancialInfoScreen> createState() =>
      _EditFinancialInfoScreenState();
}

class _EditFinancialInfoScreenState extends State<EditFinancialInfoScreen> {
  TextEditingController textEditingControllerBalance = TextEditingController();
  TextEditingController textEditingControllerRevenue = TextEditingController();
  TextEditingController textEditingControllerProfit = TextEditingController();
  FocusNode balanceNode = FocusNode();
  FocusNode profitNode = FocusNode();
  FocusNode revenueNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    textEditingControllerBalance.text = context
            .read<UserDetailsController>()
            .userDetailsInfo
            ?.balance
            .toString() ??
        '00';
    textEditingControllerRevenue.text = context
            .read<UserDetailsController>()
            .userDetailsInfo
            ?.revenue
            .toString() ??
        '00';
    textEditingControllerProfit.text = context
            .read<UserDetailsController>()
            .userDetailsInfo
            ?.profit
            .toString() ??
        '00';
  }

  @override
  void dispose() {
    textEditingControllerBalance.dispose();
    textEditingControllerRevenue.dispose();
    textEditingControllerProfit.dispose();
    balanceNode.dispose();
    profitNode.dispose();
    revenueNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithBack(title: 'Edit'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 31),
        child: Consumer<UserDetailsController>(
          builder: (context, userProvider, child) => Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                            title: 'Balance',
                            controller: textEditingControllerBalance,
                            focusNode: balanceNode,
                            messageKey: "balance",
                            messageValue: isNumber,
                            textInputType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.disabled,
                          ),
                          addVerticalSpace(16),
                          TextFormFieldWidget(
                              title: 'Profit',
                              controller: textEditingControllerProfit,
                              focusNode: profitNode,
                              messageKey: "profit",
                              messageValue: isNumber,
                              autovalidateMode: AutovalidateMode.disabled,
                              textInputType: TextInputType.number)
                        ],
                      ),
                    ),
                    addHorizontalSpace(66),
                    Expanded(
                      child: TextFormFieldWidget(
                          title: 'Revenue',
                          controller: textEditingControllerRevenue,
                          focusNode: revenueNode,
                          messageKey: "revenue",
                          messageValue: isNumber,
                          autovalidateMode: AutovalidateMode.disabled,
                          textInputType: TextInputType.number),
                    ),
                  ],
                ),
                addVerticalSpace(60),
                ButtonWidget(
                  text: 'Set',
                  visible: false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      userProvider.editFinancialInfo(
                        token: SharedPrefController().getUser().accessToken,
                        id: userProvider.userDetailsInfo!.id,
                        profit: int.parse(textEditingControllerProfit.text),
                        balance: int.parse(textEditingControllerBalance.text),
                        revenue: int.parse(textEditingControllerRevenue.text),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
