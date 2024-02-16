import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dr_ai/core/constant/color.dart';

import 'package:flutter/material.dart';

import '../nav_bar/archive_screen.dart';
import '../nav_bar/home_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<IconData> iconList = const [
    Icons.home,
    Icons.archive_rounded,
  ];
  final List<Widget> classSwitch = [
    const HomeScreen(),
    const ArchiveScreen(),
  ];
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: IndexedStack(
          index: _bottomNavIndex,
          children: classSwitch,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: MyColors.green,
        child: Image.asset(
          _bottomNavIndex == 0
              ? "assets/images/logo_white.png"
              : "assets/images/chat.png",
          scale: 2.5,
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/chat");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        elevation: 100,
        inactiveColor: MyColors.grey2,
        activeColor: MyColors.green,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        height: 60,
        iconSize: 35,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        onTap: (index) {
          setState(() => _bottomNavIndex = index);
        },
        //other params
      ),
    );
  }
}
