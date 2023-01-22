import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/transfers_controller.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/approval_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_user_screen.dart';

import '../../../../../data/controller/counrty_controller.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';
import '../../../../../storage/sherd_perf.dart';
import '../../../../shared/user_managment_shared/colum_custom_financial.dart';
import '../../../../shared/user_managment_shared/custom_appBar_back.dart';
import '../../../../shared/user_managment_shared/custom_card_details_widget.dart';
import '../../../../shared/user_managment_shared/custom_transfer_widget.dart';
import '../../../../shared/user_managment_shared/rich_text_details_widget.dart';
import '../../../../shared/user_managment_shared/row_info_widget.dart';
import '../../../../shared/user_managment_shared/transaction_item_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsController>(
      builder: (context, userDetails, child) => Scaffold(
        appBar:
            CustomAppBarWithBack(title: userDetails.userDetailsInfo!.firstName),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomCardDetailsWidget(
                    cardTitle: 'Personal Information',
                    icon: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<CounteryController>(
                                      create: (context) => CounteryController(),
                                      child: const EditUserScreen(
                                          // userInfo: widget.userData
                                          )),
                            ));
                      },
                      child: const Text('Edit'),
                    ),
                    userDetailsData: Column(
                      children: [
                        RowInfoWidget(
                          leadingText: 'Full Name',
                          trailingWidget: Text(
                              '${userDetails.userDetailsInfo!.firstName} ${userDetails.userDetailsInfo!.lastName}'),
                        ),
                        addVerticalSpace(10),
                        RowInfoWidget(
                          leadingText: 'Email',
                          trailingWidget:
                              Text(userDetails.userDetailsInfo!.email),
                        ),
                        addVerticalSpace(10),
                        RowInfoWidget(
                          leadingText: 'Phone',
                          trailingWidget: Text(
                              userDetails.userDetailsInfo!.mobile ?? ' - '),
                        ),
                        addVerticalSpace(10),
                        RowInfoWidget(
                          leadingText: 'ID',
                          trailingWidget: userDetails
                                      .userDetailsInfo!.verifiedId["status"] ==
                                  "not_uploaded"
                              ? const Text('Not Uplodaded')
                              : RichTextDetailsWidget(
                                  firstText:
                                      '${userDetails.userDetailsInfo!.verifiedId["idNumber"] ?? ''} ',
                                  secoundText: userDetails.userDetailsInfo
                                              ?.verifiedId["status"] ==
                                          "approved"
                                      ? '  approved'
                                      : userDetails.userDetailsInfo
                                                  ?.verifiedId["status"] ==
                                              "rejected"
                                          ? 'Rejected '
                                          : userDetails.userDetailsInfo
                                              ?.verifiedId["idDocumentType"]
                                              .toString()
                                              .toUpperCase()
                                              .replaceAll("_", " "),
                                  thirdText: (userDetails.userDetailsInfo!
                                                  .verifiedId["status"] ==
                                              "approved" ||
                                          userDetails.userDetailsInfo!
                                                  .verifiedId["status"] ==
                                              "rejected")
                                      ? false
                                      : true,
                                  // ID Approval
                                  onTapApproval: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ApprovalScreen(
                                            type: "id",
                                          ),
                                        ));
                                  },
                                ),
                        ),
                        addVerticalSpace(10),
                        RowInfoWidget(
                          leadingText: 'Address',
                          trailingWidget: userDetails.userDetailsInfo!
                                      .verificationAddress["status"] ==
                                  "not_uploaded"
                              ? const Text('Not Uplodaded')
                              : RichTextDetailsWidget(
                                  firstText:
                                      '${userDetails.userDetailsInfo?.address!["address1"] ?? ''} - ${userDetails.userDetailsInfo?.address!["country"] ?? ''}',
                                  secoundText: userDetails.userDetailsInfo
                                              ?.verificationAddress["status"] ==
                                          "approved"
                                      ? '  approved'
                                      : userDetails.userDetailsInfo
                                                      ?.verificationAddress[
                                                  "status"] ==
                                              "rejected"
                                          ? " Rejected"
                                          : '',
                                  thirdText: (userDetails.userDetailsInfo!
                                                      .verificationAddress[
                                                  "status"] ==
                                              "approved" ||
                                          userDetails.userDetailsInfo!
                                                  .verificationAddress["status"] ==
                                              "rejected")
                                      ? false
                                      : true,
                                  onTapApproval: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ApprovalScreen(
                                            type: "address",
                                          ),
                                        ));
                                  }),
                        ),
                        addVerticalSpace(10),
                        RowInfoWidget(
                          leadingText: 'Role',
                          trailingWidget: Text(
                              userDetails.userDetailsInfo!.role == 0
                                  ? 'User'
                                  : 'Team'),
                        )
                      ],
                    )),
                CustomCardDetailsWidget(
                  cardTitle: 'Updatates',
                  icon: SizedBox(
                    height: 40.h,
                  ),
                  userDetailsData: Column(
                    children: [
                      RowInfoWidget(
                        leadingText: 'Created',
                        trailingWidget: Text(DateFormat.yMMMMd().format(
                            DateTime.parse(
                                userDetails.userDetailsInfo!.updatedAt))),
                      ),
                      addVerticalSpace(10),
                      RowInfoWidget(
                        leadingText: 'Last Login',
                        trailingWidget: Text(DateFormat.yMMMMd().format(
                            DateTime.parse(
                                userDetails.userDetailsInfo!.lastLogin))),
                      ),
                      addVerticalSpace(10),
                      RowInfoWidget(
                          leadingText: 'IP',
                          trailingWidget: GestureDetector(
                            onTap: () {
                              context.read<UserDetailsController>().userIP(
                                  token: SharedPrefController()
                                      .getUser()
                                      .accessToken,
                                  id: userDetails.userDetailsInfo!.id);
                            },
                            child: Text(
                              userDetails.userDetailsInfo!.lastLoginIP ??
                                  'No IP',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  decorationColor: Colors.blue,
                                  decorationThickness: 3),
                            ),
                          )),
                      addVerticalSpace(10),
                      RowInfoWidget(
                          leadingText: 'Transfers',
                          trailingWidget: Column(
                            children: [
                              CustomTransferWidget(
                                title: 'Bank',
                                data: userDetails.userTransfer!.bank.isEmpty
                                    ? "add"
                                    : '${userDetails.userTransfer?.bank["bank"]["bankName"] ?? ''}',
                                onTap: () {
                                  context
                                      .read<TransfersController>()
                                      .usrTransferCashBank(
                                          token: SharedPrefController()
                                              .getUser()
                                              .accessToken,
                                          id: userDetails.userDetailsInfo!.id,
                                          initialPage: 1);
                                },
                                onTapAdd: userDetails.userTransfer!.bank.isEmpty
                                    ? () {
                                        AppRouter.goTo(
                                            ScreenName.addBankScreen);
                                      }
                                    : null,
                              ),
                              CustomTransferWidget(
                                title: 'Cash',
                                data: userDetails.userTransfer!.cash.isEmpty
                                    ? " "
                                    : '${userDetails.userTransfer?.cash["office"]["name"] ?? ''}',
                                onTap: () {
                                  context
                                      .read<TransfersController>()
                                      .usrTransferCashBank(
                                          token: SharedPrefController()
                                              .getUser()
                                              .accessToken,
                                          id: userDetails.userDetailsInfo!.id,
                                          initialPage: 0);
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Financial Information',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColor.anotherGrey)),
                            IconButton(
                              onPressed: () {
                                AppRouter.goTo(
                                    ScreenName.editFinancialInfoScreen);
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColumCustomFinancial(
                                title: 'Balance',
                                data: userDetails.userDetailsInfo?.balance
                                        .toString() ??
                                    ''),
                            ColumCustomFinancial(
                                title: 'Revenue',
                                data: userDetails.userDetailsInfo?.revenue
                                        .toString() ??
                                    ''),
                            ColumCustomFinancial(
                                title: 'Profit',
                                data: userDetails.userDetailsInfo?.profit
                                        .toString() ??
                                    ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(5),
                CustomCardDetailsWidget(
                    cardTitle: 'Transactions',
                    icon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        )),
                    userDetailsData: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(color: Colors.grey),
                          ),
                          addVerticalSpace(10),
                          TransactionItemWidget(),
                          addVerticalSpace(17),
                          TransactionItemWidget(),
                          const Divider(
                            thickness: 2,
                            height: 35,
                          ),
                          const Text(
                            'Yesterday',
                            style: TextStyle(color: Colors.grey),
                          ),
                          addVerticalSpace(10),
                          TransactionItemWidget(),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 0, top: 0),
                                
                              ),
                              child: const Text(
                                'Show more',
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
