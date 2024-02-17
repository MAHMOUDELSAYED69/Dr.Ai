import 'package:dr_ai/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(widget.title ?? "",
            style: GoogleFonts.roboto(
                textStyle: widget.titleTextStyle ??
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MyColors.selver))),
      ),
      TextFormField(
        style: widget.textFieldStyle ??
            const TextStyle(color: MyColors.black, fontSize: 18),
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
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          errorStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          prefixIcon: widget.icon != null
              ? Image.asset(
                  widget.icon!,
                  scale: 1.9,color: MyColors.black,
                )
              : null,
          suffixIcon: widget.isVisible == true
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(isObscure == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: widget.isVisibleColor ?? MyColors.black,
                  iconSize: 25,
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: false //true
          ,
          fillColor: widget.fillColor ?? MyColors.green,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: MyColors.black),
         // label: Text(widget.label ?? ""),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: MyColors.green,width: 2)),
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
