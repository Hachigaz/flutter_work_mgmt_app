import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/components/task_info_section.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/components/task_report_info_section/task_report_info_section.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/color_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

class _TaskDetailPageContent extends StatelessWidget {
  const _TaskDetailPageContent();

  void onTapReportCard(BuildContext context) {
    context.push("reports/detail/1");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: padding_md,
        horizontal: padding_md,
      ),
      children: [
        TaskInfoSection(),
        const SizedBox(height: 20),
        TaskInfoDescriptionSection(),
        const Divider(
          color: Colors.grey,
          thickness: 2,
          indent: 16,
          endIndent: 16,
          height: 30,
        ),
        TaskReportInfoSection(),
      ],
    );
  }
}

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _TaskDetailPageHeader(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;

    return AppBar(
      backgroundColor: color_background_primary,
      centerTitle: true,
      title: Text(
        "Chi tiết công việc",
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
    final colorScheme = appThemeData.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: _TaskDetailPageHeader(context),
      body: _TaskDetailPageContent(),
    );
  }
}
