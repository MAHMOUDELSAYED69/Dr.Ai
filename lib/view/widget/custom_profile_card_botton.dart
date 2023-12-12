import 'package:dr_ai/core/helper/responsive.dart';
import 'package:flutter/material.dart';

class CustomProfileCardButton extends StatelessWidget {
  const CustomProfileCardButton(
      {super.key,
      required this.leadingImage,
      required this.trailingImage,
      this.onTap,
      this.scale,
      required this.content});
  final String leadingImage;
  final String trailingImage;
  final String content;
  final void Function()? onTap;
  final double? scale;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Card(
        color: const Color(0xff00A859),
        child: SizedBox(
          height: ScreenSize.height * 0.05764,
          width: MediaQuery.sizeOf(context).width * 0.83,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, top: 15),
              child: Image.asset(
                leadingImage,
                color: Colors.white,
                scale: scale ?? 3.5,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                trailingImage,
                color: Colors.white,
                scale: 3.5,
              ),
            ),
            title: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
