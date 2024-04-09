import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/routes.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/custom_text_span.dart';
import '../../widget/my_stepper_form.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  String? _name;
  int? _phoneNumber;
  String? _dob;
  String? _gender;
  String? _bloodType;
  double? _height;
  double? _weight;
  String? _chronicDiseases;
  String? _familyHistoryOfChronicDiseases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            children: [
              Gap(context.height / 8),
              CustomTextSpan(
                  textOne: "Create ", textTwo: "Profile", fontSize: 24.sp),
              Gap(8.h),
              Text(
                "Please enter your data and you can be changed it again from within the settings",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodySmall?.copyWith(fontSize: 16.spMin),
              ),
              Gap(26.h),
              const MyStepperForm(stepReachedNumber: 2),
              _buildCreateProfileFields(),
              Gap(18.h),
              CustomButton(
                title: "Submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    log("Sccess");
                    Navigator.pushNamed(context, RouteManager.information);
                  }
                },
              ),
              Gap(18.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateProfileFields() {
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
          ),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            title: "phone Number",
            hintText: "Enter your phone Number",
            onSaved: (data) {
              _phoneNumber = int.parse(data!);
            },
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Date of birth",
            hintText: "Enter your Date of birth",
            onSaved: (data) {
              _dob = data;
            },
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Choose you Gender",
            hintText: "Select your Gender",
            onSaved: (data) {
              _gender = data;
            },
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "blood type",
            hintText: "Select your blood type",
            onSaved: (data) {
              _bloodType = data;
            },
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Height ( CM )",
            hintText: "Enter your height",
            onSaved: (data) {
              _height = double.parse(data!);
            },
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Weight ( KG )",
            hintText: "Enter your weight",
            onSaved: (data) {
              _weight = double.parse(data!);
            },
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
