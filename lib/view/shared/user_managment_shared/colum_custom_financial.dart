import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


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
