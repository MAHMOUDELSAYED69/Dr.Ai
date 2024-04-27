import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/social_auth/social_auth.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_divider.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  String? displayName;
  String? chronicDiseases;
  String? familyChronicDiseases;
  String? previousOperations;
  String? allergies;

  register() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      BlocProvider.of<RegisterCubit>(context).userRegister(
          email: email!, password: password!, displayName: displayName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        }
        if (state is RegisterSuccess) {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          customSnackBar(context, "Verify your E-mail and Login");
          isLoading = false;
        }
        if (state is RegisterFailure) {
          isLoading = false;
          customSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                          child: Image.asset(MyImages.logo)),
                    ),
                    Text("Create your account",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ))),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      title: "Full Name",
                      onSaved: (data) {
                        displayName = data;
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      title: "Email Address",
                      onSaved: (data) {
                        email = data;
                      },
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (data) {
                        password = data;
                      },
                      isVisible: true,
                      title: "Password",
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      icon: MyImages.healthA5,
                      onSaved: (data) {
                        chronicDiseases = data;
                      },
                      title: "Chronic Diseases",
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      icon: MyImages.healthA5,
                      onSaved: (data) {
                        familyChronicDiseases = data;
                      },
                      title: "Family Chronic Diseases",
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      icon: MyImages.healthA5,
                      onSaved: (data) {
                        previousOperations = data;
                      },
                      title: "Previous Operations",
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      icon: MyImages.healthA5,
                      onSaved: (data) {
                        allergies = data;
                      },
                      title: "Allergies",
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: CustomButton(
                          title: isLoading == false ? "Register" : null,
                          widget: isLoading == true
                              ? const CircularProgressIndicator(
                                  color: MyColors.white,
                                )
                              : null,
                          onPressed: register,
                        )),
                    const Padding(
                        padding: EdgeInsets.only(top: 37),
                        child: CustomDivider(
                            title: "Create your account quickly with")),
                    const Padding(
                      padding: EdgeInsets.only(top: 37),
                      child: CustomOutlineButton(
                        title: "Google",
                        icon: MyImages.google,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                color: MyColors.selver,
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
        );
      },
    );
  }
}
