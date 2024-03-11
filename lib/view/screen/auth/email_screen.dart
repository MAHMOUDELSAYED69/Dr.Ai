import 'dart:developer';

import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_divider.dart';
import 'package:dr_ai/view/widget/custom_sign_up_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/custom_text_span.dart';
import 'package:dr_ai/view/widget/social_login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding:
              EdgeInsets.only(top: 70.h, right: 18.w, left: 18.w, bottom: 18.h),
          child: Column(
            children: [
              const CustomTextSpan(
                  textOne: "Welcome to ", textTwo: "Doctor AI", fontSize: 24),
              SizedBox(height: 8.h),
              Text(
                "Please enter your email and we will send a confirmation link to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: MyColors.grey3),
              ),
              const BuildCreateAccountSlider(
                  currentColorCard: MyColors.green,
                  currentColorText: MyColors.black,
                  currentposition: 1),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Form(
                  key: formKey,
                  child: CustomTextFormField(
                    title: "Email",
                    hintText: "Enter your Email",
                    onSaved: (data) {
                      email = data;
                    },
                  ),
                ),
              ),
              SizedBox(height: 120.h),
              CustomButton(
                title: "Send",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    log("Sccess");
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: SignUpButton(
                  title: "Sign in",
                  subtitle: "Enter your Email",
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: const CustomDivider(
                      title: "Create your account quickly with")),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                ),
                child: const SocialLoginCard(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildCreateAccountSlider extends StatelessWidget {
  const BuildCreateAccountSlider({
    super.key,
    required this.currentColorCard,
    required this.currentColorText,
    required this.currentposition,
  });
  final Color currentColorCard;
  final Color currentColorText;
  final int currentposition;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 17.h, right: 13.w, left: 21.w),
          child: const Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BuildCreateAccountCard(
                    image: "assets/images/email.png",
                    title: "Email",
                    currentColor: MyColors.green),
              ),
              Align(
                alignment: Alignment.center,
                child: BuildCreateAccountCard(
                    image: "assets/images/password.png",
                    title: "Password",
                    currentColor: MyColors.grey3),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: BuildCreateAccountCard(
                    image: "assets/images/name.png",
                    title: "Information",
                    currentColor: MyColors.grey3),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: currentposition == 1
                    ? MyColors.green.withOpacity(0.3)
                    : MyColors.green.withOpacity(0),
                radius: currentposition == 1 ? 11.r : 4.2.r,
                child: CircleAvatar(
                  backgroundColor: currentposition == 1
                      ? MyColors.green
                      : MyColors.green.withOpacity(0.3),
                  radius: 4.2.r,
                ),
              ),
              Container(
                height: 3.h,
                width: 115.w,
                decoration: BoxDecoration(
                    color: MyColors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(36.r)),
              ),
              CircleAvatar(
                backgroundColor: currentposition == 2
                    ? MyColors.green.withOpacity(0.3)
                    : MyColors.green.withOpacity(0),
                radius: currentposition == 2 ? 11.r : 4.2.r,
                child: CircleAvatar(
                  backgroundColor: currentposition == 2
                      ? MyColors.green
                      : MyColors.green.withOpacity(0.3),
                  radius: 4.2.r,
                ),
              ),
              Container(
                height: 3.h,
                width: 115.w,
                decoration: BoxDecoration(
                    color: MyColors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(36.r)),
              ),
              CircleAvatar(
                backgroundColor: currentposition == 3
                    ? MyColors.green.withOpacity(0.3)
                    : MyColors.green.withOpacity(0),
                radius: currentposition == 3 ? 11.r : 04.2.r,
                child: CircleAvatar(
                  backgroundColor: currentposition == 3
                      ? MyColors.green
                      : MyColors.green.withOpacity(0.3),
                  radius: 4.2.r,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BuildCreateAccountCard extends StatelessWidget {
  const BuildCreateAccountCard({
    super.key,
    required this.image,
    required this.title,
    required this.currentColor,
  });
  final String image;
  final String title;
  final Color currentColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 6.h),
          height: 34.h,
          width: 34.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1.5, color: currentColor)),
          child: Image.asset(
            image,
            scale: 1.30.r,
            color: currentColor,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12.sp,
              color: currentColor == MyColors.green
                  ? MyColors.black
                  : MyColors.grey3),
        )
      ],
    );
  }
}
