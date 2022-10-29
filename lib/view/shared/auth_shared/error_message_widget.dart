import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    required this.visibility,
    required this.message,
    Key? key,
  }) : super(key: key);
  final bool visibility;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 20.sp,
          ),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 12, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
