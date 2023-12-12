import 'dart:developer';
import 'package:dr_ai/view/screen/login_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/nav_bar_screen_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final textTheme = Theme.of(context).textTheme;
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset("assets/images/splash_bg.png",
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
                            "assets/images/logo.png",
                            width: 160,
                            height: 110,
                          ))),
                  Text("Welcome to\n Doctor AI ",
                      textAlign: TextAlign.center, style: textTheme.bodyMedium),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "start chatting with your medical assassistant Now.You can ask me onything",
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium),
                  ),
                  const Spacer(),
                  Text(
                    "V 0.0.01",
                    style: textTheme.bodySmall,
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FirebaseAuth.instance.currentUser == null
                    ? const LoginScreen()
                    : const NavbarScreen()));
      },
    );
  }
  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
