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

import 'core/helper/responsive.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'view/screen/auth/email_screen.dart';
import 'view/screen/nav_bar/maps_screen.dart';
import 'view/screen/nav_bar/home_screen.dart';
import 'view/screen/nav_bar/nav_bar_screen_.dart';
import 'view/screen/profile/profile_screen.dart';

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
    ScreenSize.init(context);
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
            title: 'Dr AI',
            theme: AppTheme.lightTheme,
            initialRoute: RoutesManager.initialRoute,
            onGenerateRoute: AppRouter.onGenerateRoute,
            routes: {
              RoutesManager.initialRoute: (context) => const SplashScreen(),
              RoutesManager.login: (context) => const LoginScreen(),
              RoutesManager.email: (context) => const EmailScreen(),
              RoutesManager.register: (context) => const RegisterScreen(),
              RoutesManager.home: (context) => const HomeScreen(),
              RoutesManager.nav: (context) => const NavbarScreen(),
              RoutesManager.chat: (context) => const ChatScreen(),
              RoutesManager.profile: (context) => const ProfileScreen(),
              RoutesManager.maps: (context) => const MapScreen(),
            },
          );
        }),
      ),
    );
  }
}
