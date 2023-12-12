import 'package:flutter/material.dart';

void alertMessage(context, {String? message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Icon(Icons.warning_amber),
      content: Text(message ?? "there was an error please try again later!"),
    ),
  );
}
