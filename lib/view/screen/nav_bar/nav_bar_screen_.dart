import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';

import 'package:flutter/material.dart';

import 'maps_screen.dart';
import '../nav_bar/home_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<IconData> iconList = const [
    Icons.home,
    Icons.person_pin_circle_rounded,
  ];
  final List<Widget> classSwitch = [
    const HomeScreen(),
    const ArchiveScreen(),
  ];
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: IndexedStack(
          index: bottomNavIndex,
          children: classSwitch,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: MyColors.green,
        child: Image.asset(
          MyImages.whiteLogo,
          scale: 2.5,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.chat);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        elevation: 100,
        inactiveColor: MyColors.grey2,
        activeColor: MyColors.green,
        activeIndex: bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        height: 60,
        iconSize: 35,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        onTap: (index) {
          setState(() => bottomNavIndex = index);
        },
        //other params
      ),
    );
  }
}
