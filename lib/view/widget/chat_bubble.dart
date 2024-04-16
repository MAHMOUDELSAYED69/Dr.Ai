import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChatBubbleForLoading extends StatelessWidget {
  const ChatBubbleForLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        height: 37.h,
        width: 60.w,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(
            left: 16.w, top: 7.h, bottom: 7.h, right: context.width / 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          color: ColorManager.grey.withOpacity(0.25),
        ),
        child: const LoadingIndicator(
          indicatorType: Indicator.ballPulseSync,
          colors: [
            ColorManager.green,
            ColorManager.white,
            ColorManager.selver,
          ],
        ),
      ),
    );
  }
}

class ChatBubbleForDrAi extends StatelessWidget {
  const ChatBubbleForDrAi({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(
            left: 16.w, top: 7.h, bottom: 7.h, right: context.width / 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          color: ColorManager.grey.withOpacity(0.25),
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.darkGrey)),
      ),
    );
  }
}

class ChatBubbleForGuest extends StatelessWidget {
  const ChatBubbleForGuest({
    Key? key,
    required this.message,
  }) : super(key: key);

  // final Message message;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(
            left: context.width / 4, top: 7.h, bottom: 7.h, right: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          color: ColorManager.green,
        ),
        child: Text(message,
            style: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.white)),
      ),
    );
  }
}
