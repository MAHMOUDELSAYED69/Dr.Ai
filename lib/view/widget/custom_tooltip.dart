import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class CustomToolTip extends StatelessWidget {
  const CustomToolTip(
      {super.key,
      required this.message,
      required this.child,
      this.bottomMargin});
  final String message;
  final Widget child;
  final double? bottomMargin;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      decoration: BoxDecoration(
        color: ColorManager.green,
        borderRadius: BorderRadius.circular(4.r),
      ),
      message: message,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      margin: EdgeInsets.only(bottom: bottomMargin ?? 30.h),
      child: child,
    );
  }
}
