// ignore_for_file: deprecated_member_use

import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/profile/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/image.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = Divider(color: ColorManager.grey, thickness: 1.w);
    return Scaffold(
      body: Column(
        children: [
          Gap(32.h),
          const CustomScrollableAppBar(
            title: "About Us",
          ),
          Gap(32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                _buildProfileCard(context,
                    title: "App Updates",
                    image: ImageManager.updateIcon,
                    onPressed: () {}),
                divider,
                _buildProfileCard(context,
                    title: "App Feedback",
                    image: ImageManager.feedbackIcon,
                    onPressed: () {}),
                divider,
                _buildProfileCard(context,
                    title: "Terms of use",
                    image: ImageManager.termsIcon,
                    onPressed: () {}),
                divider,
                _buildProfileCard(context,
                    title: "Privacy policy",
                    image: ImageManager.privacyPolicyIcon,
                    onPressed: () {}),
                divider,
                _buildProfileCard(context,
                    title: "Social Media",
                    image: ImageManager.socialMediaIcon,
                    onPressed: () {}),
                divider,
                _buildProfileCard(context,
                    title: "Support",
                    image: ImageManager.splashLogo,
                    onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context,
      {required String title,
      String? image,
      Color? color,
      IconData? iconData,
      VoidCallback? onPressed}) {
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(vertical: 5.h),
      title: Text(title, style: context.textTheme.bodyMedium),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_forward_ios,
            size: 16.r, grade: 60, color: color ?? ColorManager.green),
      ),
      leading: Container(
        width: 46.w,
        height: 46.w,
        decoration: BoxDecoration(
            color: (color ?? ColorManager.green).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.dm)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.w),
        child: iconData == null
            ? SvgPicture.asset(
                image!,
                color: color ?? ColorManager.green,
                width: 20.w,
                height: 20.w,
              )
            : Icon(
                iconData,
                color: ColorManager.error,
                size: 22.r,
              ),
      ),
    );
  }
}
