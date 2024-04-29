import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/my_stepper_form.dart';
import 'package:dr_ai/view/widget/profile/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../logic/account/account_cubit.dart';
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
    final password = context.bloc<AccountCubit>();
    final validator = context.bloc<FormvalidationCubit>();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(32.h),
              const CustomScrollableAppBar(
                title: "Change Password",
              ),
              Gap(20.h),
              Padding(
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
                        validator: validator.validatePassword,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        title: "Confirm New Password",
                        hintText: "Enter Your Confirm New Password",
                        onSaved: (data) {
                          _confirmPassword = data;
                        },
                        validator: validator.validateConfirmPassword,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              bottom: MediaQuery.viewInsetsOf(context).bottom + 25.h),
          child: CustomButton(
            title: "Update",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                // password.updatePassword(_password!);
              }
            },
          ),
        ));
  }
}
