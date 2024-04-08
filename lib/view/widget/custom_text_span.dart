import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
    required this.textOne,
    required this.textTwo,
    this.fontSize,
  });
  final String textOne;
  final String textTwo;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textOne,
          style: context.textTheme.bodyLarge
              ?.copyWith(fontSize: fontSize ?? 32.sp),
        ),
        Text(
          textTwo,
          style: context.textTheme.displayLarge
              ?.copyWith(fontSize: fontSize ?? 32.sp),
        ),
      ],
    );
  }
}
