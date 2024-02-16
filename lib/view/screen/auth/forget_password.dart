import 'dart:developer';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../logic/auth/forget_password/forget_password_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;

  resetPassword() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<ForgetPasswordCubit>(context)
          .resetPassword(email: email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
      if (state is ForgetPasswordLoading) {
        isLoading = true;
      }
      if (state is ForgetPasswordSuccess) {
        isLoading = false;
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        scaffoldSnackBar(context, "Check your E-mail");
      }
      if (state is ForgetPasswordFailure) {
        isLoading = false;
        scaffoldSnackBar(context, "There was an Error please try agin later!");
        log(state.message);
      }
    }, builder: (context, state) {
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
                  color: MyColors.grey1.withOpacity(0.40)),
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
                          color: MyColors.grey1,
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
                      fillColor: MyColors.white,
                      isVisibleColor: MyColors.green,
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      title: isLoading == false ? "Send link" : null,
                      widget: isLoading == true
                          ? const CircularProgressIndicator(
                              color: MyColors.white,
                            )
                          : null,
                      onPressed: resetPassword,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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
      return const ForgetPassword();
    },
  );
}
