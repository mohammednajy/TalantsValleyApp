import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanlants_valley_application/data/controller/user_management_controller/user_details_controller.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/user_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../shared/user_managment_shared/custom_appBar_back.dart';

class UserIPScreen extends StatelessWidget {
  const UserIPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithBack(title: 'IP Records'),
      body: Consumer<UserDetailsController>(
        builder: (context, userProvider, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              userProvider.userIpRecords.isEmpty
                  ? const Expanded(
                      child: Center(
                      child: Text(
                        'NO IP Records',
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
                  : Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 30),
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userProvider.userIpRecords[index]["ip"]),
                            Text(
                              '${DateFormat.MMMd().format(
                                DateTime.parse(
                                  userProvider.userIpRecords[index]
                                      ["createdAt"],
                                ),
                              )}, ${DateFormat.jm().format(
                                DateTime.parse(
                                  userProvider.userIpRecords[index]
                                      ["createdAt"],
                                ),
                              )}',
                              style:
                                  const TextStyle(color: AppColor.anotherGrey),
                            )
                          ],
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                          height: 20,
                        ),
                        itemCount: userProvider.userIpRecords.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
