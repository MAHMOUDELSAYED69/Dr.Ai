import 'package:dr_ai/core/constant/routes.dart';
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
import '../../widget/custom_divider.dart';

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
  bool isChecked = false;
  login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<LoginCubit>(context)
          .userLogin(email: email!, password: password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isLoading = true;
        }
        if (state is LoginSuccess) {
          isLoading = false;
          FocusScope.of(context).unfocus();
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
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
        return Scaffold(
          backgroundColor: MyColors.white,
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome ",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("back",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: MyColors.green,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Row(children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  activeColor:MyColors.green,
                                  side: const BorderSide(
                                      color: MyColors.grey3, width: 1.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  value: isChecked,
                                  onChanged: (value) {
                                    isChecked = value ?? false;
                                    setState(() {});
                                  },
                                ),
                              ),
                               Text(
                                "Remember Me",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: MyColors.grey3,
                                    fontSize: 14.sp),
                              )
                            ]),
                            const Spacer(),
                            GestureDetector(
                              onTap: () =>
                                  showForgetPasswordBottomSheet(context),
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
                          child: CustomButton(
                            title: isLoading == false ? "Login" : null,
                            widget: isLoading == true
                                ? const CircularProgressIndicator(
                                    color: MyColors.white,
                                  )
                                : null,
                            onPressed: login,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don’t have an account?",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: MyColors.grey3,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, MyRoutes.register);
                              },
                              child: Row(
                                children: [
                                  Text(" Sign Up",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        decoration: TextDecoration.underline,
                                        decorationColor: MyColors.green,
                                        color: MyColors.green,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  const Icon(
                                    Icons.arrow_outward,
                                    color: MyColors.green,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: const CustomDivider(title: "Log in with"),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    side: BorderSide(
                                        width: 3,
                                        color: MyColors.green.withOpacity(0.3)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    fixedSize: Size(95.w, 50.h)),
                                child: Image.asset("assets/images/google.png"),
                                onPressed: () {},
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    side: BorderSide(
                                        width: 3,
                                        color: MyColors.green.withOpacity(0.3)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    fixedSize: Size(95.w, 50.h)),
                                child:
                                    Image.asset("assets/images/facebook.png"),
                                onPressed: () {},
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    side: BorderSide(
                                        width: 3,
                                        color: MyColors.green.withOpacity(0.3)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    fixedSize: Size(95.w, 50.h)),
                                child: Image.asset("assets/images/apple.png"),
                                onPressed: () {},
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
