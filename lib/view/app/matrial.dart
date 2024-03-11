import 'dart:developer';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/logic/auth/forget_password/forget_password_cubit.dart';
import 'package:dr_ai/logic/auth/log_out/log_out_cubit.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/logic/image/image_cubit.dart';
import 'package:dr_ai/logic/maps/maps_cubit.dart';
import 'package:dr_ai/view/screen/chat/chat_screen.dart';
import 'package:dr_ai/view/screen/auth/login_screen.dart';
import 'package:dr_ai/view/screen/auth/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_ai/view/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/nav_bar/maps_screen.dart';
import '../screen/nav_bar/home_screen.dart';
import '../screen/nav_bar/nav_bar_screen_.dart';
import '../screen/profile/profile_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
   initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(),
        ),
        BlocProvider(
          create: (context) => MapsCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Builder(builder: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: MyRoutes.initialRoute,
            routes: {
              MyRoutes.initialRoute: (context) => const SplashScreen(),
              MyRoutes.login: (context) => const LoginScreen(),
              MyRoutes.register: (context) => const RegisterScreen(),
              MyRoutes.home: (context) => const HomeScreen(),
              MyRoutes.nav: (context) => const NavbarScreen(),
              MyRoutes.chat: (context) => const ChatScreen(),
              MyRoutes.profile: (context) => const ProfileScreen(),
              MyRoutes.maps: (context) => const MapScreen(),
            },
          );
        }),
      ),
    );
  }
}
