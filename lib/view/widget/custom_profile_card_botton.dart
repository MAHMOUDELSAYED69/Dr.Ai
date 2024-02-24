import 'package:dr_ai/core/constant/color.dart';
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
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        color: MyColors.green,
        child: SizedBox(
          height: 55,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, top: 15),
              child: Image.asset(
                leadingImage,
                color: MyColors.white,
                scale: scale ?? 3.5,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                trailingImage,
                color: MyColors.white,
                scale: 3.5,
              ),
            ),
            title: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: MyColors.white),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
