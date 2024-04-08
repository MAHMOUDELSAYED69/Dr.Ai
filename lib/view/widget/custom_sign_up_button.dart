import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.title,
    this.onTap,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subtitle ?? "Don’t have an account? ",
            style: context.textTheme.bodySmall,
          ),
          Text(
            title,
            style: context.textTheme.displaySmall,
          ),
          const Icon(
            Icons.arrow_outward,
            color: ColorManager.green,
          )
        ],
      ),
    );
  }
}
