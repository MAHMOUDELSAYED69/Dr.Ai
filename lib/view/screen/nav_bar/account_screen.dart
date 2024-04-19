import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
           Gap(25.h),
            _buildUserCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.dm),
        side: BorderSide(color: ColorManager.grey, width: 1.w),
      ),
      child: ListTile(
        leading: Container(
          alignment: Alignment.center,
          height: 50.w,
          width: 50.w,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8.dm),
            border: Border.all(width: 1.5.w, color: ColorManager.green),
          ),
          child: Text(
            "M",
            style: context.textTheme.bodyLarge,
          ),
        ),
        title: Text(
          "Mahmoud",
          style: context.textTheme.bodyMedium,
        ),
        subtitle: Text(
          "5h9pY@example.com",
          style: context.textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding:
            EdgeInsets.only(left: 12.w, right: 4.w, bottom: 5.h, top: 5.h),
        trailing: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: SvgPicture.asset(
              ImageManager.editIcon,
              width: 20.w,
              height: 20.w,
            )),
      ),
    );
  }
}
