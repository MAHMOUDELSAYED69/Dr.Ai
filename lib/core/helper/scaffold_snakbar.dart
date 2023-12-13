import 'package:flutter/material.dart';

void scaffoldSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
      content: Center(
    child: Text(
      message,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    ),
  )));
}
