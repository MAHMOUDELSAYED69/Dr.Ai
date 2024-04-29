import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/my_stepper_form.dart';
import 'package:dr_ai/view/widget/profile/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../widget/custom_button.dart';
import '../../auth/forget_password.dart';

class OldPasswordScreen extends StatelessWidget {
  const OldPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            Gap(32.h),
            const CustomScrollableAppBar(),
            Gap(20.h),
            Expanded(
              child: Column(
                children: [
                  const UpdatePasswordStepper(stepReachedNumber: 0),
                  Form(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      isVisible: true,
                      title: "Old Password",
                      hintText: "Enter Your Old Password",
                      onSaved: (data) {},
                      validator:
                          context.bloc<FormvalidationCubit>().validatePassword,
                    ),
                  ),
                  Gap(12.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () => showForgetPasswordBottomSheet(context),
                      child: Text(
                        "Forgot Password?",
                        style: context.textTheme.displaySmall,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    title: "Next",
                    onPressed: () {},
                  ),
                  Gap(30.h)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
