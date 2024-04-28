import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/account/account_cubit.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/cache/cache.dart';
import '../../../core/constant/color.dart';
import '../../../logic/validation/formvalidation_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  Map<String, dynamic> userData = CacheData.getMapData(key: "userData");

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<AccountCubit>();
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: const Text("Edit Profile"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  _buildUserCard(context,
                      char: userData['name'][0], name: userData['name']),
                  _buildUserProfileDataFields(
                    context,
                    userData,
                  ),
                  Gap(32.h),
                  CustomButton(
                    title: "Update",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        cubit.updateProfile(
                          name: _name ?? userData['name'],
                          email: _email ?? userData['email'],
                          phoneNumber: _phoneNumber ?? userData['phoneNumber'],
                          dob: _dob ?? userData['dob'],
                          height: _height ?? userData['height'],
                          weight: _weight ?? userData['weight'],
                          chronicDiseases:
                              _chronicDiseases ?? userData['chronicDiseases'],
                          familyHistoryOfChronicDiseases:
                              _familyHistoryOfChronicDiseases ??
                                  userData['familyHistoryOfChronicDiseases'],
                        );
                      }
                    },
                  ),
                  Gap(32.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserCard(BuildContext context,
      {required String char, required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.green.withOpacity(0.3),
                  border: Border.all(width: 2.w, color: ColorManager.green)),
              child: Text(
                char.toUpperCase(),
                style: context.textTheme.displayLarge
                    ?.copyWith(fontSize: 32.spMin),
              ),
            ),
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
    final cubit = context.bloc<FormvalidationCubit>();
    return Form(
      key: formKey,
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
