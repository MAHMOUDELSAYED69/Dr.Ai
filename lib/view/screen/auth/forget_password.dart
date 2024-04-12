import 'dart:developer';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../logic/auth/forget_password/forget_password_cubit.dart';
import '../../../logic/validation/formvalidation_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;

  resetPassword() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<ForgetPasswordCubit>(context)
          .resetPassword(email: email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 18.h),
            width: context.width / 3,
            height: 4.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(74.dm),
                color: ColorManager.grey.withOpacity(0.40)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                  top: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Forgot Password",
                    style: context.textTheme.bodyLarge,
                  ),
                  Gap(16.h),
                  Text(
                    "Enter Your email for the verification processes, we will send an email to reset your password.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  Gap(8.h),
                  CustomTextFormField(
                    title: "Email",
                    hintText: "Enter your Email",
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (data) {
                      email = data;
                    },
                    validator:
                        context.bloc<FormvalidationCubit>().validateEmail,
                  ),
                  Gap(24.h),
                  BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordLoading) {
                        isLoading = true;
                      }
                      if (state is ForgetPasswordSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        scaffoldSnackBar(context, "Check your E-mail");
                      }
                      if (state is ForgetPasswordFailure) {
                        isLoading = false;
                        scaffoldSnackBar(context,
                            "There was an Error please try agin later!");
                        log(state.message);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        title: isLoading == false ? "Send link" : null,
                        widget: isLoading == true
                            ? const ButtonLoadingIndicator()
                            : null,
                        onPressed: resetPassword,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.dm),
        topLeft: Radius.circular(20.dm),
      ),
    ),
    backgroundColor: ColorManager.white,
    elevation: 0,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ForgetPassword();
    },
  );
}
