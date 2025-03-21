import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/widgets/tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/description_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/defs/const_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/color_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/bloc/task_detail_bloc.dart';

part 'components/task_info_section.dart';
part 'components/task_report_info_section.dart';

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
        _TaskInfoSection(),
        const SizedBox(height: 20),
        _TaskInfoDescriptionSection(),
        const Divider(
          color: Colors.grey,
          thickness: 2,
          indent: 16,
          endIndent: 16,
          height: 30,
        ),
        _TaskReportInfoSection(),
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
