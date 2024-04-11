import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {super.key,
      this.dropDownList,
      required this.title,
      this.onChanged,
      this.selectedGender,
      required this.fieldTitle});
  final List<String>? dropDownList;
  final String title;
  final String fieldTitle;
  final void Function(String?)? onChanged;
  final String? selectedGender;

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

String? _selectedValue;

class CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(16.h),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            widget.title,
            style: context.textTheme.bodyMedium,
          ),
        ),
        Gap(8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dm),
            border: Border.all(color: ColorManager.grey, width: 2),
          ),
          alignment: Alignment.center,
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(8.dm),
            value: _selectedValue,
            hint: Text(
              widget.fieldTitle,
              style: context.textTheme.bodySmall,
            ),
            items: widget.dropDownList?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              widget.onChanged!(newValue);
              _selectedValue = newValue;
              setState(() {});
            },
            underline: Container(),
            dropdownColor: ColorManager.white,
            style: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.black),
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 26.r,
            elevation: 13,
          ),
        ),
      ],
    );
  }
}
