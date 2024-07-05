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
  bool _isLoading = false;

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
            padding: EdgeInsets.only(
              left: 18,
              right: 18,
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Forgot Password",
                  style: context.textTheme.bodyLarge,
                ),
                Gap(16.h),
                Text(
                  "Please enter your email, and we will send you a confirmation link to reset your password.",
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
                  validator: context.bloc<ValidationCubit>().validateEmail,
                ),
                Gap(24.h),
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordLoading) {
                      _isLoading = true;
                    }
                    if (state is ForgetPasswordSuccess) {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                      customSnackBar(context, "Check your Email for link",
                          ColorManager.darkGrey, 3);
                      _isLoading = false;
                    }
                    if (state is ForgetPasswordFailure) {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                      customSnackBar(
                          context,
                          "There was an Error please try agin later!",
                          ColorManager.error);
                      log(state.message);
                      _isLoading = false;
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isDisabled: _isLoading,
                      title: _isLoading == false ? "Send link" : null,
                      widget: _isLoading == true
                          ? const ButtonLoadingIndicator()
                          : null,
                      onPressed: resetPassword,
                    );
                  },
                ),
                Gap(24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(22),
        topLeft: Radius.circular(22),
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
