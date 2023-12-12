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
}
