import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../logic/auth/social_auth/social_auth.dart';

class SocialLoginCard extends StatelessWidget {
  const SocialLoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.outlinedButtonTheme.style?.copyWith(
      fixedSize: MaterialStateProperty.all(
        Size(context.width / 3.8, context.height * 0.07),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          style: style,
          child: _buildSVGIcon(ImageManager.googleIcon),
          onPressed: () => context.bloc<SocialAuthCubit>().signInWithGoogle(),
        ),
        OutlinedButton(
          style: style,
          child: _buildSVGIcon(ImageManager.facebookIcon),
          onPressed: () {},
        ),
        OutlinedButton(
          style: style,
          child: _buildSVGIcon(ImageManager.appleIcon),
          onPressed: () {},
        ),
      ],
    );
  }

  SvgPicture _buildSVGIcon(String icon) {
    return SvgPicture.asset(
      icon,
      width: 24.w,
      height: 24.w,
    );
  }
}
