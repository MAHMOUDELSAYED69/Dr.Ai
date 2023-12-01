import 'dart:developer';
import 'package:dr_ai/view/screen/forget_password.dart';
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
                Text("Welcome Back!",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ))),
                CustomTextFormField(
                  icon:"assets/images/email.png",
                  onSaved: (data) {
                    email = data;
                  },
                  title: "Email Address",
                ),
                CustomTextFormField(
                  onSaved: (data) {
                    password = data;
                  },
                  icon:"assets/images/password.png",
                  isVisible: true,
                  title: "Password",
                ),
                GestureDetector(
                  onTap: () {
                    showForgetPasswordBottomSheet(context);
                  },
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
                          formKey.currentState!.save();
                          log("Email: $email");
                          log("password: $password");
                        }
                      },
                    )
                    ),
                const Padding(
                  padding: EdgeInsets.only(top: 37),
                  child:
                      Row(
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
                const Padding(
                  padding: EdgeInsets.only(top: 37),
                  child: CustomOutlineButton(
                    title: "Google",
                    icon: "assets/images/google.png",
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
      ),
    );
  }
}
