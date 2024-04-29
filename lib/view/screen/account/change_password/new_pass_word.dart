import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/my_stepper_form.dart';
import 'package:dr_ai/view/widget/profile/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../widget/custom_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _password;
  String? _confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(32.h),
          const CustomScrollableAppBar(
            title: "Change Password",
          ),
          Gap(20.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const UpdatePasswordStepper(stepReachedNumber: 1),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      isVisible: true,
                      title: "New Password",
                      hintText: "Enter Your New Password",
                      onSaved: (data) {
                        _password = data;
                      },
                      validator:
                          context.bloc<FormvalidationCubit>().validatePassword,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      title: "Confirm New Password",
                      hintText: "Enter Your Confirm New Password",
                      onSaved: (data) {
                        _confirmPassword = data;
                      },
                      validator:
                          context.bloc<FormvalidationCubit>().validatePassword,
                    ),
                    Gap(12.h),
                    const Spacer(),
                    CustomButton(
                      title: "Update",
                      onPressed: () {},
                    ),
                    Gap(30.h)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
