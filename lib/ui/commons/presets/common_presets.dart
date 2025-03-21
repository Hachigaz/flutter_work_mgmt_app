// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/color_presets.dart';

final FThemeData appThemeData = FThemes.green.dark;

final FScaffoldStyle style_scaffold_root_page = FScaffoldStyle(
  backgroundColor: color_scaffold_background,
  contentPadding: EdgeInsets.all(0),
  footerDecoration: BoxDecoration(),
);
