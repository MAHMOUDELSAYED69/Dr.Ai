import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
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
  const CustomDialog({super.key});

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
          SvgPicture.asset(ImageManager.congratulationIcon),
          Text("Congratulations!", style: context.textTheme.bodyLarge),
          Gap(18.h),
          Text(
            "Your account has been created",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          Gap(24.h),
          CustomButton(
            title: "Login",
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}
