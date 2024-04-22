import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

void alertMessage(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Icon(Icons.warning_amber),
      content: Text(message ?? "there was an error please try again later!"),
    ),
  );
}

void customDialog(BuildContext context,
    {required String title,
    required String subtitle,
    required String buttonTitle,
    required VoidCallback onPressed,
    required String image,
    String? errorMessage,
    Color? secondButtoncolor,
    Widget? widget,
    bool? dismiss}) {
  showDialog(
      context: context,
      barrierDismissible: dismiss ?? true,
      builder: (_) => CustomDialog(
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            onPressed: onPressed,
            image: image,
            errorMessage: errorMessage,
            secondButtoncolor: secondButtoncolor,
            widget: widget,
          ));
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    required this.onPressed,
    required this.image,
    this.errorMessage,
    this.secondButtoncolor,
    this.widget,
  });
  final String title;
  final String subtitle;
  final String? errorMessage;
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color? secondButtoncolor;
  final Widget? widget;
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
          SvgPicture.asset(
            image,
            width: 125.w,
            height: 125.w,
          ),
          Gap(18.h),
          Text(title,
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: secondButtoncolor, fontSize: 18.spMin)),
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
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorManager.error,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : const SizedBox(),
          Gap(22.h),
          secondButtoncolor != null
              ? Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        size: Size.fromHeight(42.w),
                        title: "Cancel",
                        onPressed: () => context.pop(),
                      ),
                    ),
                    Gap(5.w),
                    Expanded(
                      child: CustomButton(
                        size: Size.fromHeight(42.w),
                        widget: widget,
                        backgroundColor: secondButtoncolor,
                        title: buttonTitle,
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                )
              : CustomButton(
                  size: Size(context.width, 42.w),
                  widget: widget,
                  title: buttonTitle,
                  onPressed: onPressed,
                ),
        ],
      ),
    );
  }
}
