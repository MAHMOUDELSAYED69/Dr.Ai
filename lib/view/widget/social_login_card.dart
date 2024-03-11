import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class SocialLoginCard extends StatelessWidget {
  const SocialLoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: BorderSide(
                  width: 3,
                  color: MyColors.green.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              fixedSize: Size(95.w, 50.h)),
          child: Image.asset("assets/images/google.png"),
          onPressed: () {},
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: BorderSide(
                  width: 3,
                  color: MyColors.green.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              fixedSize: Size(95.w, 50.h)),
          child:
              Image.asset("assets/images/facebook.png"),
          onPressed: () {},
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: BorderSide(
                  width: 3,
                  color: MyColors.green.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              fixedSize: Size(95.w, 50.h)),
          child: Image.asset("assets/images/apple.png"),
          onPressed: () {},
        ),
      ],
    );
  }
}
