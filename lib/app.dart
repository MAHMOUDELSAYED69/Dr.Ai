import 'package:dr_ai/utils/constant/routes.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils/constant/color.dart';
import 'utils/helper/responsive.dart';
import 'router/app_router.dart';
import 'utils/theme/app_theme.dart';
import 'logic/account/account_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => ValidationCubit(),
        ),
        BlocProvider(
          create: (context) => AccountCubit(),
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
                    curve: Curves.ease,
                  ),
                  color: ColorManager.white,
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
