import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:dr_ai/view/screen/auth/forget_password.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/color.dart';
import '../../widget/custom_check_box.dart';
import '../../widget/custom_divider.dart';
import '../../widget/custom_sign_up_button.dart';
import '../../widget/custom_text_span.dart';
import '../../widget/social_login_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.bloc<LoginCubit>().userLogin(email: email!, password: password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 100.h, left: 18.w, right: 18.w, bottom: 18.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CustomTextSpan(
                      fontSize: 32, textOne: "Welcome ", textTwo: "back"),
                  SizedBox(height: 8.h),
                  Text(
                    "Please enter your email & password to access your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: MyColors.grey3,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                  _buildEmailAndPasswordFields(),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      children: [
                        const CustomCheckBox(),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => showForgetPasswordBottomSheet(context),
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                decoration: TextDecoration.underline,
                                decorationColor: MyColors.green,
                                color: MyColors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 38),
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginLoading) {
                            isLoading = true;
                          }
                          if (state is LoginSuccess) {
                            isLoading = false;
                            FocusScope.of(context).unfocus();
                            if (FirebaseAuth
                                .instance.currentUser!.emailVerified) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, MyRoutes.nav, (route) => false);
                            }
                          }
                          if (state is LoginFailure) {
                            isLoading = false;
                            scaffoldSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            title: isLoading == false ? "Login" : null,
                            widget: isLoading == true
                                ? const CircularProgressIndicator(
                                    color: MyColors.white,
                                    strokeCap: StrokeCap.round)
                                : null,
                            onPressed: login,
                          );
                        },
                      )),
                  SignUpButton(
                    title: "Sign Up",
                    onTap: () => Navigator.pushNamed(context, MyRoutes.email),
                  ),
                  const CustomDivider(title: "Log in with"),
                  const SocialLoginCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailAndPasswordFields() {
    return Column(children: [
      CustomTextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (data) {
          email = data;
        },
        hintText: "Enter your Email",
        title: "Email",
      ),
      CustomTextFormField(
        keyboardType: TextInputType.visiblePassword,
        onSaved: (data) {
          password = data;
        },
        hintText: "Enter Your Password",
        isVisible: true,
        title: "Password",
      )
    ]);
  }
}
