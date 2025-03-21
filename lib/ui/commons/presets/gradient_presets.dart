import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/helpers/colors.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';

final _colorScheme = appThemeData.colorScheme;

// ignore: non_constant_identifier_names
final gradient_list_item = LinearGradient(
  colors: [
    colorShift(color: _colorScheme.background, r: 4, b: 4, g: 4).withAlpha(255),
    colorShift(
      color: _colorScheme.background,
      r: 10,
      b: 10,
      g: 50,
    ).withAlpha(255),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
