import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

void alertMessage(context, {String? message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Icon(Icons.warning_amber),
      content: Text(message ?? "there was an error please try again later!"),
    ),
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonTitle,
      required this.onPressed,
      required this.image,
      this.errorMessage});
  final String title;
  final String subtitle;
  final String? errorMessage;
  final String buttonTitle;
  final VoidCallback onPressed;

  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: REdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.dm),
      ),
      elevation: 0,
      backgroundColor: ColorManager.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12.dm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image),
          Gap(18.h),
          Text(title, style: context.textTheme.bodyLarge),
          Gap(8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          (errorMessage != null)
              ? Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorManager.error),
                )
              : const SizedBox(),
          Gap(24.h),
          CustomButton(
            title: buttonTitle,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
