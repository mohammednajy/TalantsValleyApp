import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


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
