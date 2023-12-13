import 'dart:io';

import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/cache/cache.dart';
import '../../../core/helper/responsive.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  var fullName = CacheData.getdata(key: "fullName");
  var fullNameFire = CacheData.getdata(key: "fullNameFire");
  var email = CacheData.getdata(key: "email");
  var image = CacheData.getdata(key: "imageFire");
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
                          radius: 51,
                          backgroundImage: CacheData.getdata(
                                      key: "uploadImage") !=
                                  null
                              ? FileImage(
                                  File(CacheData.getdata(key: "uploadImage")))
                              : null),
                    ),
                  ),
                  Positioned(
                    top: ScreenSize.height * 0.161396,
                    child: Column(
                      children: [
                        const Gap(2),
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
