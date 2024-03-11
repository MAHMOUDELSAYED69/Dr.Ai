import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.title,
    this.onTap,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(subtitle ?? "Don’t have an account? ",
              style: TextStyle(
                fontFamily: "Poppins",
                color: MyColors.grey3,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              )),
          Text(title,
              style: TextStyle(
                fontFamily: "Poppins",
                decoration: TextDecoration.underline,
                decorationColor: MyColors.green,
                color: MyColors.green,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
          const Icon(
            Icons.arrow_outward,
            color: MyColors.green,
          )
        ],
      ),
    );
  }
}
