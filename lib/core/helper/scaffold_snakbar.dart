import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';

void scaffoldSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ColorManager.error,
      content: Center(
        child: Text(
          message,
          style:
              context.textTheme.bodySmall?.copyWith(color: ColorManager.white),
        ),
      )));
}
