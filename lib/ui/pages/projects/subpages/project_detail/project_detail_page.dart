library;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';

import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/color_presets.dart';

import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_repo.dart';

part "views/project_detail_info_section.dart";
part "views/project_detail_work_overview_section.dart";
part "views/project_detail_menu_section.dart";
part "views/project_detail_contract_overview_section.dart";

class _ProjectDetailPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: color_background_primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: padding_lg,
              horizontal: padding_lg,
            ),
            child: _ProjectDetailTopInfoSection(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_sm,
            horizontal: padding_lg,
          ),
          child: _ProjectDetailBottomInfoSection(),
        ),
        const Divider(
          color: Colors.grey, // Line color
          thickness: 1, // Line thickness
          indent: 16, // Left spacing
          endIndent: 16, // Right spacing
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_sm,
            horizontal: padding_lg,
          ),
          child: _ProjectDetailWorkOverviewSection(),
        ),
        const Divider(
          color: Colors.grey, // Line color
          thickness: 1, // Line thickness
          indent: 16, // Left spacing
          endIndent: 16, // Right spacing
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_sm,
            horizontal: padding_lg,
          ),
          child: _ProjectDetailCurrentActiveWorkSection(),
        ),
        const Divider(
          color: Colors.grey, // Line color
          thickness: 1, // Line thickness
          indent: 16, // Left spacing
          endIndent: 16, // Right spacing
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_sm,
            horizontal: padding_lg,
          ),
          child: _ProjectDetailContractOverviewSection(),
        ),
        const Divider(
          color: Colors.grey, // Line color
          thickness: 1, // Line thickness
          indent: 16, // Left spacing
          endIndent: 16, // Right spacing
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_sm,
            horizontal: padding_lg,
          ),
          child: _ProjectDetailMenuSection(),
        ),
      ],
    );
  }
}

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _ProjectDetailPageHeader(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;

    return AppBar(
      backgroundColor: color_background_primary,
      centerTitle: true,
      title: Text(
        "Chi tiết dự án",
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
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _ProjectDetailPageHeader(context),
      body: _ProjectDetailPageContent(),
    );
  }
}
