import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          color: MyColors.grey3,
          thickness: 1,
          endIndent: 10,
        )),
        Text(
          title,
          style:context.textTheme.bodySmall
        ),
        const Expanded(
            child: Divider(
          color: MyColors.grey3,
          thickness: 1,
          indent: 10,
        )),
      ],
    );
  }
}
