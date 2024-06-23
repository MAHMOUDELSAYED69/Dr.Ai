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
import '../../widget/build_profile_card.dart';
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
                  BuildProfileCard(
                    title: "Edit Profile",
                    image: ImageManager.userIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.editProfile),
                  ),
                  divider,
                  BuildProfileCard(
                    title: "Dark Mode",
                    image: ImageManager.darkModeIcon,
                    onPressed: () {},
                  ),
                  divider,
                  BuildProfileCard(
                      title: "Languages",
                      image: ImageManager.languageIcon,
                      onPressed: () {}),
                  divider,
                  BuildProfileCard(
                    title: "Change Password",
                    image: ImageManager.changePasswordIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.oldPassword),
                  ),
                  divider,
                  BuildProfileCard(
                    title: "About Us",
                    image: ImageManager.aboutUsIcon,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.aboutUs),
                  ),
                  divider,
                  BuildProfileCard(
                    title: "Rate Us",
                    image: ImageManager.rateUsIcon,
                    onPressed: () {
                      CacheData.getdata(key: "rating") ?? cubit.getUserRating();
                      customDialogWithAnimation(context,
                          screen: const RatingScreen());
                    },
                  ),
                  divider,
                  BuildProfileCard(
                    title: "Delete Account",
                    image: ImageManager.deteteAccountIcon,
                    color: ColorManager.error,
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.reAuthScreen),
                  ),
                  divider,
                  BuildProfileCard(
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

  Widget _buildUserCard(BuildContext context,
      {required String char, required String email, required String name}) {
    return Card(
      margin: EdgeInsets.zero,
      color: ColorManager.trasnsparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: ColorManager.grey, width: 1.w),
      ),
      child: ListTile(
        leading: Container(
            alignment: Alignment.center,
            height: 50.w,
            width: 50.w,
            decoration: BoxDecoration(
              color: ColorManager.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
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
