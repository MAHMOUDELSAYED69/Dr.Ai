import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: Divider(
          color: MyColors.selver,
          thickness: 2,
          indent: 30,
          endIndent: 6,
        )),
        Text(
          "Or continue with",
          style: TextStyle(
            fontSize: 15,
            color: MyColors.selver,
          ),
        ),
        Expanded(
            child: Divider(
          color: MyColors.selver,
          thickness: 2,
          indent: 10,
          endIndent: 35,
        )),
      ],
    );
  }
}
