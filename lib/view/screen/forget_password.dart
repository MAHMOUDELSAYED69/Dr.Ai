import 'dart:developer';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/view/screen/otp_screen.dart';
import 'package:dr_ai/view/screen/register_screen.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordBottomSheet extends StatefulWidget {
  const ForgetPasswordBottomSheet({super.key});

  @override
  State<ForgetPasswordBottomSheet> createState() =>
      _ForgetPasswordBottomSheetState();
}

class _ForgetPasswordBottomSheetState extends State<ForgetPasswordBottomSheet> {
  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // Future<void> sendOTPEmail(String email) async {
  //   try {
  //     await FirebaseAuth.instance.sendSignInLinkToEmail(
  //       email: email,
  //       actionCodeSettings: ActionCodeSettings(
  //         url: 'https://schemas.android.com/apk/res/android',
  //         handleCodeInApp: true,
  //         androidPackageName: 'com.example.dr_ai',
  //         dynamicLinkDomain: "dr-aiapp.com",

  //       ),
  //     );
  //     log('OTP email sent successfully!');
  //   } catch (e) {
  //     log('Failed to send OTP email: $e');
  //   }
  // }

  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 19),
            width: 145,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(74),
                color: const Color(0xffd9d9d9)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                  top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Forgot Password",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Enter Your email for the verification processes, we will send a 4-digit code to your email.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (data) {
                      email = data;
                    },
                    textFieldStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    title: "E-mail",
                    titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    fillColor: Colors.white,
                    isVisibleColor: const Color(0xff00a859),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    title: "Continue",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // sendOTPEmail(email!);
                        Navigator.pop(context);
                        scaffoldSnackBar(context, "Check your E-mail");
                        // showOtpBottomSheet(context);
                        //  showOtpBottomSheet(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35))),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ForgetPasswordBottomSheet();
    },
  );
}
