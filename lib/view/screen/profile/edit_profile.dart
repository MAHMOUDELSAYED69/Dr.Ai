import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/color.dart';
import '../../../logic/validation/formvalidation_cubit.dart';
import '../../widget/custom_drop_down_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
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
              _buildUserCard(context, char: "M", name: "Mahmoud El Sayed"),
              _buildUserProfileDataFields(context),
              Gap(32.h),
              CustomButton(
                title: "Update",
                onPressed: () {},
              ),
              Gap(32.h),
            ],
          ),
        ),
      ),
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
                char,
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

  Widget _buildUserProfileDataFields(BuildContext context) {
    final cubit = context.bloc<FormvalidationCubit>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Name",
            hintText: "Enter your Name",
            onSaved: (data) {
              _name = data;
            },
            validator: cubit.nameValidator,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            title: "phone Number",
            hintText: "Enter your phone Number",
            onSaved: (data) {
              _phoneNumber = data!;
            },
            validator: cubit.phoneNumberValidator,
          ),
          CustomTextFormField(
            initialValue: "dd/mm/yyyy",
            keyboardType: TextInputType.datetime,
            title: "Date of birth",
            hintText: "Enter your Date of birth",
            onSaved: (data) {
              _dob = data;
            },
            validator: cubit.validateDateOfBirth,
          ),
     
          CustomTextFormField(
            keyboardType: TextInputType.number,
            title: "Height ( CM )",
            hintText: "Enter your height",
            onSaved: (data) {
              _height = data!;
            },
            validator: cubit.heightValidator,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.number,
            title: "Weight ( KG )",
            hintText: "Enter your weight",
            onSaved: (data) {
              _weight = data!;
            },
            validator: cubit.weightValidator,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "chronic diseases",
            hintText: "Enter your chronic diseases",
            onSaved: (data) {
              _chronicDiseases = data;
            },
          ),
          CustomTextFormField(
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
