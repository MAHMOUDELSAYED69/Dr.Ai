import 'package:flutter/material.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    this.onSaved, this.controller,
  });
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 68,
        child: TextFormField(
          controller:controller,
          //? autovalidateMode: AutovalidateMode.always, //! AUTO VALIDATE
          autofocus: true,
          onSaved: onSaved,
          onChanged: (data) {
            if (data.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            if (value.contains(RegExp(r'[a-z]'))) {
              return "";
            }
            if (value.contains(RegExp(r'[A-Z]'))) {
              return "";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            counterText: '',
            errorStyle: TextStyle(fontSize: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(width: 3, color: Color(0xff00a859)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(width: 3, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(width: 3, color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(width: 3, color: Color(0xffE5E5E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(width: 3, color: Color(0xff00a859)),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
