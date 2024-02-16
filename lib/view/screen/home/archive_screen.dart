import 'dart:io';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/helper/responsive.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  var user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            children: [
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
                      child: CircleAvatar(
                          backgroundColor: const Color(0xff7EBB9B),
                          radius: 51,
                          backgroundImage: user.photoURL != null
                              ? FileImage(File(user.photoURL!)) 
                              : null,
                          child: user.photoURL == null
                              ? Text(
                                  user.displayName!.toUpperCase()[0],
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(color: Colors.white,fontSize: 32),
                                )
                              : null),
                    ),
                  ),
                  Positioned(
                    top: ScreenSize.height * 0.161396,
                    child: Column(
                      children: [
                        const Gap(2),
                        Text(user.displayName ?? "Guest",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00A859)))),
                        const Gap(2),
                        Text(user.email.toString(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 14,
                            ))),
                        const Gap(2),
                        CustomButton(
                          height: 33,
                          width: 130,
                          color: const Color(0xff00A859),
                          borderRadius: 8,
                          fontSize: 14,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/profile");
                          },
                          title: "Edit Profile",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
