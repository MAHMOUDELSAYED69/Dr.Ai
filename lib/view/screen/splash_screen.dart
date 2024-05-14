import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/auth/log_out/log_out_cubit.dart';
import 'package:dr_ai/view/widget/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constant/color.dart';

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
                ? RouteManager.nav
                : RouteManager.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<LogOutCubit>().logOut();
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          customSnackBar(context, "Can't sign in right now!, Try Later",
              ColorManager.error, 5);
        }
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                ImageManager.splashLogo,
                width: context.width / 3,
                height: context.width / 3,
              ),
              const BuidSplashLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
