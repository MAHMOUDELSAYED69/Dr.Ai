import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/helper/responsive.dart';

class BuidLoadingIndicator extends StatelessWidget {
  const BuidLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenSize.height * -0.02,
      child: Lottie.asset(
        filterQuality: FilterQuality.high,
        frameRate: const FrameRate(60.0),
        animate: true,
        height: 220,
        width: 220,
        fit: BoxFit.scaleDown,
        "assets/animations/Animation - 1709122512677.json",
      ),
    );
  }
}
