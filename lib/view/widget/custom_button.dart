import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.widget,
    this.size,
    this.fontSize,
    this.backgroundColor,
    this.isDisabled,
  });
  final bool? isDisabled;
  final String? title;
  final VoidCallback? onPressed;
  final Size? size;
  final Widget? widget;
  final double? fontSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: context.elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStatePropertyAll(
              isDisabled == true ? ColorManager.darkGrey : backgroundColor),
          fixedSize:
              MaterialStateProperty.all(size ?? Size(context.width,52)),
        ),
        onPressed: isDisabled == true ? null : onPressed,
        child: widget ??
            Text(
              title ?? "",
              style: context.textTheme.displayMedium?.copyWith(
                fontSize: fontSize ?? 16.spMin,
              ),
            ));
  }
}
