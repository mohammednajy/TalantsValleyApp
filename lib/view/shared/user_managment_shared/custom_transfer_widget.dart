import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


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
              style: const TextStyle(
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
