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

  //icons path
  static const String verifiyAddressIcon =
      '${iconBasePath}address_verfication_icon.png';
  static const String analyticsIcon = '${iconBasePath}analytics_icon.png';
  static const String cashIcon = '${iconBasePath}cash_icon.png';
  static const String homeIcon = '${iconBasePath}home_icon.png';
  static const String invoiceIcon = '${iconBasePath}invoice_icon.png';
  static const String userIcon = '${iconBasePath}user_icon.png';
}

class AppColor {
  AppColor._();
  static const Color black = Color(0xFF151617);
  static const Color grey = Color(0xFFD6D6D6);
  static const Color lightgrey = Color(0xFFE2E2E2);
  static const Color lightblue = Color(0xFF91AEFF);
  static const Color blue = Color(0xFF4375FF);
  static const Color anotherGrey = Color(0xFF8C8C8C);
}
