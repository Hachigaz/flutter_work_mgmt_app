// ignore_for_file: non_constant_identifier_names

import 'package:flutter/painting.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

final _tabStyle = appThemeData.tabsStyle;

final style_tab_root_page = _tabStyle.copyWith(
  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  selectedLabelTextStyle: _tabStyle.selectedLabelTextStyle,
  unselectedLabelTextStyle: _tabStyle.unselectedLabelTextStyle,
  spacing: 10,
);
