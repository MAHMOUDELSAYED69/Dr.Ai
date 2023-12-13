import 'dart:developer';
import 'package:dr_ai/view/screen/reset_password.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({super.key});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController ctrl1=TextEditingController();
  TextEditingController ctrl2=TextEditingController();
  TextEditingController ctrl3=TextEditingController();
  TextEditingController ctrl4=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
                      "Enter 4 Digits Code",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Enter the 4 digits code that you received  on your email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                      Padding(
                       padding: const EdgeInsets.only(top: 65,bottom: 30),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtpField(controller: ctrl1),
                          OtpField(controller: ctrl2,),
                          OtpField(controller: ctrl3,),
                          OtpField(controller: ctrl4,),
                        ],
                                           ),
                     ),
                    CustomButton(
                      title: "Continue",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                         log("${ctrl1.text}${ctrl2.text}${ctrl3.text}${ctrl4.text}");
                         Navigator.pop(context);
                         showResetPasswordBottomSheet(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showOtpBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35))),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const OtpBottomSheet();
    },
  );
}
