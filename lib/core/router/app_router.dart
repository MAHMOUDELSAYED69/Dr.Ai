import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/view/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../../view/screen/auth/email_screen.dart';
import '../../view/screen/auth/register_screen.dart';
import '../../view/screen/chat/chat_screen.dart';
import '../../view/screen/nav_bar/home_screen.dart';
import '../../view/screen/nav_bar/maps_screen.dart';
import '../../view/screen/nav_bar/nav_bar_screen_.dart';
import '../../view/screen/profile/profile_screen.dart';
import '../../view/screen/splash_screen.dart';
import 'page_transition.dart';

abstract class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RoutesManager.login:
        return PageTransitionManager.fadeTransition(const LoginScreen());
      case RoutesManager.register:
        return PageTransitionManager.fadeTransition(const RegisterScreen());
      case RoutesManager.home:
        return PageTransitionManager.fadeTransition(const HomeScreen());
      case RoutesManager.email:
        return PageTransitionManager.fadeTransition(const EmailScreen());
      case RoutesManager.nav:
        return PageTransitionManager.materialPageRoute(const NavbarScreen());
      case RoutesManager.chat:
        return PageTransitionManager.fadeTransition(const ChatScreen());
      case RoutesManager.profile:
        return PageTransitionManager.materialPageRoute(const ProfileScreen());
      case RoutesManager.maps:
        return PageTransitionManager.fadeTransition(const MapScreen());
      default:
        return null;
    }
  }
}
