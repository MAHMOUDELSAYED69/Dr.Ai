import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../logic/account/account_cubit.dart';
import '../constant/routes.dart';
import 'scaffold_snakbar.dart';

void alertMessage(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Icon(Icons.warning_amber),
      content: Text(message ?? "there was an error please try again later!"),
    ),
  );
}

void customDialog(BuildContext context,
    {required String title,
    required String subtitle,
    required String buttonTitle,
    required VoidCallback onPressed,
    required String image,
    String? errorMessage,
    Color? secondButtoncolor,
    Widget? widget,
    bool? dismiss}) {
  showDialog(
      context: context,
      barrierDismissible: dismiss ?? true,
      builder: (_) => CustomDialog(
            title: title,
            subtitle: subtitle,
            buttonTitle: buttonTitle,
            onPressed: onPressed,
            image: image,
            errorMessage: errorMessage,
            secondButtoncolor: secondButtoncolor,
            widget: widget,
          ));
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    required this.onPressed,
    required this.image,
    this.errorMessage,
    this.secondButtoncolor,
    this.widget,
  });
  final String title;
  final String subtitle;
  final String? errorMessage;
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color? secondButtoncolor;
  final Widget? widget;
  final String image;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool _islogoutLoading = false;
  bool _isDeleteAccountLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: REdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.dm),
      ),
      elevation: 0,
      backgroundColor: ColorManager.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountLogoutLoading) {
          _islogoutLoading = true;
        }

        if (state is AccountLogoutSuccess) {
          _islogoutLoading = false;
          Navigator.pushNamedAndRemoveUntil(
              context, RouteManager.login, (route) => false);
          customSnackBar(context, state.message, ColorManager.error);
        }
        if (state is AccountDeleteLoading) {
          _isDeleteAccountLoading = true;
        }
        if (state is AccountDeleteSuccess) {
          _isDeleteAccountLoading = false;
       
          Navigator.pushNamedAndRemoveUntil(
              context, RouteManager.login, (route) => false);

          customSnackBar(context, state.message, ColorManager.error);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12.dm),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                widget.image,
                width: 125.w,
                height: 125.w,
              ),
              Gap(18.h),
              Text(widget.title,
                  style: context.textTheme.bodyLarge?.copyWith(
                      color: widget.secondButtoncolor, fontSize: 18.spMin)),
              Gap(8.h),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall,
              ),
              (widget.errorMessage != null)
                  ? Text(
                      widget.errorMessage!,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: ColorManager.error,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : const SizedBox(),
              Gap(22.h),
              widget.secondButtoncolor != null
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            size: Size.fromHeight(42.w),
                            title: "Cancel",
                            onPressed: () => context.pop(),
                          ),
                        ),
                        Gap(5.w),
                        Expanded(
                          child: CustomButton(
                            size: Size.fromHeight(42.w),
                            widget: (_islogoutLoading == true ||
                                    _isDeleteAccountLoading == true)
                                ? const ButtonLoadingIndicator()
                                : null,
                            backgroundColor: widget.secondButtoncolor,
                            title: widget.buttonTitle,
                            onPressed: widget.onPressed,
                          ),
                        ),
                      ],
                    )
                  : CustomButton(
                      size: Size(context.width, 42.w),
                      widget: widget.widget,
                      title: widget.buttonTitle,
                      onPressed: widget.onPressed,
                    ),
            ],
          ),
        );
      },
    );
  }
}
