import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan({
    super.key,
    required this.textOne,
    required this.textTwo,
    required this.fontSize,
  });
  final String textOne;
  final String textTwo;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textOne,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w600,
            )),
        Text(textTwo,
            style: TextStyle(
              fontFamily: "Poppins",
              color: MyColors.green,
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
