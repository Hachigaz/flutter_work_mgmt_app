import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/theme_bloc.dart';
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
        for (final theme in ThemeBloc.appThemes.entries)
          _ThemeSelectItemWidget(
            displayColor: theme.value.$2,
            themeName: theme.key,
          ),
      ],
    );
  }
}

class _ThemeSelectItemWidget extends StatelessWidget {
  void onClickChangeTheme({required BuildContext context}) {
    context.read<ThemeBloc>().add(
      ThemeEventChangeTheme(context: context, themeName: themeName),
    );
  }

  final Color displayColor;
  final String themeName;

  const _ThemeSelectItemWidget({
    required this.displayColor,
    required this.themeName,
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
    required bool appThemeMode,
  }) {
    final themeBloc = context.read<ThemeBloc>();
    themeBloc.add(
      ThemeEventChangeMode(context: context, appThemeMode: appThemeMode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final appThemeMode = context.read<ThemeBloc>().state.appThemeMode;
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
                fontWeight: appThemeMode ? FontWeight.w700 : FontWeight.w600,
                color:
                    appThemeMode
                        ? colorScheme.foreground
                        : colorScheme.mutedForeground,
              ),
            ),
            Switch.adaptive(
              activeColor: colorScheme.background.lighter(40),
              value: !appThemeMode,
              onChanged: (changedValue) {
                onClickChangeThemeMode(
                  context: context,
                  appThemeMode: !appThemeMode,
                );
              },
            ),
            Text(
              "Tối",
              style: typography.base.copyWith(
                fontWeight: appThemeMode ? FontWeight.w600 : FontWeight.w700,
                color:
                    appThemeMode
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
