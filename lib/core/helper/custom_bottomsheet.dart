import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:dr_ai/data/model/user_data_model.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../logic/validation/formvalidation_cubit.dart';
import '../constant/color.dart';

void showEditProfileBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    showDragHandle: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.dm),
        topLeft: Radius.circular(20.dm),
      ),
    ),
    backgroundColor: ColorManager.white,
    elevation: 0,
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const BuildbuttomSheet(),
      );
    },
  );
}

class BuildbuttomSheet extends StatefulWidget {
  const BuildbuttomSheet({super.key});

  @override
  State<BuildbuttomSheet> createState() => _BuildbuttomSheetState();
}

class _BuildbuttomSheetState extends State<BuildbuttomSheet> {
  TextEditingController nameController =
      TextEditingController(text: CacheData.getdata(key: "name"));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final validator = context.bloc<FormvalidationCubit>();
    final accountCubit = context.read<AccountCubit>();

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is ProfileUpdateLoading) {
          _isLoading = true;
        }
        if (state is ProfileUpdateSuccess) {
          customSnackBar(
              context, "Profile Updated Successfully", ColorManager.green);
          context.pop();
        }
        if (state is ProfileUpdateFailure) {
          customSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: CustomTextFormField(
                  controller: nameController,
                  hintText: "Name",
                  title: " Enter Your New Name",
                  validator: validator.nameValidator,
                ),
              ),
              Gap(30.h),
              Row(
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
                      widget: _isLoading == true
                          ? const ButtonLoadingIndicator()
                          : null,
                      backgroundColor: ColorManager.error,
                      size: Size.fromHeight(42.w),
                      title: "Update",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (CacheData.getdata(key: "name") ==
                              nameController.text) {
                            context.pop();
                          } else {
                            accountCubit.updateUserName(
                              newName: nameController.text,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              Gap(10.h),
            ],
          ),
        );
      },
    );
  }
}
