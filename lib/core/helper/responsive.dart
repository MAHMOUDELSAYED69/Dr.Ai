import 'package:flutter/material.dart';

class ScreenSize {
  static late double width;
  static late double height;
  static late double defaultSize;
  static late Orientation orientation;

  static void init(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize =
        orientation == Orientation.landscape ? width * .024 : height * .024;
  }

  static double getResponsiveFontSize(context, {required double fontSize}) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;

    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double getScaleFactor(context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < 550) {
      return width / 550;
    } else if (width < 500) {
      return width / 1000;
    } else {
      return width / 1920;
    }
  }
}
