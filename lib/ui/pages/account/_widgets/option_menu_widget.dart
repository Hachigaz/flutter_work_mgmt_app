import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/commons/providers/blocs/theme/theme_bloc.dart';
import 'package:forui/forui.dart';

class OptionMenuWidget extends StatelessWidget {
  const OptionMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [_ThemeModeMenuButtonWidget(), _ThemeSelectListMenuWidget()],
      ),
    );
  }
}

class _ThemeSelectListMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ThemeSelectItemWidget(
          displayColor: Colors.red,
          themeName: "Red",
          themeSet: FThemes.red,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.green,
          themeName: "Green",
          themeSet: FThemes.green,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.orange,
          themeName: "Orange",
          themeSet: FThemes.orange,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.redAccent,
          themeName: "Rose",
          themeSet: FThemes.rose,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.blueGrey,
          themeName: "Slate",
          themeSet: FThemes.slate,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.purpleAccent,
          themeName: "Violet",
          themeSet: FThemes.violet,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.yellowAccent,
          themeName: "Yellow",
          themeSet: FThemes.yellow,
        ),
        _ThemeSelectItemWidget(
          displayColor: Colors.grey,
          themeName: "Zinc",
          themeSet: FThemes.zinc,
        ),
      ],
    );
  }
}

class _ThemeSelectItemWidget extends StatelessWidget {
  void onClickChangeTheme({required BuildContext context}) {
    context.read<ThemeBloc>().add(
      ThemeEventChangeTheme(context: context, themeSet: themeSet),
    );
  }

  final Color displayColor;
  final String themeName;
  final ThemeSet themeSet;

  const _ThemeSelectItemWidget({
    required this.displayColor,
    required this.themeName,
    required this.themeSet,
  });
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return GestureDetector(
      onTap: () {
        onClickChangeTheme(context: context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColoredBox(
              color: displayColor,
              child: SizedBox(width: 10, height: 10),
            ),
            Text(themeName, style: typography.base),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeMenuButtonWidget extends StatelessWidget {
  void onClickChangeThemeMode({
    required BuildContext context,
    required bool isModeLight,
  }) {
    final themeBloc = context.read<ThemeBloc>();
    themeBloc.add(
      ThemeEventChangeMode(context: context, isModeLight: isModeLight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final isModeLight = context.read<ThemeBloc>().state.isModeLight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Chế độ sáng",
          style: typography.base.copyWith(fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sáng",
              style: typography.base.copyWith(
                fontWeight: isModeLight ? FontWeight.w700 : FontWeight.w600,
                color:
                    isModeLight
                        ? colorScheme.foreground
                        : colorScheme.mutedForeground,
              ),
            ),
            Switch.adaptive(
              activeColor: colorScheme.background.lighter(40),
              value: !isModeLight,
              onChanged: (changedValue) {
                onClickChangeThemeMode(
                  context: context,
                  isModeLight: !isModeLight,
                );
              },
            ),
            Text(
              "Tối",
              style: typography.base.copyWith(
                fontWeight: isModeLight ? FontWeight.w600 : FontWeight.w700,
                color:
                    isModeLight
                        ? colorScheme.mutedForeground
                        : colorScheme.foreground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
