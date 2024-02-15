import 'dart:developer';
import 'package:dr_ai/logic/auth/forget_password/forget_password_cubit.dart';
import 'package:dr_ai/logic/auth/login/login_cubit.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/logic/image/image_cubit.dart';
import 'package:dr_ai/view/screen/chat_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/archive_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/home_screen.dart';
import 'package:dr_ai/view/screen/auth/login_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/nav_bar_screen_.dart';
import 'package:dr_ai/view/screen/profile_screen.dart';
import 'package:dr_ai/view/screen/auth/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dr_ai/view/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/login": (context) => const LoginScreen(),
          "/register": (context) => const RegisterScreen(),
          "/home": (context) => const HomeScreen(),
          "/nav": (context) => const NavbarScreen(),
          "/chat": (context) => const ChatScreen(),
          "/profile": (context) => const ProfileScreen(),
          "/archive": (context) => const ArchiveScreen(),
        },
      ),
    );
  }
}
