import 'dart:developer';

import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_divider.dart';
import 'package:dr_ai/view/widget/custom_sign_up_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/custom_text_span.dart';

import 'package:dr_ai/view/widget/social_login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import '../../../core/constant/routes.dart';
import '../../widget/my_stepper_form.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
String? email;

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            children: [
              Gap(context.height / 8),
              const CustomTextSpan(
                  textOne: "Welcome to ", textTwo: "Doctor AI", fontSize: 24),
              Gap(8.h),
              Text(
                "Please enter your email and we will send a confirmation link to your email",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(18.h),
              const MyStepperForm(stepReachedNumber: 0),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  title: "Email",
                  hintText: "Enter your Email",
                  onSaved: (data) {
                    email = data;
                  },
                ),
              ),
              Gap(context.height / 8.5),
              CustomButton(
                title: "Send",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    //TODO: send email
                    log("Sccess");
                    Navigator.pushNamed(context, RouteManager.password);
                  }
                },
              ),
              Gap(16.h),
              SignUpButton(
                title: "Sign in",
                subtitle: "Enter your Email",
                onTap: () => Navigator.pop(context),
              ),
              Gap(32.h),
              const CustomDivider(title: "Create your account quickly with"),
              Gap(16.h),
              const SocialLoginCard(),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
