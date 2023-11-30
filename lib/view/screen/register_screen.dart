import 'dart:developer';

import 'package:dr_ai/view/screen/register_screen.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECFBFF),
      body: Padding(
        padding: const EdgeInsets.all(25),
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
              icon: Icons.person,
              title: "Full Name",
              onSaved: (data) {
                fullName = data;
              },
            ),
            CustomTextFormField(
              icon: Icons.person_pin_outlined,
              title: "Email Address",
              onSaved: (data) {
                email = data;
              },
            ),
            CustomTextFormField(
              icon: Icons.password,
              onSaved: (data) {
                password = data;
              },
              isVisible: true,
              title: "Password",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Row(children: [
                Checkbox(
                    value: isClick,
                    onChanged: (value) {
                      isClick = value ?? false;
                      setState(() {});
                    }),
                const Text(
                    "I have read & agreed to DayTask Privacy Policy\n,Terms & Condition",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ))
              ]),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 38),
                child: CustomButton(
                    title: "Log in",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        log("Full Name: $fullName");
                        log("Email: $email");
                        log("password: $password");
                      }
                    })),
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
    );
  }
}
