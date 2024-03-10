import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BuidLoadingIndicator extends StatelessWidget {
  const BuidLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Lottie.asset(
        animate: true,
        height: 200.h,
        width: 200.w,
        fit: BoxFit.scaleDown,
        "assets/animations/Animation - 1709122512677.json",
      ),
    );
  }
}
