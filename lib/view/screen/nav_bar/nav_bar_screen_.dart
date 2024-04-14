import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/view/screen/nav_bar/account_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/nfc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'maps_screen.dart';
import '../nav_bar/home_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      NFCScreen(),
      MapScreen(),
      AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 20.r,
        icon: const Icon(Icons.chat),
        title: ("Chat"),
        activeColorPrimary: ColorManager.green,
        inactiveColorPrimary: ColorManager.grey,
        textStyle: context.textTheme.bodySmall?.copyWith(fontSize: 12.spMin),
      ),
      PersistentBottomNavBarItem(
        iconSize: 20.r,
        icon: const Icon(Icons.nfc),
        title: ("NFC"),
        activeColorPrimary: ColorManager.green,
        inactiveColorPrimary: ColorManager.grey,
        textStyle: context.textTheme.bodySmall?.copyWith(fontSize: 12.spMin),
      ),
      PersistentBottomNavBarItem(
        iconSize: 20.r,
        icon: const Icon(Icons.map_outlined),
        title: ("Map"),
        activeColorPrimary: ColorManager.green,
        inactiveColorPrimary: ColorManager.grey,
        textStyle: context.textTheme.bodySmall?.copyWith(fontSize: 12.spMin),
      ),
      PersistentBottomNavBarItem(
        iconSize: 20.r,
        icon: const Icon(Icons.account_circle_rounded),
        title: ("Account"),
        activeColorPrimary: ColorManager.green,
        inactiveColorPrimary: ColorManager.grey,
        textStyle: context.textTheme.bodySmall?.copyWith(fontSize: 12.spMin),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      hideNavigationBar: false,
      hideNavigationBarWhenKeyboardShows: true,
      navBarHeight: 50.h,
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      backgroundColor: Colors.grey,

      resizeToAvoidBottomInset: true,

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.dm), topRight: Radius.circular(15.dm)),
        colorBehindNavBar: Colors.white,
      ),
      //popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}



// class NavbarScreen extends StatefulWidget {
//   const NavbarScreen({super.key});

//   @override
//   State<NavbarScreen> createState() => _NavbarScreenState();
// }

// class _NavbarScreenState extends State<NavbarScreen> {
//   final List<IconData> iconList = const [
//     Icons.home,
//     Icons.person_pin_circle_rounded,
//   ];
//   final List<Widget> classSwitch = [
//     const HomeScreen(),
//     const MapScreen(),
//   ];
//   int bottomNavIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: IndexedStack(
//           index: bottomNavIndex,
//           children: classSwitch,
//         ),
//       ),
//       bottomNavigationBar: AnimatedBottomNavigationBar(
        
//         backgroundColor: ColorManager.white,
//         icons: iconList,
//         elevation: 100,
//         inactiveColor: ColorManager.grey,
//         activeColor: ColorManager.green,
//         activeIndex: bottomNavIndex,
//         gapLocation: GapLocation.center,
//         height: 60,
//         iconSize: 35,
//         leftCornerRadius: 24,
//         rightCornerRadius: 24,
//         onTap: (index) {
//           setState(() => bottomNavIndex = index);
//         },
//         //other params
//       ),
//     );
//   }
// }
