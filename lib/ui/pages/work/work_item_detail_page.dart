library;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/color_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/bloc/work_item_detail_bloc.dart';

part 'views/work_item_info_section.dart';
part 'views/work_detail_task_overview_section.dart';

class _WorkItemDetailPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        _WorkItemInfoSection(),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(children: [_WorkDetailTaskOverviewSection()]),
        ),
      ],
    );
  }
}

class WorkItemDetailPage extends StatelessWidget {
  const WorkItemDetailPage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _WorkItemDetailPageHeader(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return AppBar(
      backgroundColor: colorScheme.primary.withAlpha(0),
      centerTitle: true,
      title: Text(
        "Chi tiết hạng mục",
        style: typography.lg.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => onPressBackButton(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.theme.colorScheme;
    return Scaffold(
      backgroundColor: color_background_primary,
      appBar: _WorkItemDetailPageHeader(context),
      body: _WorkItemDetailPageContent(),
    );
  }
}
