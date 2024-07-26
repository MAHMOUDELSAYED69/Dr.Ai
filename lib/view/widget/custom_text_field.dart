import 'package:dr_ai/utils/constant/color.dart';
import 'package:dr_ai/utils/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.keyboardType,
    this.icon,
    this.title,
    this.isVisible,
    this.fillColor,
    this.isVisibleColor,
    this.cursorColor,
    this.obscureText,
    this.initialValue,
  });
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? isVisible;
  final Color? fillColor;
  final Color? isVisibleColor;
  final Color? cursorColor;
  final bool? obscureText;
  final String? initialValue;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isTap = false;
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
        child: Text(
          widget.title ?? "",
          style: context.textTheme.bodyMedium,
        ),
      ),
      TextFormField(
        initialValue: widget.initialValue,
        style: context.textTheme.bodySmall?.copyWith(color: ColorManager.black),
        cursorColor: widget.cursorColor ?? ColorManager.green,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText ??
            (widget.isVisible == true ? isObscure : false),
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "${widget.title} cannot be empty";
              } else {
                return null;
              }
            },
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        onTap: () {
          isTap = true;
          setState(() {});
        },
        onTapOutside: (_) {
          isTap = false;
          setState(() {});
        },
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          errorMaxLines: 2,
          errorStyle: context.textTheme.bodySmall
              ?.copyWith(color: ColorManager.error, fontSize: 14.spMin),
          suffixIcon: widget.isVisible == true
              ? _buildSuffixIcon(Icons.visibility_off, Icons.visibility)
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
          filled: true,
          fillColor: widget.fillColor ?? ColorManager.white,
          hintText: widget.hintText,
          hintStyle: context.textTheme.bodySmall,
          enabledBorder: context.inputDecoration.enabledBorder,
          focusedBorder: context.inputDecoration.focusedBorder,
          errorBorder: context.inputDecoration.errorBorder,
          focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
        ),
      )
    ]);
  }

  Widget _buildSuffixIcon(IconData icon1, IconData icon2) {
    return Builder(
      builder: (contxt) => IconButton(
        onPressed: () {
          isObscure = !isObscure;
          setState(() {});
        },
        icon: Icon(isObscure == true ? icon1 : icon2),
        color: isTap ? ColorManager.green : ColorManager.grey,
        iconSize: 21.r,
      ),
    );
  }
}
