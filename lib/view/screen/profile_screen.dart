import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_profile_card_botton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/helper/scaffold_snakbar.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          child: Stack(
            children: [
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
                    top: 68,
                    child: Container(
                      width: 343,
                      height: 182,
                      decoration: BoxDecoration(
                          color: const Color(0xff7EBB9B).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    width: 102,
                    height: 102,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff00A859), width: 4),
                          shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 51,
                        backgroundImage:
                            AssetImage("assets/images/hafeez.jpeg"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Column(
                      children: [
                        Text("Mohammed hafeez",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00A859)))),
                        Text("mohammedhafiez.h@gmail.com",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 12,
                            )))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 270,
                    child: Column(
                      children: [
                        CustomProfileCardButton(
                          onTap: () {},
                          leadingImage: "assets/images/useradd.png",
                          trailingImage: "assets/images/edit.png",
                        ),
                        CustomProfileCardButton(
                          scale: 2,
                          onTap: () {},
                          leadingImage: "assets/images/email.png",
                          trailingImage: "assets/images/edit.png",
                        ),
                        CustomProfileCardButton(
                          scale: 2,
                          onTap: () {},
                          leadingImage: "assets/images/password.png",
                          trailingImage: "assets/images/edit.png",
                        ),
                        CustomProfileCardButton(
                          scale: 2,
                          onTap: () {},
                          leadingImage: "assets/images/task.png",
                          trailingImage: "assets/images/arrowdown.png",
                        ),
                        CustomProfileCardButton(
                          scale: 2,
                          onTap: () {},
                          leadingImage: "assets/images/securitycard.png",
                          trailingImage: "assets/images/arrowdown.png",
                        ),
                        CustomProfileCardButton(
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
                        height: 60,
                        onPressed: () {
                          logOut();
                          scaffoldSnackBar(context, "Log out");
                          Navigator.popUntil(context, (route) =>route.isFirst);
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
                      ))
                ],
              )
            ],
          )),
    );
  }
}
