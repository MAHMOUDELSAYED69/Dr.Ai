// import 'package:dr_ai/core/constant/color.dart';
// import 'package:dr_ai/core/helper/extention.dart';
// import 'package:dr_ai/logic/validation/formvalidation_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

// class CustomDateTimeFormField extends StatelessWidget {
//   const CustomDateTimeFormField({
//     super.key,
//     this.onSaved,
//     this.ddController,
//     this.mmController,
//     this.yyyyController,
//   });

//   final FormFieldSetter<String>? onSaved;
//   final TextEditingController? ddController;
//   final TextEditingController? mmController;
//   final TextEditingController? yyyyController;

//   @override
//   Widget build(BuildContext context) {
//     final validator = context.bloc<FormvalidationCubit>();
//     return Column(children: [
//       Container(
//         alignment: AlignmentDirectional.centerStart,
//         padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
//         child: Text(
//           "Date of birth",
//           style: context.textTheme.bodyMedium,
//         ),
//       ),
//       Row(
//         children: [
//           //! 1
//           Expanded(
//             child: TextFormField(
//               maxLength: 2,
//               style: context.textTheme.bodySmall
//                   ?.copyWith(color: ColorManager.black),
//               cursorColor: ColorManager.green,
//               keyboardType: TextInputType.datetime,
//               controller: ddController,
//               validator: validator.validateDay,
//               onSaved: onSaved,
//               decoration: InputDecoration(
//                 counter: const SizedBox(),
//                 isCollapsed: true,
//                 isDense: true,
//                 errorMaxLines: 2,
//                 errorStyle: context.textTheme.bodySmall
//                     ?.copyWith(color: ColorManager.error, fontSize: 12.spMin),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
//                 filled: true //true
//                 ,
//                 fillColor: ColorManager.white,
//                 hintText: "Day",
//                 hintStyle: context.textTheme.bodySmall,
//                 enabledBorder: context.inputDecoration.enabledBorder,
//                 focusedBorder: context.inputDecoration.focusedBorder,
//                 errorBorder: context.inputDecoration.errorBorder,
//                 focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
//               ),
//             ),
//           ),
//           Gap(5.w),
//           //! 2
//           Expanded(
//             child: TextFormField(
//               maxLength: 2,
//               style: context.textTheme.bodySmall
//                   ?.copyWith(color: ColorManager.black),
//               cursorColor: ColorManager.green,
//               keyboardType: TextInputType.datetime,
//               controller: mmController,
//               validator: validator.validateMonth,
//               onSaved: onSaved,
//               decoration: InputDecoration(
//                 counter: const SizedBox(),
//                 isCollapsed: true,
//                 isDense: true,
//                 errorMaxLines: 2,
//                 errorStyle: context.textTheme.bodySmall
//                     ?.copyWith(color: ColorManager.error, fontSize: 12.spMin),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
//                 filled: true //true
//                 ,
//                 fillColor: ColorManager.white,
//                 hintText: "Month",
//                 hintStyle: context.textTheme.bodySmall,
//                 enabledBorder: context.inputDecoration.enabledBorder,
//                 focusedBorder: context.inputDecoration.focusedBorder,
//                 errorBorder: context.inputDecoration.errorBorder,
//                 focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
//               ),
//             ),
//           ),
//           //! 3
//           Gap(5.w),
//           Expanded(
//             child: TextFormField(
//               style: context.textTheme.bodySmall
//                   ?.copyWith(color: ColorManager.black),
//               cursorColor: ColorManager.green,
//               keyboardType: TextInputType.datetime,
//               controller: yyyyController,
//               validator: validator.validateYear,
//               onSaved: onSaved,
//               maxLength: 4,
//               decoration: InputDecoration(
//                 counter: const SizedBox(),
//                 isCollapsed: true,
//                 isDense: true,
//                 errorMaxLines: 2,
//                 errorStyle: context.textTheme.bodySmall
//                     ?.copyWith(color: ColorManager.error, fontSize: 12.spMin),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 13.h, horizontal: 10.w),
//                 filled: true //true
//                 ,
//                 fillColor: ColorManager.white,
//                 hintText: "Year",
//                 hintStyle: context.textTheme.bodySmall,
//                 enabledBorder: context.inputDecoration.enabledBorder,
//                 focusedBorder: context.inputDecoration.focusedBorder,
//                 errorBorder: context.inputDecoration.errorBorder,
//                 focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
//               ),
//             ),
//           ),
//         ],
//       )
//     ]);
//   }
// }
