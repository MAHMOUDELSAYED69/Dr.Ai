import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class Item {
  final String name;
  final Icon? icon;

  const Item(this.name, {this.icon});
}

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    super.key,
    required this.title,
    required this.items,
    this.icon,
    this.validator,
    this.hintText,
    this.onSaved,
  });
  final String title;
  final List<Item> items;
  final Icon? icon;
  final FormFieldValidator<Item>? validator;
  final Function(Item?)? onSaved;
  final String? hintText;

  @override
  CustomDropDownFieldState createState() => CustomDropDownFieldState();
}

class CustomDropDownFieldState extends State<CustomDropDownField> {
  Item? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
          child: Text(
            widget.title,
            style: context.textTheme.bodyMedium,
          ),
        ),
        DropdownButtonFormField<Item>(
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          style:
              context.textTheme.bodySmall?.copyWith(color: ColorManager.black),
          decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            errorMaxLines: 2,
            errorStyle: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.error, fontSize: 14.spMin),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
            filled: true,
            fillColor: ColorManager.white,
            hintText: widget.hintText,
            hintStyle: context.textTheme.bodySmall,
            enabledBorder: context.inputDecoration.enabledBorder,
            focusedBorder: context.inputDecoration.focusedBorder,
            errorBorder: context.inputDecoration.errorBorder,
            focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
          ),
          value: selectedUser,
          onChanged: (Item? value) {
            setState(() {
              selectedUser = value;
            });
          },
          onSaved: widget.onSaved,
          items:  widget.items.map((Item user) {
            return   DropdownMenuItem<Item>(
              value: user,
              child:   Row(
                children: [
                  if (user.icon != null) user.icon!,
                  const SizedBox(width: 10),
                  Text(
                    user.name,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: ColorManager.black),
                  ),
                ],
              ),
            );
          }).toList(),
          validator: widget.validator ??
              (Item? value) {
                if (value == null) {
                  return "${widget.title} cannot be empty";
                } else {
                  return null;
                }
              },
        ),
      ],
    );
  }
}
