import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/data/models/model.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.library_books_sharp,
                      color: colorScheme.foreground,
                    ),
                  ),
                  Text(
                    "Hạng mục",
                    style: typography.xl.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  _workItemRecord.name!,
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
                  "Tiến độ: ${(_workItemRecord.progression! * 100).toStringAsFixed(1)}%",
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding_md),
                child: Text(
                  "Ngày bắt đầu: ${date_fmat_date.format(_workItemRecord.startDate!)}",
                  style: typography.base.copyWith(fontWeight: FontWeight.w600),
                ),
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
    final workItemListBloc = ListViewBloc<WorkItemRecord>(
      dataRepo: context.read<DataRepository<WorkItemRecord>>(),
    );
    final typography = context.theme.typography;
    final scrollController = ScrollController();
    return ListView(
      controller: scrollController,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6, left: 10),
          child: SearchBarWidget<
            WorkItemRecord,
            ListViewStateLoading<WorkItemRecord>,
            ListViewEventSearchCall<WorkItemRecord>
          >(
            hintText: "Nhập tên hạng mục",
            searchCallCreator:
                (searchValue) => ListViewEventSearchCall<WorkItemRecord>(
                  searchValue: searchValue,
                ),
            listBloc: workItemListBloc,
          ),
        ),
        ListViewWidget<WorkItemRecord>(
          listBuilder: (workItemList) {
            return Column(
              children: [
                for (final record in workItemList)
                  _WorkItemListDisplayItem(workItemRecord: record),
              ],
            );
          },
          scrollController: scrollController,
          listBloc: workItemListBloc,
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
