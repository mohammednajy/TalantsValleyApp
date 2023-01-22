import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'UI/UX Design for Talents Valley LLC',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text('\$450', style: TextStyle(fontWeight: FontWeight.w600))
        ],
      ),
      addVerticalSpace(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Omar Ziara',
            style: TextStyle(color: Color(0XFF656565), fontSize: 13),
          ),
          Text(
            'Pending Approval',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.orangeAccent),
          )
        ],
      )
    ]);
  }
}
