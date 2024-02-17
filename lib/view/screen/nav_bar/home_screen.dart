import 'dart:io';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/responsive.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "assets/images/heath_1.png",
    "assets/images/heath_2.png",
    "assets/images/heath_3.png",
    "assets/images/heath_4.png",
    "assets/images/heath_5.png",
    "assets/images/heath_6.png",
  ];
  var user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(35),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.profile);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.green, width: 3),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: MyColors.green,
                          radius: 20,
                          backgroundImage: user.photoURL != null
                              ? FileImage(File(user.photoURL!))
                              : null,
                          child: user.photoURL == null
                              ? Text(
                                  user.displayName!.toUpperCase()[0],
                                  style: const TextStyle(
                                    color: MyColors.white,
                                    fontSize: 18,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName ??
                                "Guest",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: MyColors.white,
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize.width * 0.02882),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            Text(
                              "Chat in Doctor AI",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.green,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "Get instant medical advice anytime, anywhere with our trusted AI-powered doctor app. Chat now!",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: MyColors.grey1,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  borderRadius: 8,
                                  fontSize: 12,
                                  height: 33,
                                  width: 125,
                                  color: MyColors.green,
                                  title: "Start Chat",
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.chat);
                                  },
                                ),
                                const Gap(10),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          MyImages.robot,
                          width: 100,
                          height: 105,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                images[index],
                                scale: 2,
                              )),
                          Text("Mental Health",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ))),
                          Text("16 Conversations",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey2)))
                        ]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
