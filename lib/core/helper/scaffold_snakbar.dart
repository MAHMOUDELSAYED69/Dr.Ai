import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';

void customSnackBar(BuildContext context,
    [String? message, Color? color, int? seconds]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: (color ?? ColorManager.green).withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          message ?? "there was an error please try again later!",
          style:
              context.textTheme.bodySmall?.copyWith(color: ColorManager.white),
        ),
      )));
}
