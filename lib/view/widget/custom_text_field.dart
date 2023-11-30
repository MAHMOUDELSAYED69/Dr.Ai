import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.title,
      this.onSaved,
      this.validator,
      this.isVisible,
      required this.icon});
  final String title;
  final bool? isVisible;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final IconData icon;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(widget.title,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  textStyle: const TextStyle(color: Color(0xff8CAAB9)))),
        ),
        TextFormField(
          obscureText: widget.isVisible == true ? isObscure : false,
          validator: widget.validator ??
              (value) {
                if (value!.isEmpty) {
                  return "please fill ou the field!";
                }
                return null;
              },
          onSaved: widget.onSaved,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
            ),
            suffixIcon: widget.isVisible == true
                ? IconButton(
                    onPressed: () {
                      isObscure = !isObscure;
                      setState(() {});
                    },
                    icon: Icon(isObscure == true
                        ? Icons.visibility_off
                        : Icons.visibility))
                : null,
            fillColor: const Color(0xff00a859),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
