import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/google/login_with_google.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_outline_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
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
  // TextEditingController txtController = TextEditingController(); to confirm password.
  String? email;
  String? password;
  bool isLoading = false;
  String? displayName;
  register() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      BlocProvider.of<RegisterCubit>(context).userRegister(
          email: email!, password: password!, fullName: displayName!);
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
          isLoading = false;
          //  CacheData.setData(key: "fullName", value: fullName); //remove
          // CacheData.setData(key: "email", value: email); //remove

          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          scaffoldSnackBar(context, "You can log in now");
        }
        if (state is RegisterFailure) {
          isLoading = false;
          scaffoldSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(
            color: Colors.green,
          ),
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
                          displayName = data;
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
                          padding: const EdgeInsets.only(top: 40),
                          child: CustomButton(
                            title: "Register",
                            onPressed: register,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 37),
                        child: Row(
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
                          onPressed: GoogleService.signInWithGoogle,
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
