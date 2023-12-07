import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/data/service/cloud_fire_store.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_profile_card_botton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/helper/scaffold_snakbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var fullName = CacheData.getdata(key: "fullName");
  var fullNameFire = CacheData.getdata(key: "fullNameFire");
  var email = CacheData.getdata(key: "email");
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.disconnect();
  }

  CollectionReference fireStore =
      FirebaseFirestore.instance.collection('image');
  File? selectedImage;

  Future pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return null;
    setState(() {
      selectedImage = File(returnImage.path);
    });
    fireStore.add({"img": "$selectedImage"});
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
                      child: CircleAvatar(
                        radius: 51,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Column(
                      children: [
                        Text(fullName ?? fullNameFire ?? "Guest",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00A859)))),
                        Text("$email",
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
                          content: fullName ?? fullNameFire ?? "Guest",
                          onTap: () {
                           
                          },
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
                        height: 60,
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
                      top: 93,
                      right: 112,
                      child: IconButton(
                          onPressed: pickImageFromGallery,
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
  }
}
