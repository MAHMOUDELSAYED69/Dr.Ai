import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import '../../../../utils/constant/color.dart';
import '../../../../utils/constant/image.dart';
import '../../../../utils/helper/custom_dialog.dart';
import '../../../widget/custom_scrollable_appbar.dart';
import '../../../widget/my_stepper_form.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callDialog();
    });
  }

  void callDialog() => customDialog(context,
      secondButtoncolor: ColorManager.error,
      title: "Delete Account?!",
      subtitle: "Are you sure you want to delete your account?",
      buttonTitle: "Delete",
      onCancle: () => Navigator.popUntil(context, (route) => route.isFirst),
      image: ImageManager.errorIcon,
      dismiss: false,
      onPressed: () => context.bloc<AccountCubit>().deleteAccount());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(34.h),
          const CustomTitleBackButton(
            title: "",
            hideButton: true,
          ),
          Gap(20.h),
          const Column(
            children: [
              ReAuthanticateStepper(
                stepReachedNumber: 1,
                stepColorTwo: ColorManager.error,
                stepIconTwo: ImageManager.deteteAccountIcon,
                stepTitleOne: "Password",
                stepTitleTwo: "Delete Account",
              ),
            ],
          )
        ],
      ),
    );
  }
}
