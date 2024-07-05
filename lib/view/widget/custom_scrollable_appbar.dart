import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomTitleBackButton extends StatelessWidget {
  const CustomTitleBackButton({
    super.key,
    required this.title,
    this.hideButton = false,
  });
  final String title;
  final bool? hideButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(8.w),
        if (!hideButton!)
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        Text(
          title,
          style: context.textTheme.bodyLarge
              ?.copyWith(fontSize: 20.spMin, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
