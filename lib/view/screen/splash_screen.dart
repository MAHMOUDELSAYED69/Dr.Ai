import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/logic/auth/log_out/log_out_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/helper/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation = Tween<double>(begin: .2, end: 1).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });
    animationController?.repeat(reverse: true);
    getToNewScreen();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LogOutCubit>(context).logOut();
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          Image.asset(MyImages.splash,
              width: double.infinity, fit: BoxFit.fill),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  AnimatedBuilder(
                      animation: animation!,
                      builder: (context, _) => Opacity(
                          opacity: animation?.value,
                          child: Image.asset(
                            MyImages.logo,
                            width: 160,
                            height: 110,
                          ))),
                  Text("Welcome to\n Doctor AI ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "start chatting with your medical assassistant Now.You can ask me onything",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyColors.grey1))),
                  ),
                  const Spacer(),
                  Text(
                    "V 0.0.01",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColors.lightBlue)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getToNewScreen() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushReplacementNamed(
            context,
            (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified)
                ? MyRoutes.nav
                : MyRoutes.login);
      },
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
