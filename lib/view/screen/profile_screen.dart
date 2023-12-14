import 'dart:io';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/helper/alert_message.dart';
import 'package:dr_ai/core/helper/responsive.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:dr_ai/logic/image/image_cubit.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_profile_card_botton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../core/helper/scaffold_snakbar.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var fullName = CacheData.getdata(key: "fullName");
  var fullNameFire = CacheData.getdata(key: "fullNameFire");
  var email = CacheData.getdata(key: "email");
  var image = CacheData.getdata(key: "imageFire");
  bool isLoading = false;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageCubit, ImageState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        }
        if (state is ImageSuccess) {
          isLoading = false;
        }
        if (state is ImageFailure) {
          isLoading = false;
          alertMessage(context, message: "Faild to upload image");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/nav", (route) => false);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text("Profile",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: ScreenSize.height * 0.07839,
                        child: Container(
                          width: ScreenSize.width * 0.833680,
                          height: ScreenSize.height * 0.209815,
                          decoration: BoxDecoration(
                              color: const Color(0xff7EBB9B).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                      Positioned(
                        top: ScreenSize.height * 0.036890,
                        width: 102,
                        height: 102,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff00A859), width: 4),
                              shape: BoxShape.circle),
                          child: ModalProgressHUD(
                            inAsyncCall: isLoading,
                            child: CircleAvatar(
                                radius: 51,
                                backgroundImage: CacheData.getdata(
                                            key: "uploadImage") !=
                                        null
                                    ? FileImage(File(
                                        CacheData.getdata(key: "uploadImage")))
                                    : null),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenSize.height * 0.161396,
                        child: Column(
                          children: [
                            const Gap(8),
                            Text(fullName ?? fullNameFire ?? "Guest",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff00A859)))),
                            const Gap(2),
                            Text("$email",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                  fontSize: 14,
                                )))
                          ],
                        ),
                      ),
                      Positioned(
                        top: ScreenSize.height * 0.311264,
                        child: Column(
                          children: [
                            CustomProfileCardButton(
                              content: fullName ?? fullNameFire ?? "Guest",
                              onTap: () {},
                              leadingImage: "assets/images/useradd.png",
                              trailingImage: "assets/images/edit.png",
                            ),
                            CustomProfileCardButton(
                              content: "$email",
                              scale: 2,
                              onTap: () {},
                              leadingImage: "assets/images/email.png",
                              trailingImage: "assets/images/edit.png",
                            ),
                            CustomProfileCardButton(
                              content: "Password",
                              scale: 2,
                              onTap: () {},
                              leadingImage: "assets/images/password.png",
                              trailingImage: "assets/images/edit.png",
                            ),
                            CustomProfileCardButton(
                              content: "Health Information",
                              scale: 2,
                              onTap: () {},
                              leadingImage: "assets/images/task.png",
                              trailingImage: "assets/images/arrowdown.png",
                            ),
                            CustomProfileCardButton(
                              content: "Privacy",
                              scale: 2,
                              onTap: () {},
                              leadingImage: "assets/images/securitycard.png",
                              trailingImage: "assets/images/arrowdown.png",
                            ),
                            CustomProfileCardButton(
                              content: "Setting",
                              scale: 2,
                              onTap: () {},
                              leadingImage: "assets/images/setting.png",
                              trailingImage: "assets/images/arrowdown.png",
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            height: ScreenSize.height * 0.06916,
                            onPressed: () {
                              CacheData.clearData(clearData: true);
                              logOut();
                              scaffoldSnackBar(context, "Log out");
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/login", (route) => false);
                            },
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/logout.png",
                                  scale: 4,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text("Logout",
                                    style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )))
                              ],
                            ),
                            color: const Color(0xff313131),
                          )),
                      Positioned(
                          top: ScreenSize.height * 0.107213,
                          right: ScreenSize.width * 0.272222,
                          child: IconButton(
                              onPressed: () {
                                BlocProvider.of<ImageCubit>(context)
                                    .pickImageFromGallery();
                              },
                              icon: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(0xff7EBB9B),
                                backgroundImage:
                                    AssetImage("assets/images/add.png"),
                              ))),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
