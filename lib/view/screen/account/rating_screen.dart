import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/image.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  RatingScreenState createState() => RatingScreenState();
}

class RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: REdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.dm),
      ),
      elevation: 0,
      backgroundColor: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageManager.opinionIcon),
            Gap(12.h),
            Text(
              'Your opinion matters to us',
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 18.spMin),
            ),
            Gap(6.h),
            Text(
              'Please rate your experience with the app',
              style: context.textTheme.bodySmall,
            ),
            Gap(4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNumber = index + 1;
                return IconButton(
                  padding: EdgeInsets.zero,
                  icon: _selectedRating >= starNumber
                      ? Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 40.r,
                        )
                      : Icon(
                          color: ColorManager.dark,
                          Icons.star_border_rounded,
                          size: 40.r,
                        ),
                  onPressed: () {
                    setState(() {
                      _selectedRating = starNumber;
                    });
                  },
                );
              }),
            ),
            Gap(24.h),
            CustomButton(
              title: 'Submit',
              onPressed: () {},
            ),
            Gap(14.h),
            CustomButton(
              backgroundColor: ColorManager.error,
              title: 'Cancel',
              onPressed: () => context.pop(),
            )
          ],
        ),
      ),
    );
  }
}
