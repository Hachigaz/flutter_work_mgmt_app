import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/helpers/colors.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';

const _mainNavBarItems = [
  (routeName: "home", icon: Icons.warehouse, label: "Trang chủ"),
  (routeName: "projects", icon: CupertinoIcons.hammer_fill, label: "Dự án"),
  (routeName: "payment", icon: Icons.wallet, label: "Thanh toán"),
  (routeName: "notification", icon: CupertinoIcons.bell, label: "Thông báo"),
  (routeName: "mailbox", icon: Icons.mail, label: "Hộp thư"),
  (routeName: "account", icon: Icons.person, label: "Tài khoản"),
];

class _MainAppNavBar extends StatelessWidget {
  final int _currentIndex;

  const _MainAppNavBar({required int currentIndex})
    : _currentIndex = currentIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

    final selectedItemColor = colorScheme.secondaryForeground;
    final unselectedItemColor = colorShift(
      color: colorScheme.foreground,
      r: 50,
      g: 50,
      b: 50,
    ).withAlpha(150);

    return BottomNavigationBar(
      backgroundColor: colorScheme.background,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedLabelStyle: typography.sm.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: typography.sm.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 10.sp,
      unselectedFontSize: 10.sp,
      iconSize: 20.sp,
      onTap: (value) {
        if (context.mounted) {
          context.goNamed(_mainNavBarItems[value].routeName);
        }
      },
      items: [
        for (final item in _mainNavBarItems)
          BottomNavigationBarItem(
            label: item.label,
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(item.icon, color: unselectedItemColor),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  boxShadow: [],
                  borderRadius: BorderRadius.all(Radius.circular(40.r)),
                ),
                child: Icon(item.icon, color: colorScheme.background),
              ),
            ),
          ),
      ],
    );
  }
}

class MainAppScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainAppScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _MainAppNavBar(
        currentIndex: navigationShell.currentIndex,
      ),
    );
  }
}
