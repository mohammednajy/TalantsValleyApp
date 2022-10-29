import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router/router.dart';
import '../../../utils/constant_utils.dart';

class RichTextWidget extends StatefulWidget {
  const RichTextWidget({
    Key? key,
    required this.left,
    required this.right,
    // required this.screenName,
    required this.onTap,
  }) : super(key: key);
  final String left;
  final String right;
  // final String screenName;
  final Function()? onTap;

  @override
  State<RichTextWidget> createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  late TapGestureRecognizer _pressRecognizer;

  @override
  void initState() {
    super.initState();
    _pressRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _pressRecognizer.dispose();
    super.dispose();
  }

  // void _handlePress() {
  //   AppRouter.goAndRemove(widget.screenName);
  // }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: widget.left,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 13.sp),
            children: [
          TextSpan(
              text: widget.right,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 13.sp, color: AppColor.blue),
              recognizer: _pressRecognizer)
        ]));
  }
}
