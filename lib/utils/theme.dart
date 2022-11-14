import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    brightness: Brightness.light,
    fontFamily: 'Segoe UI',
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30.sp,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium:
          TextStyle(color: AppColor.black.withOpacity(0.63), fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(height: 0.3.h),
        contentPadding: EdgeInsetsDirectional.only(
            top: 11.h, bottom: 11.h, start: 16.w, end: 16.w),
        hintStyle: TextStyle(
          color: AppColor.black.withOpacity(0.4),
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppColor.lightgrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppColor.lightblue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r))),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, 44.h),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.blue)),
    ));
