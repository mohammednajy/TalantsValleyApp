import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tanlants_valley_application/data/models/user_details_model.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/approval_screen.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_user_screen.dart';

import '../../../../../data/controller/counrty_controller.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    // this.userData,
  });
  // final UserDetailsModel? userData;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  List<String> updatesInfo = [
    "Created",
    "Last Login",
    "Phone",
    "IP",
    "Transfers",
  ];
  List<String> financialInfo = [
    "Balance",
    "Revenue",
    "Profit",
  ];

  // Map<String, String> personalInfo = {
  //   "Full Name": '${userDetails.firstName} ${userDetails.lastName}',
  //   "Email": userDetails.email,
  //   "Phone": userDetails.mobile.toString(),
  //   "ID":
  //       ' ${userDetails.verifiedId["idNumber"]} (${userDetails.verifiedId["idDocumentType"]}) ',
  //   "Address":
  //       '${userDetails.address!["address1"]}-${userDetails.address!["city"]}-${userDetails.address!["country"]}',
  //   "Role": userDetails.role == 0 ? 'User' : 'Team'
  // };
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsController>(
      builder: (context, userDetails, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 80,
          title: Text(
            userDetails.userDetailsInfo!.firstName,
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
        ),
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
                        trailingWidget: RichTextDetailsWidget(
                          //  "status": "not_uploaded"
                          firstText: userDetails
                                  .userDetailsInfo!.verifiedId["idNumber"] ??
                              ' - - - - - - ',
                          secoundText: userDetails
                                      .userDetailsInfo!.verifiedId["status"] !=
                                  "approved"
                              ? ''
                              : ' (${userDetails.userDetailsInfo!.verifiedId["idDocumentType"].toString().replaceAll('_', ' ').toUpperCase()})',
                          thirdText: userDetails
                                      .userDetailsInfo!.verifiedId["status"] !=
                                  "approved"
                              ? true
                              : false,
                          // ID Approval
                          onTapApproval: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ApprovalScreen(
                                    type: "id",
                                  ),
                                ));
                          },
                        ),
                      ),
                      addVerticalSpace(10),
                      RowInfoWidget(
                        leadingText: 'Address',
                        trailingWidget: RichTextDetailsWidget(
                            firstText: userDetails.userDetailsInfo!
                                        .address!["address1"] ==
                                    null
                                ? userDetails
                                        .userDetailsInfo!.address!["country"] ??
                                    ''
                                : '${userDetails.userDetailsInfo!.address!["address1"] ?? ''} - ${userDetails.userDetailsInfo!.address!["city"] ?? ''} - ${userDetails.userDetailsInfo!.address!["country"] ?? ''}',
                            secoundText: '',
                            thirdText: userDetails.userDetailsInfo!
                                        .verificationAddress["status"] !=
                                    "approved"
                                ? true
                                : false,
                            onTapApproval: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ApprovalScreen(
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
                      trailingWidget: RichTextDetailsWidget(
                          firstText: userDetails.userDetailsInfo!.lastLoginIP ??
                              'No IP'),
                    ),
                    addVerticalSpace(10),
                    const RowInfoWidget(
                        leadingText: 'Transfers',
                        trailingWidget: Text('no tranfer')),
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: financialInfo
                            .map((e) => Column(
                                  children: [
                                    Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 13,
                                              color: AppColor.anotherGrey),
                                    ),
                                    addVerticalSpace(5),
                                    Text('\$1000',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 13,
                                                color: AppColor.black))
                                  ],
                                ))
                            .toList(),
                      ),
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
        recognizer: TapGestureRecognizer()..onTap = onTapApproval,
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
                  style: TextStyle(
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
