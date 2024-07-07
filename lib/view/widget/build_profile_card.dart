import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/color.dart';

class BuildProfileCard extends StatelessWidget {
  const BuildProfileCard({
    super.key,
    required this.title,
    this.image,
    this.color,
    this.iconData,
    this.onPressed,
    this.removeColorIcon = false,
  });
  final String title;
  final String? image;
  final Color? color;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final bool? removeColorIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashFactory: InkSplash.splashFactory,
      child: ListTile(
        contentPadding: const EdgeInsets.only(top: 6,bottom: 6,right: 6),
        title: Text(title, style: context.textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16.r, grade: 60, color: color ?? ColorManager.green),
        leading: Container(
          width: 46.w,
          height: 46.w,
          decoration: BoxDecoration(
              color: (color ?? ColorManager.green).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          padding: EdgeInsets.all(12.w),
          child: iconData == null
              ? SvgPicture.asset(
                  color: removeColorIcon == true
                      ? null
                      : color ?? ColorManager.green,
                  image!,
                  width: 20.w,
                  height: 20.w,
                )
              : Icon(
                  iconData,
                  color: ColorManager.error,
                  size: 22.r,
                ),
        ),
      ),
    );
  }
}
