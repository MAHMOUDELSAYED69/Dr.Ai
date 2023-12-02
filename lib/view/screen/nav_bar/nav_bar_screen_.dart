import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dr_ai/view/screen/nav_bar/home_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/archive_screen.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: const Color(0xff00A859),
        child: Image.asset(
          "assets/images/logo_white.png",
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
        inactiveColor: Colors.grey,
        activeColor: const Color(0xff00A859),
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
