import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/data/models/projects.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_items/report_schedule_display_item_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_bloc/task_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class _NotSentReportSection extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final scheduleBloc = ListViewBloc<ReportScheduleRecord>(
      dataRepo: context.read<DataRepository<ReportScheduleRecord>>(),
    );
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SearchBarWidget<
            ReportScheduleRecord,
            ListViewStateLoading<ReportScheduleRecord>,
            ListViewEventSearchCall<ReportScheduleRecord>
          >(
            hintText: "Nhập tên báo cáo",
            searchCallCreator:
                (value) => ListViewEventSearchCall<ReportScheduleRecord>(
                  searchValue: value,
                ),
            listBloc: scheduleBloc,
          ),
        ),
        ListViewWidget<ReportScheduleRecord>(
          listBloc: scheduleBloc,
          listBuilder: (itemList) {
            return Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  for (final item in itemList)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ReportScheduleListItemWidget(schedule: item),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _UpcomingReportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.theme.colorScheme;
    // final typography = context.theme.typography;
    return BlocBuilder<TaskDetailBloc, PageDetailState<TaskRecord>>(
      builder: (context, state) {
        if (state is TaskDetailStateRecordReady) {
          return Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              children: [
                for (final schedule in state.upcomingReportSchedule)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ReportScheduleListItemWidget(schedule: schedule),
                  ),
              ],
            ),
          );
        } else {
          return LoadingCircleWidget();
        }
      },
    );
  }
}

class TaskReportInfoSection extends StatelessWidget {
  const TaskReportInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    // final presets = context.read<ThemeBloc>().state.presets;

    return PageListSection(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Thông tin báo cáo",
            style: typography.xl2.copyWith(fontWeight: FontWeight.w600),
          ),
          _ScheduleCreateButton(),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding_md),

        child: FTabs(
          tabs: [
            FTabEntry(
              label: Text("Lịch báo cáo"),
              content: _UpcomingReportSection(),
            ),
            FTabEntry(
              label: Text("Báo cáo chưa gửi"),
              content: _NotSentReportSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleCreateButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScheduleCreateButtonState();
  }
}

class _ScheduleCreateButtonState extends State<_ScheduleCreateButton>
    with SingleTickerProviderStateMixin {
  late FPopoverController controller;
  late FRadioSelectGroupController<String> menuGroupController;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
    menuGroupController = FRadioSelectGroupController<String>();
  }

  @override
  void dispose() {
    controller.dispose();
    menuGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;
    return BlocBuilder<TaskDetailBloc, PageDetailState<TaskRecord>>(
      builder: (context, state) {
        return FPopoverMenu(
          popoverController: controller,
          menuAnchor: Alignment.topRight,
          childAnchor: Alignment.bottomRight,
          menu: [
            FTileGroup(
              children: [
                FTile(
                  prefixIcon: FIcon(FAssets.icons.calendar),
                  title: Text('Báo cáo theo lịch', style: typography.base),
                  onPress: () {
                    onClickCreateReportSchedule(context: context);
                  },
                ),
                FTile(
                  prefixIcon: FIcon(FAssets.icons.refreshCcw),
                  title: Text('Báo cáo định kỳ', style: typography.base),
                  onPress: () {
                    onClickCreateRecursiveReportSchedule(context: context);
                  },
                ),
              ],
            ),
          ],
          child: OutlinedButton(
            style: presets.button_style_default_rounded,
            onPressed:
                (state is PageDetailStateRecordReady<TaskRecord>)
                    ? () {
                      controller.toggle();
                    }
                    : null,
            child: Text("Tạo lịch báo cáo"),
          ),
        );
      },
    );
  }

  void onClickCreateReportSchedule({required BuildContext context}) {
    final taskId =
        (context.read<TaskDetailBloc>().state as TaskDetailStateRecordReady)
            .record
            .id;

    final params = {"create_opt": "scheduled"};
    final uri = Uri(
      path: "${context.namedLocation("reports")}/schedule_create/$taskId",
      queryParameters: params,
    );
    context.push(uri.toString());
  }

  void onClickCreateRecursiveReportSchedule({required BuildContext context}) {
    final taskId =
        (context.read<TaskDetailBloc>().state as TaskDetailStateRecordReady)
            .record
            .id;

    final params = {"create_opt": "recursive"};
    final uri = Uri(
      path: "${context.namedLocation("reports")}/schedule_create/$taskId",
      queryParameters: params,
    );
    context.push(uri.toString());
  }
}
