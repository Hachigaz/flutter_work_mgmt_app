// ignore_for_file: non_constant_identifier_names

import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/color/color_helpers.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

final _colorScheme = appThemeData.colorScheme;

final color_background_1 = colorShift(
  color: _colorScheme.background,
  r: 4,
  g: 4,
  b: 4,
);

final color_background_2 = colorShift(
  color: _colorScheme.background,
  r: 8,
  g: 8,
  b: 8,
);

final color_background_3 = colorShift(
  color: _colorScheme.background,
  r: 12,
  g: 12,
  b: 12,
);

final color_background_primary = _colorScheme.primary.darker(20);

final color_scaffold_background = color_background_1;
