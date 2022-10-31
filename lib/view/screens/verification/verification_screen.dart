import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanlants_valley_application/data/controller/verification_controller.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(SharedPrefController().getUser().accessToken);
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
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.reorder,
                color: Colors.black,
                size: 25,
              ));
        }),
      ),
      drawer: Container(
        width: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  SharedPrefController().clear();
                  AppRouter.goAndRemove(ScreenName.loginScreen);
                },
                child: const Text(
                  'log out',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${SharedPrefController().getUser().userInfo.firstName.toString()}',
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
              notVerified:
                  !SharedPrefController().getUser().userInfo.verifiedEmail,
              title: 'Email Address',
              subtitle:
                  '${SharedPrefController().getUser().userInfo.email.replaceRange(0, 4, '')} ',
              subtitleColored: '(not verified)',
              onPressed: () {
                context.read<VerificationController>().sendEmailCode(
                    token: SharedPrefController().getUser().accessToken);
              },
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              notVerified:
                  !SharedPrefController().getUser().userInfo.verifiedMobile,
              title: 'Phone Number',
              subtitle: SharedPrefController()
                  .getUser()
                  .userInfo
                  .mobile
                  .replaceRange(
                      4,
                      SharedPrefController().getUser().userInfo.mobile.length -
                          3,
                      '**********'),
              subtitleColored: ' (not verified)',
              onPressed: () {
                context.read<VerificationController>().sendPhoneCode(
                    token: SharedPrefController().getUser().accessToken);
              },
            ),
            addVerticalSpace(10),
            const Text(
              'You can complete the 2 following tasks later',
              style: TextStyle(fontSize: 11),
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              title: 'ID Verification',
              subtitle: 'Identity card - Driver license - Passport',
              onPressed: () {
                AppRouter.goTo(ScreenName.idVerificationScreen);
              },
            ),
            addVerticalSpace(10),
            VerificationCardWidget(
              title: 'Address Verification',
              subtitle: 'Phone,Electricity,Water Bill-Bank statement',
              onPressed: () {},
            ),
            addVerticalSpace(60),
            ElevatedButtonWithDisapleWidget(
              visisble:
                  (SharedPrefController().getUser().userInfo.verifiedEmail &&
                      SharedPrefController().getUser().userInfo.verifiedMobile),
              onPressed: () {
                AppRouter.goAndRemove(ScreenName.homeScreen);
              },
              loaderVisisble: false,
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonWithDisapleWidget extends StatelessWidget {
  const ElevatedButtonWithDisapleWidget({
    Key? key,
    required this.visisble,
    required this.onPressed,
    required this.loaderVisisble,
  }) : super(key: key);
  final bool visisble;
  final Function() onPressed;
  final bool loaderVisisble;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visisble,
      replacement: Container(
        margin: const EdgeInsets.only(top: 3),
        padding: const EdgeInsets.only(bottom: 3),
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 172, 189, 236),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      child: ButtonWidget(
          text: 'Continue', visible: loaderVisisble, onPressed: onPressed),
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
    this.notVerified = true,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String? subtitleColored;
  final Function()? onPressed;
  final bool notVerified;
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
              subtitleColored != null
                  ? TextSpan(
                      text: notVerified ? subtitleColored : ' (verified)',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 11,
                            color: notVerified ? Colors.red : Colors.green,
                          ),
                    )
                  : const TextSpan()
            ])),
        trailing: subtitleColored != null
            ? Visibility(
                visible: notVerified,
                replacement: const Icon(
                  Icons.check_circle_outline,
                  size: 40,
                  color: Colors.green,
                ),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(91, 29),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(91, 29),
                  elevation: 0,
                ),
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
