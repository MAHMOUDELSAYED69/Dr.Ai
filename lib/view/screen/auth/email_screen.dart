import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/auth/sign_up/sign_up_cubit.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_divider.dart';
import 'package:dr_ai/view/widget/custom_sign_up_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:dr_ai/view/widget/custom_text_span.dart';
import 'package:dr_ai/view/widget/social_login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/helper/scaffold_snakbar.dart';
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
  bool _isLoading = false;
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
              const SignInStepperForm(stepReachedNumber: 0),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  title: "Email",
                  hintText: "Enter Your Email",
                  onSaved: (data) {
                    _email = data;
                  },
                  validator: context.bloc<ValidationCubit>().validateEmail,
                ),
              ),
              Gap(context.height / 8.5),
              BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is EmailCheckLoading) {
                    _isLoading = true;
                    FocusScope.of(context).unfocus();
                  }
                  if (state is EmailValid) {
                    _isLoading = false;
                    context.bloc<SignUpCubit>().email = _email!;
                    Navigator.pushNamed(context, RouteManager.password);
                  }
                  if (state is EmailNotValid) {
                    _isLoading = false;
                    customSnackBar(
                        context,
                        state.message ??
                            "Email is already in use, please try with another email again!",
                        ColorManager.error,
                        4);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    isDisabled: _isLoading,
                    widget: _isLoading ? const ButtonLoadingIndicator() : null,
                    title: "Send",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.bloc<SignUpCubit>().checkIfEmailInUse(_email!);
                      }
                    },
                  );
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
