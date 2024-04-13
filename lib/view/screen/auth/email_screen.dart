import 'dart:developer';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/auth/sign_up/sign_up_cubit.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
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
import '../../widget/black_button.dart';
import '../../widget/my_stepper_form.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  late GlobalKey<FormState> formKey;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            children: [
              Gap(context.height * 0.03),
              const Backbutton(),
              Gap(context.height * 0.032),
              CustomTextSpan(
                  textOne: "Welcome to ",
                  textTwo: "Doctor AI",
                  fontSize: 24.spMin),
              Gap(8.h),
              Text(
                "Please enter your email and we will send a confirmation link to your email",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(26.h),
              const MyStepperForm(stepReachedNumber: 0),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  title: "Email",
                  hintText: "Enter Your Email",
                  onSaved: (data) {
                    _email = data;
                  },
                  validator: context.bloc<FormvalidationCubit>().validateEmail,
                ),
              ),
              Gap(context.height / 8.5),
              CustomButton(
                title: "Send",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.bloc<SignUpCubit>().email = _email!;
                    Navigator.pushNamed(context, RouteManager.password);
                  }
                },
              ),
              Gap(16.h),
              SignUpButton(
                title: "Sign in",
                subtitle: "Enter your Email ",
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
