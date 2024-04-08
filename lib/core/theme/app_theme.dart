import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  //!! LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(ColorManager.green.withOpacity(0.1)),
          foregroundColor: MaterialStateProperty.all(ColorManager.green),
          side: MaterialStateProperty.all(
            BorderSide(
              width: 3,
              color: ColorManager.green.withOpacity(0.3),
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          fixedSize: MaterialStateProperty.all(
            Size(95.w, 50.h),
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(ColorManager.white),
          backgroundColor: MaterialStateProperty.all(ColorManager.green),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Use 8 as default value
            ),
          ),
          fixedSize: MaterialStateProperty.all(
            Size(double.maxFinite, 48.h),
          ),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        checkColor: const MaterialStatePropertyAll(ColorManager.white),
        fillColor: const MaterialStatePropertyAll(ColorManager.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.dm),
        ),
        side: BorderSide(color: ColorManager.grey, width: 1.dm),
      ),
      //

      iconTheme: const IconThemeData(color: ColorManager.grey),
      switchTheme: SwitchThemeData(
        trackOutlineColor: MaterialStateProperty.all(ColorManager.green),
        thumbColor: MaterialStateProperty.all(ColorManager.white),
        trackColor: MaterialStateProperty.all(ColorManager.green),
        thumbIcon: MaterialStateProperty.all(const Icon(
          Icons.light_mode,
          color: ColorManager.white,
        )),
      ),
      fontFamily: FontFamilyManager.poppins,
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        color: ColorManager.white,
        iconTheme: const IconThemeData(color: ColorManager.black),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorManager.black,
          fontSize: 20.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.dm),
            bottomRight: Radius.circular(20.dm),
          ),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 24.sp,
          color: ColorManager.black,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          color: ColorManager.black,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontSize: 14.sp,
          color: ColorManager.grey,
          fontWeight: FontWeight.w400,
        ),
        //* GREEN
        displayLarge: TextStyle(
          fontSize: 24.sp,
          color: ColorManager.green,
          fontWeight: FontWeight.w600,
        ),
        //! For button
        displayMedium: TextStyle(
          fontSize: 16.sp,
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: MyColors.green,
          color: MyColors.green,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14.sp),
        filled: true,
        fillColor: ColorManager.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.dm),
          ),
          borderSide: BorderSide(
            width: 1.7.w,
            color: ColorManager.green,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.dm),
          ),
          borderSide: BorderSide(
            width: 1.7.w,
            color: ColorManager.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.dm),
          ),
          borderSide: BorderSide(
            width: 2.w,
            color: ColorManager.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.dm),
          ),
          borderSide: BorderSide(
            width: 2.w,
            color: ColorManager.error,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      ),
    );
  }
}
