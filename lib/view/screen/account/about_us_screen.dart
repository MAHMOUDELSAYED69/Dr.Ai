import 'package:dr_ai/view/widget/custom_scrollable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/image.dart';
import '../../widget/build_profile_card.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = Divider(color: ColorManager.grey, thickness: 1.w);
    return Scaffold(
      body: Column(
        children: [
          Gap(32.h),
          const CustomTitleBackButton(
            title: "About Us",
          ),
          Gap(32.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                BuildProfileCard(
                  title: "App Updates",
                  image: ImageManager.updateIcon,
                  onPressed: () {},
                ),
                divider,
                BuildProfileCard(
                    title: "App Feedback",
                    image: ImageManager.feedbackIcon,
                    onPressed: () {}),
                divider,
                BuildProfileCard(
                    title: "Terms of use",
                    image: ImageManager.termsIcon,
                    onPressed: () {}),
                divider,
                BuildProfileCard(
                    title: "Privacy policy",
                    image: ImageManager.privacyPolicyIcon,
                    onPressed: () {}),
                divider,
                BuildProfileCard(
                    title: "Social Media",
                    image: ImageManager.socialMediaIcon,
                    onPressed: () {}),
                divider,
                BuildProfileCard(
                  removeColorIcon: true,
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
}