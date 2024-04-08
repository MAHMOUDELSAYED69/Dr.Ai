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

class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return _buildPageTransitionAnimation(const SplashScreen());
      case RoutesManager.login:
        return _buildPageTransitionAnimation(const LoginScreen());
      case RoutesManager.register:
        return _buildPageTransitionAnimation(const RegisterScreen());
      case RoutesManager.home:
        return _buildPageTransitionAnimation(const HomeScreen());
      case RoutesManager.email:
        return _buildPageTransitionAnimation(const EmailScreen());
      case RoutesManager.nav:
        return _buildPageTransitionAnimation(const NavbarScreen());
      case RoutesManager.chat:
        return _buildPageTransitionAnimation(const ChatScreen());
      case RoutesManager.profile:
        return _buildPageTransitionAnimation(const ProfileScreen());
      case RoutesManager.maps:
        return _buildPageTransitionAnimation(const MapScreen());
      default:
        return null;
    }
  }

  static PageRouteBuilder _buildPageTransitionAnimation(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
