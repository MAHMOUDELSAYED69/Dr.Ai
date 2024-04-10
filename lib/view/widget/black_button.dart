import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';

class Backbutton extends StatelessWidget {
  const Backbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back,
          color: context.iconTheme.color,
        ),
      ),
    );
  }
}
