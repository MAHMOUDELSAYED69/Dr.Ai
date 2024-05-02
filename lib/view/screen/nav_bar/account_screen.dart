// ignore_for_file: deprecated_member_use

import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/custom_dialog.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/data/model/user_data_model.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../account/edit_user_card_buttom_sheet.dart';
import '../account/rating_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<AccountCubit>().getprofileData();
  }

  UserDataModel? _userData;
  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<AccountCubit>();
    final divider = Divider(color: ColorManager.grey, thickness: 1.w);
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountSuccess) {
          _userData = state.userDataModel;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: Column(
                children: [
                  Gap(15.h),
                  _buildUserCard(
                    context,
                    char: _userData?.name[0].toUpperCase() ?? "",
                    email: _userData?.email ?? "",
                    name: _userData?.name ?? "",
                  ),
                  Gap(20.h),
                  _buildProfileCard(
                    context,
                    title: "Edit Profile",
                    image: ImageManager.userIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.editProfile),
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "Dark Mode",
                    image: ImageManager.darkModeIcon,
                    onPressed: () {},
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "Languages",
                    image: ImageManager.languageIcon,
                    onPressed: () {},
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "Change Password",
                    image: ImageManager.changePasswordIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.oldPassword),
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "About Us",
                    image: ImageManager.aboutUsIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.aboutUs),
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "Rate Us",
                    image: ImageManager.rateUsIcon,
                    onPressed: () {
                      CacheData.getdata(key: "rating") ?? cubit.getUserRating();
                      showDialog(
                        context: context,
                        builder: (context) => const RatingScreen(),
                      );
                    },
                  ),
                  divider,
                  _buildProfileCard(
                    context,
                    title: "Delete Account",
                    image: ImageManager.deteteAccountIcon,
                    color: ColorManager.error,
                    onPressed: () {
                      customDialog(context,
                          secondButtoncolor: ColorManager.error,
                          title: "Delete Account?!",
                          subtitle:
                              "Are you sure you want to delete your account?",
                          buttonTitle: "Delete",
                          image: ImageManager.errorIcon,
                          onPressed: () async => await cubit.deleteAccount());
                    },
                  ),
                  divider,
                  _buildProfileCard(context,
                      title: "logout",
                      iconData: Icons.logout,
                      color: ColorManager.error,
                      onPressed: () => customDialog(
                            context,
                            title: "Logout?!",
                            subtitle: "Are you sure you want to logout?",
                            buttonTitle: "Logout",
                            secondButtoncolor: ColorManager.error,
                            onPressed: () async => await cubit.logout(),
                            image: ImageManager.errorIcon,
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(BuildContext context,
      {required String title,
      String? image,
      Color? color,
      IconData? iconData,
      VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      splashFactory: InkSplash.splashFactory,
      child: ListTile(
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
      ),
    );
  }

  Widget _buildUserCard(BuildContext context,
      {required String char, required String email, required String name}) {
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
              color: ColorManager.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.dm),
              border: Border.all(
                width: 1.5.w,
                color: ColorManager.green,
              ),
            ),
            child: Text(
              char,
              style: context.textTheme.displayLarge,
            )),
        title: Text(
          name,
          style: context.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          email,
          style: context.textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding:
            EdgeInsets.only(left: 12.w, right: 4.w, bottom: 5.h, top: 5.h),
        trailing: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => showEditProfileBottomSheet(context),
            icon: SvgPicture.asset(
              ImageManager.editIcon,
              width: 20.w,
              height: 20.w,
            )),
      ),
    );
  }
}
