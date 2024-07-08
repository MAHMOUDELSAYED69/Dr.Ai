import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/routes.dart';
import '../../widget/black_button.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/custom_text_span.dart';
import '../../widget/my_stepper_form.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required this.email});
  final String email;
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
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              Gap(context.height * 0.03),
              const Backbutton(),
              Gap(context.height * 0.032),
              CustomTextSpan(
                  textOne: "Create a ",
                  textTwo: "Password",
                  fontSize: 24.spMin),
              Gap(8.h),
              Text(
                "Set a strong password to keep your account secure",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(26.h),
              const SignInStepperForm(stepReachedNumber: 1),
              _buildPasswordAndConfirmPasswordFields(),
              Gap(context.height / 8.5),
              CustomButton(
                title: "Submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    Navigator.pushNamed(context, RouteManager.information,
                        arguments: [
                          widget.email,
                          _password,
                        ]);
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
    final cubit = context.bloc<ValidationCubit>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            keyboardType: TextInputType.visiblePassword,
            isVisible: true,
            title: "Password",
            hintText: "Enter Your password",
            onSaved: (data) {
              _password = data;
            },
            validator: cubit.validatePassword,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            title: "Confirm Password",
            hintText: "Enter Your Confirm Password",
            onSaved: (data) {
              _confirmPassword = data;
            },
            validator: cubit.validateConfirmPassword,
          ),
        ],
      ),
    );
  }
}
