import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constant/color.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Transform.scale(
        scale: 1.1.r,
        child: Checkbox(
          activeColor: ColorManager.green,
          side: context.checkboxTheme.side,
          shape: context.checkboxTheme.shape,
          value: isChecked,
          onChanged: (value) {
            isChecked = value ?? false;
            setState(() {});
          },
        ),
      ),
      Text(
        "Remember Me",
        style: context.textTheme.bodySmall,
      )
    ]);
  }
}
