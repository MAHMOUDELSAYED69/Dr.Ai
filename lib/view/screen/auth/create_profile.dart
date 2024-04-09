import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
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
            validator: (value) => cubit.nameValidator(value),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            title: "phone Number",
            hintText: "Enter your phone Number",
            onSaved: (data) {
              _phoneNumber = int.parse(data!);
            },
            validator: (value) => cubit.phoneNumberValidator(value),
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
            dropDownVisible: true,
            keyboardType: TextInputType.name,
            title: "Choose you Gender",
            hintText: "Select your Gender",
            onSaved: (data) {
              _gender = data;
            },
            onDropDownSelected: () {
              log("DropDown Selected");
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
            validator: (value) => cubit.heightValidator(value),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.name,
            title: "Weight ( KG )",
            hintText: "Enter your weight",
            onSaved: (data) {
              _weight = double.parse(data!);
            },
            validator: (value) => cubit.weightValidator(value),
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

  String? dropdownValue;

  Widget _buildDropDownbutton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: context.textTheme.bodySmall,
      underline: Container(
        height: 2,
        color: ColorManager.black,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
