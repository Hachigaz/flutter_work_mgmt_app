// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:forui/forui.dart';

class ThemePresets {
  late final BoxShadow style_box_shadow_default;
  late final BoxShadow style_box_shadow_default_small;

  static const _focused_width = 2.0;
  static const _border_radius = 15.0;

  late final InputDecoration input_dec_bordered;
  late final ButtonStyle button_style_default;
  late final ButtonStyle button_style_primary;

  late final Color color_background_1;
  late final Color color_background_2;
  late final Color color_background_3;

  late final Color color_background_primary;
  late final Color color_scaffold_background;

  ThemePresets(FThemeData theme) {
    final colorScheme = theme.colorScheme;
    final typography = theme.typography;

    style_box_shadow_default = BoxShadow(
      color: Colors.black.withAlpha(40),
      blurRadius: 10,
      spreadRadius: 2,
      offset: Offset(4, 4),
    );
    style_box_shadow_default_small = BoxShadow(
      color: Colors.black.withAlpha(40),
      blurRadius: 2,
      spreadRadius: 0.1,
      offset: Offset(2, 2),
    );

    final foreground_transparent = colorScheme.foreground
        .darker(20)
        .withAlpha(100);

    input_dec_bordered = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_border_radius),
        borderSide: BorderSide(color: colorScheme.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_border_radius),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: _focused_width,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_border_radius),
        borderSide: BorderSide(color: colorScheme.error.lighter(15)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_border_radius),
        borderSide: BorderSide(
          color: colorScheme.error.lighter(25),
          width: _focused_width,
        ),
      ),
      hintStyle: typography.sm.copyWith(color: foreground_transparent),
      errorStyle: typography.sm.copyWith(
        color: colorScheme.error.lighter(25),
        fontWeight: FontWeight.w600,
      ),
      labelStyle: typography.sm.copyWith(color: colorScheme.foreground),
      helperStyle: typography.sm.copyWith(color: foreground_transparent),
      prefixStyle: typography.base,
      suffixStyle: typography.base,
      counterStyle: typography.sm,
      floatingLabelStyle: typography.sm.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.foreground,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: padding_lg,
        horizontal: padding_2xl,
      ),
      filled: true,
      fillColor: colorShift(
        color: colorScheme.background,
        r: 8,
        g: 8,
        b: 8,
      ).withAlpha(150),
    );

    button_style_default = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.foreground,
      iconColor: colorScheme.primary,
      disabledBackgroundColor: colorScheme.muted,
      disabledForegroundColor: colorScheme.mutedForeground,
      disabledIconColor: colorScheme.mutedForeground,
      textStyle: typography.base.copyWith(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_border_radius),
      ),
      padding: EdgeInsets.symmetric(
        vertical: padding_lg,
        horizontal: padding_2xl,
      ),
    );

    button_style_primary = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.background,
      iconColor: colorScheme.background,
      disabledBackgroundColor: colorScheme.muted,
      disabledForegroundColor: colorScheme.mutedForeground,
      disabledIconColor: colorScheme.mutedForeground,
      textStyle: typography.base.copyWith(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_border_radius),
      ),
      padding: EdgeInsets.symmetric(
        vertical: padding_lg,
        horizontal: padding_2xl,
      ),
    );

    color_background_1 = colorShift(
      color: colorScheme.background,
      r: 4,
      g: 4,
      b: 4,
    );

    color_background_2 = colorShift(
      color: colorScheme.background,
      r: 8,
      g: 8,
      b: 8,
    );

    color_background_3 = colorShift(
      color: colorScheme.background,
      r: 12,
      g: 12,
      b: 12,
    );

    color_background_primary = colorScheme.primary.darker(20);

    color_scaffold_background = color_background_1;
  }
}
