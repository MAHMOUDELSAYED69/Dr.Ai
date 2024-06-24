import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/custom_dialog.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/my_stepper_form.dart';
import 'package:dr_ai/view/widget/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/image.dart';
import '../../../../core/helper/scaffold_snakbar.dart';
import '../../../../logic/account/account_cubit.dart';
import '../../../widget/custom_button.dart';
import '../../auth/forget_password.dart';

class OldPasswordScreen extends StatefulWidget {
  const OldPasswordScreen(
      {super.key,
      this.stepIconOne,
      this.stepIconTwo,
      this.stepTitleOne,
      this.stepTitleTwo,
      this.stepColorOne,
      this.stepColorTwo,
      this.navigator,
      this.appBarTitle});

  final String? stepIconOne;
  final String? stepIconTwo;
  final String? stepTitleOne;
  final String? stepTitleTwo;
  final Color? stepColorOne;
  final Color? stepColorTwo;
  final String? navigator;
  final String? appBarTitle;
  @override
  State<OldPasswordScreen> createState() => _OldPasswordScreenState();
}

class _OldPasswordScreenState extends State<OldPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _password;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<AccountCubit>();
    final validator = context.bloc<ValidationCubit>();
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountReAuthLoading) {
          _isLoading = true;
        }
        if (state is AccountReAuthSuccess) {
          FocusScope.of(context).unfocus();
          Navigator.pushReplacementNamed(
              context, widget.navigator ?? RouteManager.newPassword);

          _isLoading = false;
        }
        if (state is AccountReAuthFailure) {
          _isLoading = false;
          customSnackBar(context, state.message, ColorManager.error, 4);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Gap(32.h),
                CustomScrollableAppBar(
                  title: widget.appBarTitle ?? "Change Password",
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      ReAuthanticateStepper(
                        stepReachedNumber: 0,
                        stepColorOne: widget.stepColorOne,
                        stepColorTwo: widget.stepColorTwo,
                        stepIconOne: widget.stepIconOne,
                        stepIconTwo: widget.stepIconTwo,
                        stepTitleOne: widget.stepTitleOne,
                        stepTitleTwo: widget.stepTitleTwo,
                      ),
                      Form(
                        key: _formKey,
                        child: CustomTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          isVisible: true,
                          title: widget.stepTitleOne ?? "Old Password",
                          hintText:
                              "Enter Your ${widget.stepTitleOne ?? 'Old Password'}",
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
                      Gap(25.h),
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
              isDisabled: _isLoading,
              widget: _isLoading ? const ButtonLoadingIndicator() : null,
              title: "Next",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  await cubit.reAuthenticateUser(_password!);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
