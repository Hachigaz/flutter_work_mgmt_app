import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:forui/forui.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [presets.style_box_shadow_default_small],
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
