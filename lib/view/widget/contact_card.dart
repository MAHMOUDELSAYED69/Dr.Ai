import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/launch_uri/launch_uri_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../core/constant/color.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.image,
    required this.title,
    required this.number,
    required this.color,
  });

  final String image;
  final String title;
  final String number;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () =>
            context.bloc<LaunchUriCubit>().openContactsApp(phoneNumber: number),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: ColorManager.green, width: 1),
          ),
          color: ColorManager.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 6),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                          color: (color).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        image,
                        width: 20.w,
                        height: 20.w,
                      )),
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
