import 'dart:developer';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:dr_ai/view/screen/auth/forget_password.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/constant/color.dart';
import '../../../logic/auth/google/login_with_google.dart';

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
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: MyColors.green,
          ),
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: MyColors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                            width: 160,
                            height: 110,
                            child: Image.asset("assets/images/logo.png")),
                      ),
                      Text("Welcome Back!",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ))),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        icon: MyImages.email,
                        onSaved: (data) {
                          email = data;
                        },
                        title: "Email Address",
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (data) {
                          password = data;
                        },
                        icon: MyImages.password,
                        isVisible: true,
                        title: "Password",
                      ),
                      GestureDetector(
                        onTap: () => showForgetPasswordBottomSheet(context),
                        child: Container(
                          padding: const EdgeInsets.only(top: 11),
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ))),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: CustomButton(
                            title: "Log in",
                            onPressed: login,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 37),
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: MyColors.selver,
                              thickness: 2,
                              indent: 30,
                              endIndent: 6,
                            )),
                            Text(
                              "Or continue with",
                              style: TextStyle(
                                fontSize: 15,
                                color: MyColors.selver,
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              color: MyColors.selver,
                              thickness: 2,
                              indent: 10,
                              endIndent: 35,
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 37),
                        child: CustomOutlineButton(
                          onPressed: () {
                            try {
                              GoogleService.signInWithGoogle();
                            } catch (err) {
                              log(err.toString());
                            }
                          },
                          title: "Google",
                          icon: MyImages.google,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don’t have an account?",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                  color: MyColors.selver,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, MyRoutes.register);
                              },
                              child: Text(" Sign Up",
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ))),
                            ),
                          ],
                        ),
                      )
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
