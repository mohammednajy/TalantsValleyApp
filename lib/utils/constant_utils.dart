import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

addVerticalSpace(double height) {
  return SizedBox(height: height.h);
}

addHorizontalSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

class AssetPath {
  AssetPath._();

  static const String imageBasePath = 'assets/images/';
  static const String iconBasePath = 'assets/icons/';

  static const String appLogo = '${imageBasePath}talants_logo.png';
  static const String verifiyAddressIcon = '${iconBasePath}address_verfication_icon.png';

}

class AppColor {
  AppColor._();
  static const Color black = Color(0xFF151617);
  static const Color grey = Color(0xFFD6D6D6);
  static const Color lightgrey = Color(0xFFE2E2E2);
  static const Color lightblue = Color(0xFF91AEFF);
  static const Color blue = Color(0xFF4375FF);
}
