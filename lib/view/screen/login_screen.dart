import 'dart:developer';

import 'package:dr_ai/view/screen/register_screen.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECFBFF),
      body: Padding(
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
                icon:Icons.person,
                onSaved: (data) {
                  email = data;
                },
                title: "Email Address",
              ),
              CustomTextFormField(
                onSaved: (data) {
                  password = data;
                },
                icon: Icons.password_sharp,
                isVisible: true,
                title: "Password",
              ),
              GestureDetector(
                onTap: () {},
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        log("Email: $email");
                        log("password: $password");
                       
                      }
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 37),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 111,
                    height: 2,
                    color: const Color(0xff8CAAB9),
                  ),
                  const Text("Or continue with",
                      style: TextStyle(
                        color: Color(0xff8CAAB9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 111,
                    height: 2,
                    color: const Color(0xff8CAAB9),
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 37),
                child: CustomOutlineButton(
                  title: "Google",
                  icon: Icons.g_mobiledata,
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
                          color: Color(0xff8CAAB9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ))),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
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
    );
  }
}
