import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constant/color.dart';

class Item {
  final String name;
  final IconData? icon;

  const Item(this.name, [this.icon]);
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
        DropdownButtonFormField2<Item>(
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_outlined),
          ),
          isDense: true,
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.only(left: 10.w),
            overlayColor: const WidgetStatePropertyAll(ColorManager.green),
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 4,
            maxHeight: 200.h,
            scrollbarTheme: const ScrollbarThemeData(
              thumbColor: WidgetStatePropertyAll(ColorManager.green),
            ),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          isExpanded: true,
          style:
              context.textTheme.bodySmall?.copyWith(color: ColorManager.black),
          hint: widget.hintText != null
              ? Text(
                  widget.hintText!,
                  style: context.textTheme.bodySmall,
                )
              : null,
          decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            errorMaxLines: 2,
            errorStyle: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.error, fontSize: 14.spMin),
            contentPadding:
                EdgeInsets.symmetric(vertical:12.5.h, horizontal: 10.w),
            filled: true,
            fillColor: ColorManager.white,
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
          items: widget.items.map((Item user) {
            return DropdownMenuItem<Item>(
              value: user,
              child: Row(
                children: [
                  (user.icon != null)
                      ? Icon(user.icon)
                      : SizedBox(
                          width: 5.w,
                        ),
                  if (user.icon != null) SizedBox(width: 10.w),
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
