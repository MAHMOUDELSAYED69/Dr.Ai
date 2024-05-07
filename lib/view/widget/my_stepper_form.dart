// ignore_for_file: deprecated_member_use

import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInStepperForm extends StatefulWidget {
  const SignInStepperForm({super.key, required this.stepReachedNumber});
  final int stepReachedNumber;
  @override
  SignInStepperFormState createState() => SignInStepperFormState();
}

class SignInStepperFormState extends State<SignInStepperForm> {
  int activeStep = 0;
  @override
  void initState() {
    activeStep = widget.stepReachedNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      padding: EdgeInsets.zero,
      enableStepTapping: false,
      activeStep: activeStep,
      lineStyle: LineStyle(
        lineLength: context.width / 6,
        lineType: LineType.dashed,
        activeLineColor: ColorManager.green,
        finishedLineColor: ColorManager.green,
        defaultLineColor: ColorManager.grey,
        lineThickness: 2.dm,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 6.dm,
      borderThickness: 3.dm,
      activeStepBorderColor: ColorManager.green,
      defaultStepBorderType: BorderType.normal,
      stepRadius: 24.r,
      finishedStepBorderColor: ColorManager.green,
      finishedStepTextColor: Colors.deepOrange,
      finishedStepBackgroundColor: ColorManager.white,
      activeStepIconColor: ColorManager.white,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.emailIcon,
            color: activeStep >= 0 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Email",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 0 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.passwordIcon,
            color: activeStep >= 1 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Password",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 1 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.userIcon,
            color: activeStep >= 2 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Information",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 2 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class ReAuthanticateStepper extends StatefulWidget {
  const ReAuthanticateStepper(
      {super.key,
      required this.stepReachedNumber,
      this.stepIconOne,
      this.stepIconTwo,
      this.stepTitleOne,
      this.stepTitleTwo,
      this.stepColorOne,
      this.stepColorTwo});
  final int stepReachedNumber;
  final String? stepIconOne;
  final String? stepIconTwo;
  final String? stepTitleOne;
  final String? stepTitleTwo;
  final Color? stepColorOne;
  final Color? stepColorTwo;
  @override
  ReAuthanticateStepperState createState() => ReAuthanticateStepperState();
}

class ReAuthanticateStepperState extends State<ReAuthanticateStepper> {
  int activeStep = 0;
  @override
  void initState() {
    activeStep = widget.stepReachedNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      padding: EdgeInsets.zero,
      enableStepTapping: false,
      activeStep: activeStep,
      lineStyle: LineStyle(
        lineLength: context.width / 3,
        lineType: LineType.dashed,
        activeLineColor: ColorManager.green,
        finishedLineColor: widget.stepColorTwo ?? ColorManager.green,
        defaultLineColor: ColorManager.grey,
        lineThickness: 2.dm,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 6.dm,
      borderThickness: 3.dm,
      activeStepBorderColor: widget.stepColorTwo ?? ColorManager.green,
      defaultStepBorderType: BorderType.normal,
      stepRadius: 24.r,
      finishedStepBorderColor: ColorManager.green,
      finishedStepTextColor: Colors.deepOrange,
      finishedStepBackgroundColor: ColorManager.white,
      activeStepIconColor: ColorManager.white,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            widget.stepIconOne ?? ImageManager.passwordIcon,
            color: activeStep >= 0 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            widget.stepTitleOne ?? "Old Password",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 0 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            widget.stepIconTwo ?? ImageManager.passwordIcon,
            color: activeStep >= 1
                ? widget.stepColorTwo ?? ColorManager.green
                : ColorManager.grey,
          ),
          customTitle: Text(
            widget.stepTitleTwo ?? "New Password",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
                color: activeStep >= 1
                    ? widget.stepColorTwo ?? ColorManager.black
                    : ColorManager.grey,
                fontWeight:
                    widget.stepColorTwo != null ? FontWeight.bold : null),
          ),
        ),
      ],
    );
  }
}
