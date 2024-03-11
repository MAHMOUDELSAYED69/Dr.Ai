
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
    return Row(children: [
      Transform.scale(
        scale: 1.4,
        child: Checkbox(
          activeColor: MyColors.green,
          side: const BorderSide(color: MyColors.grey3, width: 1.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          value: isChecked,
          onChanged: (value) {
            isChecked = value ?? false;
            setState(() {});
          },
        ),
      ),
      Text(
        "Remember Me",
        style: TextStyle(
            fontFamily: "Poppins", color: MyColors.grey3, fontSize: 14.sp),
      )
    ]);
  }
}
