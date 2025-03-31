import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_text_display_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/pages/projects/subpages/project_detail/bloc/project_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/project.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';

class _WorkItemListDisplayItem extends StatelessWidget {
  final WorkItemRecord _workItemRecord;

  const _WorkItemListDisplayItem({required WorkItemRecord workItemRecord})
    : _workItemRecord = workItemRecord;

  void onTapWorkItem({required BuildContext context, required ID workId}) {
    context.push("${context.namedLocation("works")}/$workId/detail");
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

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
    // final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    return BlocBuilder<ProjectDetailBloc, PageDetailState>(
      builder: (context, state) {
        if (state is ProjectDetailStateRecordReady) {
          if (state.activeWorkItems.isNotEmpty) {
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
                      for (final workItemRecord in state.activeWorkItems)
                        _WorkItemListDisplayItem(
                          workItemRecord: workItemRecord,
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text("Chưa có dữ liệu", style: typography.base);
        } else {
          return LoadingTextDisplayWidget();
        }
      },
    );
  }
}

class ProjectWorkManagePage extends StatelessWidget {
  const ProjectWorkManagePage({super.key});

  void onPressBackButton(BuildContext context) {
    context.pop();
  }

  AppBar _ProjectWorkListPageHeader({required BuildContext context}) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return AppBar(
      backgroundColor: presets.color_background_primary,
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
    final presets = context.read<ThemeBloc>().state.presets;

    return Scaffold(
      backgroundColor: presets.color_background_1,
      appBar: _ProjectWorkListPageHeader(context: context),
      body: _ProjectWorkListPageContent(),
    );
  }
}
