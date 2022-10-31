import 'package:flutter/material.dart';

import '../../../../utils/constant_utils.dart';
import '../../../shared/auth_shared/auth_header_widget.dart';

class SharedDoneVerfication extends StatelessWidget {
  const SharedDoneVerfication({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);
  final String message;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(60),
            const AuthHeaderWidget(
              headTitle: '',
              heightSpace: 0,
              showArrow: true,
            ),
            addVerticalSpace(90),
            const Icon(
              Icons.verified_outlined,
              size: 80,
              color: Colors.green,
            ),
            addVerticalSpace(45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            addVerticalSpace(120),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: AppColor.lightgrey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Continue ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
