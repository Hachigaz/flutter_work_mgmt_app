import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';

part "views/task_manage_task_list_section.dart";

class _WorkItemTaskManagePageContent extends StatelessWidget {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.all(0),
      children: [
        _WorkItemTaskListViewSection(scrollController: scrollController),
      ],
    );
  }
}

class WorkItemTaskManagePage extends StatelessWidget {
  const WorkItemTaskManagePage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _WorkItemDetailPageHeader(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return AppBar(
      backgroundColor: colorScheme.primary.withAlpha(0),
      centerTitle: true,
      title: Text(
        "Quản lý công việc",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.secondaryForeground),
        onPressed: () => onPressBackButton(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Scaffold(
      appBar: _WorkItemDetailPageHeader(context),
      backgroundColor: colorScheme.background,
      body: _WorkItemTaskManagePageContent(),
    );
  }
}
