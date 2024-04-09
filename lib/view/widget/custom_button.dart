import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.widget,
    this.size,
  });
  final String? title;
  final void Function()? onPressed;
  final Size? size;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: context.elevatedButtonTheme.style?.copyWith(
          fixedSize: MaterialStateProperty.all(
              size ?? Size(context.width, context.height * 0.06)),
        ),
        onPressed: onPressed,
        child: widget ??
            Text(
              title ?? "",
              style: context.textTheme.displayMedium,
            ));
  }
}
