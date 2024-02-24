import 'dart:developer';
import 'dart:io';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/responsive.dart';
import 'package:dr_ai/logic/other/contact_func.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color.dart';
import '../../../core/helper/scaffold_snakbar.dart';
import '../../../logic/image/image_cubit.dart';
import '../../widget/mental_health_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser!;
  bool isImageLoading = false;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 15, left: 15, top: 35),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.profile);
                },
                child: BlocConsumer<ImageCubit, ImageState>(
                  listener: (context, state) {
                    if (state is Imageloading) {
                      isImageLoading = true;
                    }
                    if (state is ImageSuccess) {
                      isImageLoading = false;
                      imageUrl = state.imageUrl;
                    }
                    if (state is ImageFailure) {
                      isImageLoading = false;
                      scaffoldSnackBar(context,
                          "There was an error please try again later!");
                      log(state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: MyColors.green, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: isImageLoading == true
                                ? const CircleAvatar(
                                    backgroundColor: MyColors.green2,
                                    radius: 25,
                                    child: CircularProgressIndicator(
                                      color: MyColors.green,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: MyColors.green,
                                    radius: 25,
                                    backgroundImage: imageUrl != null
                                        ? FileImage(File(imageUrl!))
                                        : user.photoURL != null
                                            ? FileImage(File(user.photoURL!))
                                            : null,
                                    child: imageUrl == null &&
                                            user.photoURL == null
                                        ? SizedBox(
                                            child: Text(
                                            user.displayName
                                                .toString()
                                                .toUpperCase()[0],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: MyColors.white,
                                              fontSize: 18,
                                            ),
                                          ))
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
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                FirebaseAuth
                                        .instance.currentUser!.displayName ??
                                    "Guest",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
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
                                  fontSize: 14,
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
                                  width: 140,
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
                          width: 130,
                          height: 135,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  MentalHealthCard(
                    image: MyImages.ambulance,
                    title: "Ambulance",
                    subTitle: "123",
                    onTap: () =>
                        OtherMethod.openContactsApp(phoneNumber: '123'),
                  ),
                  MentalHealthCard(
                    image: MyImages.amergency,
                    title: "Amergency",
                    subTitle: "112",
                    onTap: () =>
                        OtherMethod.openContactsApp(phoneNumber: '122'),
                  ),
                  MentalHealthCard(
                    image: MyImages.fireAmbulance,
                    title: "Firefighting",
                    subTitle: "180",
                    onTap: () =>
                        OtherMethod.openContactsApp(phoneNumber: '180'),
                  ),
                  MentalHealthCard(
                    image: MyImages.healthA4,
                    onTap: () {},
                  ),
                  MentalHealthCard(
                    image: MyImages.healthA5,
                    onTap: () {},
                  ),
                  MentalHealthCard(
                    image: MyImages.healthA6,
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
