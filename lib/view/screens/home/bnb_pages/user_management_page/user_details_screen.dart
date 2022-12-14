import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/approval_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_user_screen.dart';

import '../../../../../data/controller/counrty_controller.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';
import '../../../../../storage/sherd_perf.dart';

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
    print(context.watch<UserDetailsController>().userTransfer?.cash ?? '');
    print(context.watch<UserDetailsController>().userTransfer?.bank ?? '');

    return Consumer<UserDetailsController>(
      builder: (context, userDetails, child) => Scaffold(
        appBar:
            CustomAppBarWithBack(title: userDetails.userDetailsInfo!.firstName),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        trailingWidget:
                            Text(userDetails.userDetailsInfo!.mobile ?? ' - '),
                      ),
                      addVerticalSpace(10),
                      RowInfoWidget(
                        leadingText: 'ID',
                        trailingWidget:
                            userDetails.userDetailsInfo!.verifiedId["status"] ==
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
                            userDetails.userDetailsInfo!.lastLoginIP ?? 'No IP',
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
                                AppRouter.goTo(ScreenName.transfersScreen);
                              },
                              onTapAdd: userDetails.userTransfer!.bank.isEmpty
                                  ? () {
                                      AppRouter.goTo(ScreenName.addBankScreen);
                                    }
                                  : null,
                            ),
                            CustomTransferWidget(
                              title: 'Cash',
                              data: userDetails.userTransfer!.cash.isEmpty
                                  ? " "
                                  : '${userDetails.userTransfer?.cash["office"]["name"] ?? ''}',
                              onTap: () {
                                AppRouter.goTo(ScreenName.transfersScreen);
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
                          ]),
                    ],
                  ),
                ),
              ),
              // RichTextDetailsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithBack({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      title: Text(
        title,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class CustomTransferWidget extends StatelessWidget {
  const CustomTransferWidget({
    required this.title,
    required this.data,
    required this.onTap,
    this.onTapAdd,
    Key? key,
  }) : super(key: key);
  final String title;
  final String data;
  final void Function()? onTap;
  final void Function()? onTapAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              title,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                  decorationColor: Colors.blue,
                  decorationThickness: 3),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: onTapAdd,
            child: Text(data,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 11, color: AppColor.anotherGrey)),
          ),
        )
      ],
    );
  }
}

class ColumCustomFinancial extends StatelessWidget {
  const ColumCustomFinancial({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 13, color: AppColor.anotherGrey),
        ),
        addVerticalSpace(5),
        Text('\$$data',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 13, color: AppColor.black))
      ],
    );
  }
}

class CustomCardDetailsWidget extends StatelessWidget {
  const CustomCardDetailsWidget({
    Key? key,
    required this.cardTitle,
    required this.icon,
    required this.userDetailsData,
  }) : super(key: key);
  final String cardTitle;
  final Widget icon;
  final Widget userDetailsData;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cardTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColor.anotherGrey)),
                icon
              ],
            ),
            userDetailsData
          ],
        ),
      ),
    );
  }
}

class RowInfoWidget extends StatelessWidget {
  const RowInfoWidget({
    Key? key,
    required this.leadingText,
    required this.trailingWidget,
  }) : super(key: key);
  final String leadingText;
  final Widget trailingWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(leadingText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 13, color: AppColor.anotherGrey)),
        ),
        Expanded(flex: 3, child: trailingWidget),
      ],
    );
  }
}

class RichTextDetailsWidget extends StatelessWidget {
  const RichTextDetailsWidget({
    Key? key,
    required this.firstText,
    this.secoundText,
    this.thirdText = false,
    this.onTapApproval,
  }) : super(key: key);
  final String firstText;
  final String? secoundText;
  final bool thirdText;
  final Function()? onTapApproval;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: const TextStyle(
          color: Colors.transparent,
          shadows: [Shadow(color: Colors.black, offset: Offset(-1, -3))],
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Colors.blue,
          decoration: TextDecoration.underline,
          decorationThickness: 4,
        ),
        children: [
          secoundText != null
              ? TextSpan(
                  text: secoundText,
                  style: const TextStyle(color: Colors.transparent, shadows: [
                    Shadow(color: AppColor.anotherGrey, offset: Offset(-1, -3))
                  ]))
              : const TextSpan(),
          thirdText
              ? TextSpan(
                  text: ' Not Verified',
                  recognizer: TapGestureRecognizer()..onTap = onTapApproval,
                  style: const TextStyle(
                      shadows: [
                        Shadow(color: Colors.red, offset: Offset(-1, -3))
                      ],
                      decoration: TextDecoration.none,
                      color: Colors.transparent,
                      fontSize: 13))
              : const TextSpan()
        ],
      ),
    );
  }
}

class UserCartWidget extends StatelessWidget {
  const UserCartWidget({
    Key? key,
    required this.personalInfo,
    required this.cardTitle,
    required this.userDataList,
    this.visibleEdit = true,
  }) : super(key: key);

  final List<String> personalInfo;
  final String cardTitle;
  final Widget userDataList;
  final bool visibleEdit;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: visibleEdit ? 0 : 10),
                  child: Text(cardTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColor.anotherGrey)),
                ),
                Visibility(
                  visible: visibleEdit,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Text(personalInfo[index],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 13, color: AppColor.anotherGrey)),
                    itemCount: personalInfo.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: userDataList,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
