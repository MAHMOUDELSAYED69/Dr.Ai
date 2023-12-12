import 'dart:developer';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/helper/responsive.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/google/login_with_google.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/view/screen/nav_bar/home_screen.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isClick = false;
  String? fullName;
  String? email;
  String? password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        }
        if (state is RegisterSuccess) {
          isLoading = false;
          CacheData.setData(key: "fullName", value: fullName);
          CacheData.setData(key: "email", value: email);
          Navigator.pushNamedAndRemoveUntil(context, "/nav", (route) => false);
          FocusScope.of(context).unfocus();
        }
        if (state is RegisterFailure) {
          isLoading = false;
          scaffoldSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
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
                      Text("Create your account",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ))),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        icon: "assets/images/fullname.png",
                        title: "Full Name",
                        onSaved: (data) {
                          fullName = data;
                        },
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        icon: "assets/images/email.png",
                        title: "Email Address",
                        onSaved: (data) {
                          email = data;
                        },
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        icon: "assets/images/password.png",
                        onSaved: (data) {
                          password = data;
                        },
                        isVisible: true,
                        title: "Password",
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSize.height * 0.05764),
                          child: CustomButton(
                              title: "Register",
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  BlocProvider.of<RegisterCubit>(context)
                                      .userRegister(
                                          fullName: fullName!,
                                          email: email!,
                                          password: password!);
                                }
                              })),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenSize.height * 0.043807),
                        child: const Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Color(0xff8CAAB9),
                              thickness: 2,
                              indent: 30,
                              endIndent: 6,
                            )),
                            Text(
                              "Or continue with",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff8CAAB9),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              color: Color(0xff8CAAB9),
                              thickness: 2,
                              indent: 10,
                              endIndent: 35,
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenSize.height * 0.043807),
                        child: const CustomOutlineButton(
                          onPressed: signInWithGoogle,
                          title: "Google",
                          icon: "assets/images/google.png",
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenSize.height * 0.02882),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don’t have an account?",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                  color: Color(0xff8CAAB9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
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
