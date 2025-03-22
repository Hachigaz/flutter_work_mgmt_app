import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/box_shadow_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [style_box_shadow_default_small],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding_md),
        child: TextField(
          style: typography.base,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Tìm kiếm nội dung",
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.display_settings_sharp),
          ),
        ),
      ),
    );
  }
}
