import 'package:dr_ai/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.label,
      this.onSaved,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.controller,
      this.height,
      this.width,
      this.keyboardType,
      this.icon,
      this.title,
      this.isVisible,
      this.fillColor,
      this.isVisibleColor,
      this.titleTextStyle,
      this.textFieldStyle,
      this.cursorColor});
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? isVisible;
  final Color? fillColor;
  final Color? isVisibleColor;
  final Color? cursorColor;
  final TextStyle? titleTextStyle;
  final TextStyle? textFieldStyle;
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
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 16.h,bottom: 8.h),
        child: Text(widget.title ?? "",
            style: widget.titleTextStyle ??
                TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.black)),
      ),
      TextFormField(
        style: widget.textFieldStyle ??
            TextStyle(
                color: MyColors.black, fontSize: 16.sp, fontFamily: "Poppins"),
        cursorColor: widget.cursorColor ?? MyColors.green,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isVisible == true ? isObscure : false,
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "please fill out the field!";
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
          errorStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
          // prefixIcon: widget.icon != null
          //     ? Image.asset(
          //         widget.icon!,
          //         scale: 1.9.sp,
          //         color: MyColors.black,
          //       )
          //     : null,
          suffixIcon: widget.isVisible == true
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(isObscure == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: isTap == false ? MyColors.grey3 : MyColors.green,
                  iconSize: 25.sp,
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
          filled: false //true
          ,
          fillColor: widget.fillColor ?? MyColors.green,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: MyColors.grey3, fontSize: 14.sp),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.grey3, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: MyColors.green, width: 2)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: MyColors.red, width: 2)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: MyColors.red, width: 2)),
        ),
      )
    ]);
  }
}
