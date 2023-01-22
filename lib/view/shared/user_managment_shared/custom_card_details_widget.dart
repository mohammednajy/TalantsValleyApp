import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


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
