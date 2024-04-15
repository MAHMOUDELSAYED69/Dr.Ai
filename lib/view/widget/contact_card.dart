import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../core/constant/color.dart';
import '../../logic/other/contact_func.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.image,
    required this.title,
    required this.number,
  });

  final String image;
  final String title;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => OtherMethod.openContactsApp(phoneNumber: number),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.dm),
            side: BorderSide(color: ColorManager.green, width: 1.w),
          ),
          color: ColorManager.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(image),
                  Gap(8.h),
                  Text(
                    title,
                    style:
                        context.textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
                  ),
                  Gap(8.h),
                  Text(
                    number,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
