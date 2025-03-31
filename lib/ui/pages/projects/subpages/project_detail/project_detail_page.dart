library;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/description_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_text_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';

import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';

import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';

part "views/project_detail_info_section.dart";
part "views/project_detail_work_overview_section.dart";
part "views/project_detail_menu_section.dart";
part "views/project_detail_contract_overview_section.dart";

class _ProjectDetailPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: presets.color_background_primary,
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
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return AppBar(
      backgroundColor: presets.color_background_primary,
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
