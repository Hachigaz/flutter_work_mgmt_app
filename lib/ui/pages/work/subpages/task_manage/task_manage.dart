import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/defs/const_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/bloc/work_item_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/work/subpages/task_manage/bloc/task_manage_bloc.dart';

part "views/task_detail_task_list_section.dart";

class _WorkItemSearchBarWidget extends StatelessWidget {
  final _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;
    return BlocBuilder<TaskManageTaskListBloc, TaskManageTaskListState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 200.w,
                child: TextField(
                  enabled: state is! TaskManageTaskListStateLoading,
                  style: typography.base,
                  cursorColor: colorScheme.primary,
                  cursorErrorColor: colorScheme.error,
                  keyboardType: TextInputType.text,
                  decoration: input_dec_bordered.copyWith(
                    hintText: "Nhập tên công việc",
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.secondaryForeground,
                      size: 30,
                    ),
                  ),
                  maxLines: 1,
                  onSubmitted: (value) {
                    if (state is! TaskManageTaskListStateLoading) {
                      context.read<TaskManageTaskListBloc>().add(
                        TaskManageTaskListEventSearchCall(searchValue: value),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              if (state is TaskManageTaskListStateLoading)
                CircularProgressIndicator(
                  color: colorScheme.secondaryForeground,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _WorkItemTaskManagePageContent extends StatelessWidget {
  final _scrollController = ScrollController();

  void _onScroll({required BuildContext context}) {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final taskListBloc = context.read<TaskManageTaskListBloc>();
      if (!taskListBloc.state.isLast &&
          taskListBloc.state is TaskManageTaskListStateReady) {
        taskListBloc.add(TaskManageTaskListEventLoadMoreCall());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _onScroll(context: context);
    });

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.all(0),
      children: [_WorkItemSearchBarWidget(), _WorkItemTaskListViewSection()],
    );
  }
}

class WorkItemTaskManagePage extends StatelessWidget {
  const WorkItemTaskManagePage({super.key});

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
