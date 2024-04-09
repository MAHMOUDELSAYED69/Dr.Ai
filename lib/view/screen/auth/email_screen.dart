import 'dart:developer';

import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_divider.dart';
import 'package:dr_ai/view/widget/custom_sign_up_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/custom_text_span.dart';

import 'package:dr_ai/view/widget/social_login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

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
              Gap(context.height / 7),
              const CustomTextSpan(
                  textOne: "Welcome to ", textTwo: "Doctor AI", fontSize: 24),
              Gap(8.h),
              Text(
                "Please enter your email and we will send a confirmation link to your email",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(20.h),
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
              Gap(20.h),
              const MyStepperForm(),
              Gap(80.h),
              CustomButton(
                title: "Send",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    log("Sccess");
                  }
                },
              ),
              SignUpButton(
                title: "Sign in",
                subtitle: "Enter your Email",
                onTap: () => Navigator.pop(context),
              ),
              const CustomDivider(title: "Create your account quickly with"),
              const SocialLoginCard()
            ],
          ),
        ),
      ),
    );
  }
}
