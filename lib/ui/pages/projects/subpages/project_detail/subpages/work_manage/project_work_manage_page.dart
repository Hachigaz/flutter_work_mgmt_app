import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/color_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_repo.dart';

class _WorkItemListDisplayItem extends StatelessWidget {
  final WorkItemRecord _workItemRecord;

  const _WorkItemListDisplayItem({required WorkItemRecord workItemRecord})
    : _workItemRecord = workItemRecord;

  void onTapWorkItem({required BuildContext context, required ID workId}) {
    context.push("${context.namedLocation("works")}/$workId/detail");
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

    return GestureDetector(
      onTap: () => {onTapWorkItem(context: context, workId: 1)},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(color: colorScheme.border, width: 1),
            bottom: BorderSide(color: colorScheme.border, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding_xl,
            horizontal: padding_2xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  "Work item 1",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.typography.xl2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  "Trạng thái: ${"đang hoạt động"}",
                  style: typography.base,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text("Địa chỉ: ", style: typography.base),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectWorkListPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageRepo = context.read<ProjectDetailPageRepository>();
    final WorkItemRecord workItemRecord = pageRepo.activeWorkItemRecord;

    // final colorScheme = appThemeData.colorScheme;
    // final typography = appThemeData.typography;

    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: padding_md,
        horizontal: padding_md,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: padding_sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
              _WorkItemListDisplayItem(workItemRecord: workItemRecord),
            ],
          ),
        ),
      ],
    );
  }
}

class ProjectWorkManagePage extends StatelessWidget {
  const ProjectWorkManagePage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _ProjectWorkListPageHeader({required BuildContext context}) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return AppBar(
      backgroundColor: color_background_primary,
      centerTitle: true,
      title: Text(
        "Quản lý hạng mục",
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
      backgroundColor: color_background_1,
      appBar: _ProjectWorkListPageHeader(context: context),
      body: _ProjectWorkListPageContent(),
    );
  }
}
