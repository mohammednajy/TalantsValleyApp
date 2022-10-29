import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'verification',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.reorder,
              color: Colors.black,
              size: 25,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Safa',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            addVerticalSpace(29),
            Text(
              'To use our services, We need to verify your account',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            addVerticalSpace(41),
            VerificationCardWidget(
              title: 'Email Address',
              subtitle: 'mail@email.com ',
              subtitleColored: '(not verified)',
              onPressed: () {},
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              title: 'Phone Number',
              subtitle: '+972 ******966 ',
              subtitleColored: '(not verified)',
              onPressed: () {},
            ),
            addVerticalSpace(10),
            Text(
              'You can complete the 2 following tasks later',
              style: TextStyle(fontSize: 11),
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              title: 'ID Verification',
              subtitle: 'Identity card - Driver license - Passport',
              onPressed: () {},
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              title: 'Address Verification',
              subtitle: 'Phone,Electricity,Water Bill-Bank statement',
              onPressed: () {},
            ),
            addVerticalSpace(60),
            ElevatedButton(onPressed: () {}, child: Text('Continue'))
          ],
        ),
      ),
    );
  }
}

class VerificationCardWidget extends StatelessWidget {
  const VerificationCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.subtitleColored,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String? subtitleColored;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColor.lightgrey)),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black, fontSize: 15),
        ),
        subtitle: RichText(
            text: TextSpan(
                text: subtitle,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 11, color: Colors.black),
                children: [
              TextSpan(
                text: subtitleColored,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 11,
                      color: Colors.red,
                    ),
              )
            ])),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(minimumSize: Size(91, 29)),
          child: const Text(
            'Verify',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
