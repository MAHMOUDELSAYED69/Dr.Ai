import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/logic/auth/log_out/log_out_cubit.dart';
import 'package:dr_ai/view/widget/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/helper/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getToLoginScreen();
  }

  void getToLoginScreen() {
    Future.delayed(
      const Duration(
        milliseconds: 1500,
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
  Widget build(BuildContext context) {
    BlocProvider.of<LogOutCubit>(context).logOut();
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              ImageManager.splashLogo,
              width: ScreenSize.width / 3,
              height: ScreenSize.width / 3,
            ),
            const BuidLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
