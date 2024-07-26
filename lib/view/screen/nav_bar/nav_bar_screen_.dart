import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dr_ai/utils/constant/color.dart';
import 'package:dr_ai/utils/helper/extention.dart';
import 'package:dr_ai/view/screen/nav_bar/account_screen.dart';
import 'package:dr_ai/view/screen/nav_bar/nfc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../utils/constant/image.dart';
import '../../widget/custom_tooltip.dart';
import 'maps_screen.dart';
import '../nav_bar/home_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  Map<String, List<String>> _buildItems() {
    return {
      "icon": [
        ImageManager.chatIcon,
        ImageManager.nfcIcon,
        ImageManager.mapIcon,
        ImageManager.userIcon,
      ],
      "text": [
        "chat",
        "nfc",
        "map",
        "account",
      ]
    };
  }

  List<Widget> _buildScreens() {
    return <Widget>[
      const HomeScreen(),
      const NFCScreen(),
      const MapScreen(),
      const AccountScreen(),
    ];
  }

  bool _onWillPop() {
    if (_bottomNavIndex != 0) {
      setState(() {
        _bottomNavIndex = 0;
      });
      return false;
    }
    return true;
  }

  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: PopScope(
          canPop: _bottomNavIndex == 0 ? true : false,
          onPopInvoked: (_) => _onWillPop(),
          // canPop: _bottomNavIndex == 0 ? true : false,

          child: IndexedStack(
            index: _bottomNavIndex,
            children: _buildScreens(),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        splashColor: ColorManager.green.withOpacity(0.3),
        splashRadius: 18,
        gapWidth: 0,
        backgroundColor: ColorManager.white,
        elevation: 15,
        shadow:
            Shadow(blurRadius: 20, color: ColorManager.grey.withOpacity(0.2)),

        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        height: 65.h,
        leftCornerRadius: 22,
        rightCornerRadius: 22,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          return CustomToolTip(
            message: _buildItems()["text"]![index],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.contain,
                  _buildItems()["icon"]![index],
                  color: isActive ? ColorManager.green : ColorManager.grey,
                ),
                Gap(5.h),
                Text(
                  _buildItems()["text"]![index],
                  style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.spMin,
                      color: isActive ? ColorManager.green : ColorManager.grey),
                ),
              ],
            ),
          );
        },
        //other params
      ),
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
//     Icons.nfc,
//     Icons.map,
//     Icons.person
//   ];
//   final List<Widget> classSwitch = [
//     const HomeScreen(),
//     const NFCScreen(),
//     const MapScreen(),
//     const AccountScreen(),
//   ];
//   int _bottomNavIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: IndexedStack(
//           index: _bottomNavIndex,
//           children: classSwitch,
//         ),
//       ),
//       bottomNavigationBar: AnimatedBottomNavigationBar(
//        splashRadius: 20,
//         gapWidth: 0,
//         backgroundColor: ColorManager.white,
//         icons: iconList,
//         elevation: 15,
//         shadow:
//             Shadow(blurRadius: 20, color: ColorManager.grey.withOpacity(0.2)),
//         inactiveColor: ColorManager.grey,
//         activeColor: ColorManager.green,
//         activeIndex: _bottomNavIndex,
//         gapLocation: GapLocation.center,
//         height: 50.h,
//         iconSize: 25.r,
//         leftCornerRadius: 20.dm,
//         rightCornerRadius: 20.dm,
//         onTap: (index) {
//           setState(() => _bottomNavIndex = index);
//         },
//         //other params
//       ),
//     );
//   }
// }
