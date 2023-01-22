import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant_utils.dart';


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
                  recognizer: TapGestureRecognizer()..onTap = onTapApproval,
                  style: const TextStyle(
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
