import 'dart:developer';

import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/routes.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/custom_text_span.dart';
import '../../widget/my_stepper_form.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  String? _password;
  String? _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            children: [
              Gap(context.height / 8),
              CustomTextSpan(
                  textOne: "Welcome to ",
                  textTwo: "Doctor AI",
                  fontSize: 24.sp),
              Gap(8.h),
              Text(
                "Please enter your email and we will send a confirmation link to your email",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(26.h),
              const MyStepperForm(stepReachedNumber: 1),
              _buildPasswordAndConfirmPasswordFields(),
              Gap(context.height / 8.5),
              CustomButton(
                title: "Submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    log("Sccess");
                    Navigator.pushNamed(context, RouteManager.information);
                  }
                },
              ),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordAndConfirmPasswordFields() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            isVisible: true,
            title: "Password",
            hintText: "Enter Your password",
            onSaved: (data) {
              _password = data;
            },
            validator: (value) =>
                context.bloc<FormvalidationCubit>().validatePassword(value),
          ),
          CustomTextFormField(
            obscureText: true,
            title: "Confirm Password",
            hintText: "Enter Your Confirm Password",
            onSaved: (data) {
              _confirmPassword = data;
            },
            validator: (value) => context
                .bloc<FormvalidationCubit>()
                .validateConfirmPassword(value),
          ),
        ],
      ),
    );
  }
}
