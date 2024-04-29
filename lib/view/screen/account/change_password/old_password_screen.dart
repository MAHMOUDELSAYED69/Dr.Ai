import 'package:dr_ai/core/constant/routes.dart';
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
import '../../auth/forget_password.dart';

class OldPasswordScreen extends StatefulWidget {
  const OldPasswordScreen({super.key});

  @override
  State<OldPasswordScreen> createState() => _OldPasswordScreenState();
}

class _OldPasswordScreenState extends State<OldPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _password;
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
              child: Column(
                children: [
                  const UpdatePasswordStepper(stepReachedNumber: 0),
                  Form(
                    key: _formKey,
                    child: CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      isVisible: true,
                      title: "Old Password",
                      hintText: "Enter Your Old Password",
                      onSaved: (data) {
                        _password = data;
                      },
                      validator: validator.validatePassword,
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
                ],
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
          title: "Next",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              // password.reAuthenticateUser(_password!);
              Navigator.pushNamed(context, RouteManager.newPassword);
            }
          },
        ),
      ),
    );
  }
}
