import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/ui/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_subpages/task_info_section.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_subpages/task_report_info_section/task_report_info_section.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';

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
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return AppBar(
      backgroundColor: presets.color_background_primary.withAlpha(180),
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
    final colorScheme = context.theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: _TaskDetailPageHeader(context),
      body: _TaskDetailPageContent(),
    );
  }
}
