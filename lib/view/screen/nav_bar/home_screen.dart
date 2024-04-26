import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';  
import '../../../core/constant/color.dart';
import '../../../logic/chat/chat_cubit.dart';
import '../../widget/contact_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          child: Column(
            children: [
              Gap(32.h),
              _buildChatCard(context),
              Gap(32.h),
              _buidContactsCard(),
              Gap(32.h),
          
            ],
          ), 
        ),
      ),
    );
  }

  Widget _buildChatCard(BuildContext context) {
    return Card(
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chat in Doctor AI",
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 16.sp,
                      )),
                  Gap(12.h),
                  Text(
                    "You can ask your medical questions And know the required medicines",
                    style: context.textTheme.bodySmall,
                  ),
                  Gap(18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        size: Size(context.width * 0.375, 42.w),
                        title: "Start Chat",
                        onPressed: () {
                          context.bloc<ChatCubit>().startListeningToMessages();
                          Navigator.pushNamed(context, RouteManager.chat);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(ImageManager.robotIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buidContactsCard() {
    return const Row(
      children: [
        ContactCard(
          image: ImageManager.ambulanceIcon,
          title: "Ambulance",
          number: "123",
          color: ColorManager.green,
        ),
        ContactCard(
          image: ImageManager.policeIcon,
          title: "Amergency",
          number: "112",
          color: ColorManager.blue,
        ),
        ContactCard(
          image: ImageManager.firefightingIcon,
          title: "Firefighting",
          number: "180",
          color: ColorManager.orange,
        ),
      ],
    );
  }
}
