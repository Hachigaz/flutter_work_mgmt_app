import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

class _HomePageToolbarIcon extends StatelessWidget {
  final IconData _icon;
  final String _label;
  final bool _hasNotification;

  const _HomePageToolbarIcon({
    required IconData icon,
    required String label,
    bool hasNotification = false,
  }) : _icon = icon,
       _label = label,
       _hasNotification = hasNotification;

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

    return Column(
      children: [
        Transform.translate(
          offset: Offset(18, 5),
          child: SizedBox(
            width: 10,
            height: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color:
                    (_hasNotification)
                        ? Colors.red
                        : const Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding_md),
            child: Icon(_icon, color: colorScheme.foreground),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: padding_md),
          child: Text(
            _label,
            style: typography.sm.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class HomePageToolbar extends StatelessWidget {
  const HomePageToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PageListSection(
      labelText: "Công cụ",
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: [
          _HomePageToolbarIcon(
            icon: CupertinoIcons.calendar,
            label: "Sắp lịch",
            hasNotification: true,
          ),
          _HomePageToolbarIcon(
            icon: Icons.receipt_long,
            label: "Đã thu gom",
            hasNotification: true,
          ),
          _HomePageToolbarIcon(
            icon: CupertinoIcons.profile_circled,
            label: "Năng lực",
          ),
          _HomePageToolbarIcon(
            icon: CupertinoIcons.car_detailed,
            label: "Vi phạm",
            hasNotification: true,
          ),
          _HomePageToolbarIcon(
            icon: CupertinoIcons.profile_circled,
            label: "Tài xế",
          ),
          _HomePageToolbarIcon(icon: Icons.fire_truck, label: "Quản lý xe"),
          _HomePageToolbarIcon(
            icon: Icons.speed,
            label: "Định mức",
            hasNotification: true,
          ),
          _HomePageToolbarIcon(icon: Icons.receipt_long, label: "Hợp đồng"),
        ],
      ),
    );
  }
}
