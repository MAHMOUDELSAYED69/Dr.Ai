import 'package:flutter/material.dart';

abstract class PageTransitionManager {
  PageTransitionManager._();
  //? default transition
  static materialPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }

  static PageRouteBuilder slideTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder scaleTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder rotationTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder fadeTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder defaultTextStyleTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return DefaultTextStyleTransition(
          style: animation.drive(
            TextStyleTween(
              begin: const TextStyle(color: Colors.transparent),
              end: const TextStyle(color: Colors.black),
            ),
          ),
          child: child,
        );
      },
    );
  }

  // DecoratedBoxTransition
  static PageRouteBuilder decoratedBoxTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return DecoratedBoxTransition(
          decoration: animation.drive(
            DecorationTween(
              begin: const BoxDecoration(color: Colors.transparent),
              end: const BoxDecoration(color: Colors.blue),
            ),
          ),
          child: child,
        );
      },
    );
  }

  // PositionedTransition
  static PageRouteBuilder positionedTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return PositionedTransition(
          rect: animation.drive(
            RelativeRectTween(
              begin: RelativeRect.fill,
              end: const RelativeRect.fromLTRB(10, 10, 10, 10),
            ),
          ),
          child: child,
        );
      },
    );
  }

  // RelativeRectTween
  static PageRouteBuilder relativeRectTween(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return PositionedTransition(
          rect: animation.drive(
            RelativeRectTween(
              begin: RelativeRect.fill,
              end: const RelativeRect.fromLTRB(10, 10, 10, 10),
            ),
          ),
          child: child,
        );
      },
    );
  }

  // SizeTransition
  static PageRouteBuilder sizeTransition(Widget screen,
      [int milliseconds = 300]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
    );
  }
}
