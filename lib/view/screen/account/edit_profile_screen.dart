import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dr_ai/utils/helper/scaffold_snakbar.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:dr_ai/view/widget/button_loading_indicator.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../cache/cache.dart';
import '../../../utils/constant/color.dart';
import '../../../logic/validation/formvalidation_cubit.dart';
import '../../widget/custom_scrollable_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _dob;
  String? _gender;
  String? _bloodType;
  String? _height;
  String? _weight;
  String? _chronicDiseases;
  String? _familyHistoryOfChronicDiseases;
  final Map<String, dynamic> _userData = CacheData.getMapData(key: "userData");
  bool _isloading = false;
  void _updateUserData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_name == _userData['name'] &&
          _phoneNumber == _userData['phoneNumber'] &&
          _dob == _userData['dob'] &&
          _height == _userData['height'] &&
          _weight == _userData['weight'] &&
          _chronicDiseases == _userData['chronicDiseases'] &&
          _familyHistoryOfChronicDiseases ==
              _userData['familyHistoryOfChronicDiseases']) {
        context.pop();
      } else {
        context
            .bloc<AccountCubit>()
            .updateProfile(
              name: _name ?? _userData['name'],
              email: _email ?? _userData['email'],
              phoneNumber: _phoneNumber ?? _userData['phoneNumber'],
              dob: _dob ?? _userData['dob'],
              height: _height ?? _userData['height'],
              weight: _weight ?? _userData['weight'],
              chronicDiseases: _chronicDiseases ?? _userData['chronicDiseases'],
              familyHistoryOfChronicDiseases: _familyHistoryOfChronicDiseases ??
                  _userData['familyHistoryOfChronicDiseases'],
            )
            .then((_) => context.pop());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is ProfileUpdateLoading) {
          _isloading = true;
        }
        if (state is ProfileUpdateSuccess) {
          _isloading = false;
          customSnackBar(
              context, "Profile Updated Successfully", ColorManager.green);
        }
        if (state is ProfileUpdateFailure) {
          _isloading = false;
          customSnackBar(context, state.message, ColorManager.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Gap(32.h),
                const CustomTitleBackButton(
                  title: "Edit Profile",
                ),
                Gap(20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      _buildUserCard(context,
                          char: _userData['name'][0], name: _userData['name']),
                      _buildUserProfileDataFields(
                        context,
                        _userData,
                      ),
                      Gap(28.h),
                      CustomButton(
                          widget: _isloading
                              ? const ButtonLoadingIndicator()
                              : null,
                          isDisabled: _isloading,
                          title: "Update",
                          onPressed: _updateUserData),
                      Gap(14.h),
                      CustomButton(
                        title: "Cancel",
                        backgroundColor: ColorManager.error,
                        onPressed: () => context.pop(),
                      ),
                      Gap(22.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserCard(BuildContext context,
      {required String char, required String name}) {
    final divider = Divider(
      color: ColorManager.green.withOpacity(0.4),
      thickness: 1.w,
      endIndent: 5,
      indent: 5,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: divider),
            Container(
              alignment: Alignment.center,
              width: context.width / 3.8,
              height: context.width / 3.8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.green.withOpacity(0.1),
                  border: Border.all(width: 2.w, color: ColorManager.green)),
              child: Text(
                char.toUpperCase(),
                style: context.textTheme.displayLarge
                    ?.copyWith(fontSize: 32.spMin),
              ),
            ),
            Expanded(child: divider),
          ],
        ),
        Gap(10.h),
        Text(
          name,
          style: context.textTheme.bodyLarge?.copyWith(fontSize: 18.spMin),
        ),
      ],
    );
  }

  Widget _buildUserProfileDataFields(
      BuildContext context, Map<String, dynamic> userData) {
    final cubit = context.bloc<ValidationCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            initialValue: userData['name'],
            keyboardType: TextInputType.name,
            title: "Name",
            hintText: "Enter your Name",
            onSaved: (data) {
              _name = data;
            },
            validator: cubit.nameValidator,
          ),
          CustomTextFormField(
            initialValue: userData['phoneNumber'],
            keyboardType: TextInputType.phone,
            title: "phone Number",
            hintText: "Enter your phone Number",
            onSaved: (data) {
              _phoneNumber = data!;
            },
            validator: cubit.phoneNumberValidator,
          ),
          CustomTextFormField(
            initialValue: userData['dob'],
            keyboardType: TextInputType.datetime,
            title: "Date of birth",
            hintText: "Enter your Date of birth",
            onSaved: (data) {
              _dob = data;
            },
            validator: cubit.validateDateOfBirth,
          ),
          CustomTextFormField(
            initialValue: userData['height'],
            keyboardType: TextInputType.number,
            title: "Height ( CM )",
            hintText: "Enter your height",
            onSaved: (data) {
              _height = data!;
            },
            validator: cubit.heightValidator,
          ),
          CustomTextFormField(
            initialValue: userData['weight'],
            keyboardType: TextInputType.number,
            title: "Weight ( KG )",
            hintText: "Enter your weight",
            onSaved: (data) {
              _weight = data!;
            },
            validator: cubit.weightValidator,
          ),
          CustomTextFormField(
            initialValue: userData['chronicDiseases'],
            keyboardType: TextInputType.name,
            title: "chronic diseases",
            hintText: "Enter your chronic diseases",
            onSaved: (data) {
              _chronicDiseases = data;
            },
          ),
          CustomTextFormField(
            initialValue: userData['familyHistoryOfChronicDiseases'],
            keyboardType: TextInputType.name,
            title: "Family history of chronic diseases",
            hintText: "Enter your Family history of chronic diseases",
            onSaved: (data) {
              _familyHistoryOfChronicDiseases = data;
            },
          ),
        ],
      ),
    );
  }
}
