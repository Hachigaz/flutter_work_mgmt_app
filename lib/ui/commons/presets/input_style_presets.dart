import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/ui/commons/defs/const_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/helpers/colors.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';

final _typography = appThemeData.typography;
final _colorScheme = appThemeData.colorScheme;

const _focused_width = 2.0;
const _border_radius = 15.0;

final _foreground_transparent = _colorScheme.foreground
    .darker(20)
    .withAlpha(100);

final input_dec_bordered = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(_border_radius),
    borderSide: BorderSide(color: _colorScheme.secondary),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(_border_radius),
    borderSide: BorderSide(color: _colorScheme.primary, width: _focused_width),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(_border_radius),
    borderSide: BorderSide(color: _colorScheme.error),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(_border_radius),
    borderSide: BorderSide(
      color: colorShift(color: _colorScheme.error, r: 30),
      width: _focused_width,
    ),
  ),
  hintStyle: _typography.sm.copyWith(color: _foreground_transparent),
  errorStyle: _typography.sm.copyWith(color: _colorScheme.error),
  labelStyle: _typography.sm.copyWith(color: _colorScheme.foreground),
  helperStyle: _typography.sm.copyWith(color: _foreground_transparent),
  prefixStyle: _typography.base,
  suffixStyle: _typography.base,
  counterStyle: _typography.sm,
  floatingLabelStyle: _typography.sm.copyWith(
    fontWeight: FontWeight.w600,
    color: _colorScheme.primary,
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: padding_lg,
    horizontal: padding_2xl,
  ),
  filled: true,
  fillColor: colorShift(
    color: _colorScheme.background,
    r: 8,
    g: 8,
    b: 8,
  ).withAlpha(150),
);

final button_style_default = ElevatedButton.styleFrom(
  backgroundColor: _colorScheme.secondary,
  foregroundColor: _colorScheme.foreground,
  iconColor: _colorScheme.primary,
  disabledBackgroundColor: _colorScheme.muted,
  disabledForegroundColor: _colorScheme.mutedForeground,
  disabledIconColor: _colorScheme.mutedForeground,
  textStyle: _typography.base.copyWith(fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_border_radius),
  ),
  padding: EdgeInsets.symmetric(vertical: padding_lg, horizontal: padding_2xl),
);

final button_style_primary = ElevatedButton.styleFrom(
  backgroundColor: _colorScheme.primary,
  foregroundColor: _colorScheme.background,
  iconColor: _colorScheme.background,
  disabledBackgroundColor: _colorScheme.muted,
  disabledForegroundColor: _colorScheme.mutedForeground,
  disabledIconColor: _colorScheme.mutedForeground,
  textStyle: _typography.base.copyWith(fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_border_radius),
  ),
  padding: EdgeInsets.symmetric(vertical: padding_lg, horizontal: padding_2xl),
);
