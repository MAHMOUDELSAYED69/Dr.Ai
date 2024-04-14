import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';

class NFCScreen extends StatelessWidget {
  const NFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Text("NFC Screen"),
      ),
    );
  }
}
