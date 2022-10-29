import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constant_utils.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget(
      {Key? key,
      required this.headTitle,
      required this.heightSpace,
      this.showArrow = false,
      this.iconSpace = 50,
      this.visibleIcon = false,
      this.fontSize = 30})
      : super(key: key);
  final String headTitle;
  final bool showArrow;
  final double heightSpace;
  final double fontSize;
  final double iconSpace;
  final bool visibleIcon;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Visibility(
          visible: showArrow,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPath.appLogo,
              scale: 2.5.sp,
            ),
          ],
        ),
      ]),
      Visibility(
        visible: visibleIcon,
        child: Column(
          children: [
            addVerticalSpace(iconSpace),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
          ],
        ),
      ),
      addVerticalSpace(heightSpace),
      Text(
        headTitle,
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(fontSize: fontSize),
      )
    ]);
  }
}
