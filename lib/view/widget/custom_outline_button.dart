import 'package:flutter/material.dart';
import '../../utils/constant/color.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key, required this.title, this.onPressed, required this.icon});
  final String title;
  final String icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fixedSize: const Size(double.maxFinite, 65)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              scale: 2,
            ),
            Text("  $title",
                style: const TextStyle(
                  color: ColorManager.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ));
  }
}
