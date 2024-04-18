import 'dart:developer';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/logic/auth/forget_password/forget_password_cubit.dart';
import 'package:dr_ai/logic/auth/log_out/log_out_cubit.dart';
import 'package:dr_ai/logic/auth/sign_in/sign_in_cubit.dart';
import 'package:dr_ai/logic/auth/register/register_cubit.dart';
import 'package:dr_ai/logic/auth/sign_up/sign_up_cubit.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/logic/image/image_cubit.dart';
import 'package:dr_ai/logic/launch_uri/launch_uri_cubit.dart';
import 'package:dr_ai/logic/maps/maps_cubit.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helper/responsive.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

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
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => SignInCubit(),
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
        BlocProvider(
          create: (context) => FormvalidationCubit(),
        ),
        BlocProvider(
          create: (context) => LaunchUriCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Builder(
            builder: (_) => MaterialApp(
                  builder: (context, widget) {
                    final mediaQueryData = MediaQuery.of(context);
                    final scaledMediaQueryData = mediaQueryData.copyWith(
                      textScaler: TextScaler.noScaling,
                    );
                    return MediaQuery(
                      data: scaledMediaQueryData,
                      child: widget!,
                    );
                  },
                  themeAnimationStyle: AnimationStyle(
                    duration: const Duration(microseconds: 250),
                    curve: Curves.linear,
                  ),
                  debugShowCheckedModeBanner: false,
                  title: 'Dr AI',
                  theme: AppTheme.lightTheme,
                  initialRoute: RouteManager.initialRoute,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                )),
      ),
    );
  }
}
