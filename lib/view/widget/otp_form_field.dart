import 'package:flutter/material.dart';

class OtpFormTield extends StatelessWidget {
  const OtpFormTield({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 64,
      width: width ?? 68,
      child: TextFormField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 48),
      ),
    );
  }
}
