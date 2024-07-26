import 'package:dr_ai/cache/cache.dart';
import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dr_ai/utils/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../utils/constant/color.dart';
import '../../../utils/constant/image.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  RatingScreenState createState() => RatingScreenState();
}

class RatingScreenState extends State<RatingScreen> {
  int _selectedRating = CacheData.getdata(key: "rating") ?? 0;
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: REdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 0,
      backgroundColor: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 28.h),
        child: BlocProvider(
          create: (context) => AccountCubit(),
          child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {
              if (state is AccountRatingResult) {
                _selectedRating = state.rating ?? 0;
              }
              if (state is AccountRatingLoading) {
                _isloading = true;
              }
              if (state is AccountRatingSuccess) {
                context.pop();
                _isloading = false;
                customSnackBar(
                    context, "Thank you for your feedback", ColorManager.green);
              }
              if (state is AccountRatingFailure) {
                _isloading = false;
                context.pop();
                customSnackBar(context, state.message, ColorManager.error);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageManager.opinionIcon,
                    width: 125.w,
                    height: 125.w,
                  ),
                  Gap(12.h),
                  Text(
                    'Your opinion matters to us',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontSize: 18.spMin),
                  ),
                  Gap(6.h),
                  Text(
                    'Please rate your experience with the app',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall,
                  ),
                  Gap(4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starNumber = index + 1;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        icon: _selectedRating >= starNumber
                            ? Icon(
                                Icons.star_rounded,
                                color: ColorManager.amber,
                                size: 40.r,
                              )
                            : Icon(
                                color: ColorManager.dark,
                                Icons.star_border_rounded,
                                size: 40.r,
                              ),
                        onPressed: () {
                          setState(() {
                            _selectedRating = starNumber;
                          });
                        },
                      );
                    }),
                  ),
                  Gap(24.h),
                  CustomButton(
                    isDisabled: _isloading,
                    widget: _isloading ? const ButtonLoadingIndicator() : null,
                    title: 'Submit',
                    onPressed: () {
                      if (_selectedRating == CacheData.getdata(key: "rating")) {
                        context.pop();
                      } else {
                        context
                            .bloc<AccountCubit>()
                            .storeUserRating(_selectedRating);
                      }
                    },
                  ),
                  Gap(13.h),
                  CustomButton(
                    backgroundColor: ColorManager.error,
                    title: 'Cancel',
                    onPressed: () => context.pop(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
