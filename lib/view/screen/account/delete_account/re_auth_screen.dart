import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/view/screen/account/change_password/old_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReAuthScreen extends StatelessWidget {
  const ReAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OldPasswordScreen(
      stepTitleOne: "Password",
      stepTitleTwo: "Delete Account",
      stepIconTwo: ImageManager.deteteAccountIcon,
      navigator: RouteManager.deleteAccount,
    );
  }
}
