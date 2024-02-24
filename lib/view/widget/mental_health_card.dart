import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant/color.dart';

class MentalHealthCard extends StatelessWidget {
  const MentalHealthCard({
    super.key,
    required this.image,
    this.title = "Mental Health",
    this.subTitle = "",
    this.onTap,
  });

  final String image;
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: MyColors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    scale: 1.7,
                  )),
              const Gap(5),
              Text(title,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ))),
              Text(subTitle,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: MyColors.grey2)))
            ]),
      ),
    );
  }
}
