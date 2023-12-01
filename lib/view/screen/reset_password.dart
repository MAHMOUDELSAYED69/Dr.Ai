import 'dart:developer';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? password;
  String? confirmPassword;

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
                    "Set the new password for your account so you can login and access all the features.",
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
                    cursorColor: Colors.black,
                    onSaved: (data) {
                      password = data;
                    },
                    textFieldStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    title: "Password",
                    titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    fillColor: Colors.white,
                    isVisible: true,
                    isVisibleColor: const Color(0xff00a859),
                  ),
                  CustomTextFormField(
                    cursorColor: Colors.black,
                    onSaved: (data) {
                      confirmPassword = data;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please fill out the field!";
                      }
                      if (confirmPassword != password) {
                        return "Wrong password";
                      }
                      return null;
                    },
                    textFieldStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    title: "Confirm-Password",
                    titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    fillColor: Colors.white,
                    isVisible: true,
                    isVisibleColor: const Color(0xff00a859),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    title: "Reset Password ",
                    onPressed: () {
                      formKey.currentState!.save();
                      if (formKey.currentState!.validate()) {
                        log("Email: $password");
                        Navigator.pop(context);
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

void showResetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35))),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ResetPasswordBottomSheet();
    },
  );
}
