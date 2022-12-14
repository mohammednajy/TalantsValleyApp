import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/disapproval_screen.dart';

import '../../../../../data/controller/user_management_controller/user_details_controller.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsController>(
      builder: (context, userDetails, child) => Scaffold(
        appBar: CustomAppBarWidget(
            title: '${type == "id" ? "ID" : "Address"} Approval'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: type == "address"
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileApprovalWidget(
                          title: 'Name',
                          subtitle:
                              '${userDetails.userDetailsInfo!.firstName} ${userDetails.userDetailsInfo!.lastName}'),
                      ListTileApprovalWidget(
                          title: 'Document Type',
                          subtitle: userDetails.userDetailsInfo!
                                      .verificationAddress["status"] ==
                                  "not_uploaded"
                              ? "Not Uploaded"
                              : userDetails.userDetailsInfo!
                                  .verificationAddress["addressDocumentType"]
                                  .toString()
                                  .replaceAll('_', " ")),
                      ListTileApprovalWidget(
                          title: 'Address1',
                          subtitle: userDetails
                                  .userDetailsInfo?.address!["address1"] ??
                              ''),
                      ListTileApprovalWidget(
                          title: 'Address2',
                          subtitle: userDetails
                                  .userDetailsInfo?.address!["address2"] ??
                              ''),
                      ListTileApprovalWidget(
                          title: 'City',
                          subtitle:
                              userDetails.userDetailsInfo?.address!["city"] ??
                                  ''),
                      ListTileApprovalWidget(
                          title: 'Country',
                          subtitle: userDetails
                                  .userDetailsInfo?.address!["country"] ??
                              ''),
                      addVerticalSpace(15),
                      Text(
                        'ID Document',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      addVerticalSpace(15),
                      Image.network(
                        userDetails.userDetailsInfo!
                            .verificationAddress["addressFile"],
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const CircularProgressIndicator();
                        },
                        errorBuilder: (context, child, error) =>
                            const Text('no image'),
                      ),
                      addVerticalSpace(20),
                      Row(
                        children: [
                          IdApprovalButtonWidget(
                              title: 'Approved',
                              onTap: () {
                                userDetails.userApproval(
                                  token: SharedPrefController()
                                      .getUser()
                                      .accessToken,
                                  id: userDetails.userDetailsInfo!.id,
                                  type: type,
                                );
                              }),
                          addHorizontalSpace(10),
                          IdApprovalButtonWidget(
                              title: 'Disapproved',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DisapprovalScreen(type: "address"),
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(20),
                    ListTileApprovalWidget(
                        title: 'Name',
                        subtitle:
                            '${userDetails.userDetailsInfo!.firstName} ${userDetails.userDetailsInfo!.lastName}'),
                    ListTileApprovalWidget(
                        title: 'Document Type',
                        subtitle:
                            userDetails.userDetailsInfo!.verifiedId["status"] ==
                                    "not_uploaded"
                                ? "Not Uploaded"
                                : userDetails.userDetailsInfo!
                                    .verifiedId["idDocumentType"]
                                    .toString()
                                    .replaceAll('_', " ")),
                    userDetails.userDetailsInfo!.verifiedId["status"] ==
                            "not_uploaded"
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                ListTileApprovalWidget(
                                    title: 'ID Number',
                                    subtitle: userDetails.userDetailsInfo!
                                        .verifiedId["idNumber"]),
                                addVerticalSpace(15),
                                Text(
                                  'ID Document',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                addVerticalSpace(20),
                                Image.network(
                                  userDetails
                                      .userDetailsInfo!.verifiedId["idFile"],
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                  errorBuilder: (context, child, error) =>
                                      const Text('no image'),
                                ),
                                addVerticalSpace(60),
                                userDetails.userDetailsInfo!
                                            .verifiedId["status"] ==
                                        "approved"
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          IdApprovalButtonWidget(
                                              title: 'Approved',
                                              onTap: () {
                                                userDetails.userApproval(
                                                  token: SharedPrefController()
                                                      .getUser()
                                                      .accessToken,
                                                  id: userDetails
                                                      .userDetailsInfo!.id,
                                                  type: type,
                                                );
                                              }),
                                          addHorizontalSpace(10),
                                          IdApprovalButtonWidget(
                                              title: 'Disapproved',
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DisapprovalScreen(
                                                            type: "id"),
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                              ])
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  CustomAppBarWidget({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(55.0),
        super(key: key);
  @override
  final Size preferredSize;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 70,
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
}

class IdApprovalButtonWidget extends StatelessWidget {
  const IdApprovalButtonWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.blue)))),
            onPressed: onTap,
            child: Text(
              title,
              style: TextStyle(color: Colors.blue, fontSize: 14),
            )));
  }
}

class ListTileApprovalWidget extends StatelessWidget {
  const ListTileApprovalWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 2,
          color: AppColor.grey,
        ),
      ],
    );
  }
}
