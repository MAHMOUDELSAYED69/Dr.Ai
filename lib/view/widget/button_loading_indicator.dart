import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({
    super.key,
    this.color,
    this.radius,
  });

  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius ?? 20.w,
      width: radius ?? 20.w,
      child: CircularProgressIndicator(
        color: color ?? ColorManager.white,
        strokeCap: StrokeCap.round,
        strokeWidth: 2.5,
      ),
    );
  }
}
