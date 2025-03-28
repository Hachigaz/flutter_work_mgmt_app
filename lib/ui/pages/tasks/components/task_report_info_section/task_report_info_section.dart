import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/project.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/data_repositories/data_repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_detail/page_detail_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/commons/providers/ui/blocs/theme/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/pages/tasks/_bloc/task_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class _ReportScheduleListItem extends StatelessWidget {
  final ReportSchedule schedule;

  void onTapReportItem({required BuildContext context, required ID reportId}) {
    context.push("${context.namedLocation("reports")}/$reportId/detail");
  }

  const _ReportScheduleListItem({required this.schedule});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 4,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            date_fmat_datemonth.format(schedule.dueDate!),
            style: typography.lg.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 15.sp,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: colorScheme.primary.darker(30).withAlpha(130),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Badge(
                  padding: EdgeInsets.all(0),
                  offset: Offset(-50, -10),
                  backgroundColor: Colors.white.withAlpha(0),
                  label:
                      (schedule.dueDate!.isBefore(DateTime.now()))
                          ? Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: colorScheme.error,
                                size: 20,
                              ),
                              Text(
                                "Trễ hạn",
                                style: typography.sm.copyWith(
                                  color: colorScheme.error,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                          : SizedBox(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        schedule.title != null
                            ? "${schedule.title}\n\n"
                            : "Báo cáo",
                        style: typography.lg.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date_fmat_date.format(schedule.dueDate!)),
                    ElevatedButton(
                      style: presets.button_style_default_rounded.copyWith(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          colorScheme.primary.darker(20),
                        ),
                      ),
                      onPressed: () {
                        onTapReportItem(
                          context: context,
                          reportId: schedule.id!,
                        );
                      },
                      child: Text(
                        (schedule.reportId == null)
                            ? "Lập báo cáo"
                            : "Chỉnh sửa",
                        style: typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReportScheduleNotSentListItem extends StatelessWidget {
  final ReportSchedule schedule;

  const _ReportScheduleNotSentListItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

    void onPressEditButton({required BuildContext context}) {
      print('Chỉnh sửa');
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.primary.darker(35).withAlpha(150),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule.title!,
              style: typography.lg.copyWith(fontWeight: FontWeight.w600),
            ),
            Text("Hạn báo cáo: ${date_fmat_date.format(schedule.dueDate!)}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                ElevatedButton(
                  style: presets.button_style_default_rounded.copyWith(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      colorScheme.primary.darker(20),
                    ),
                  ),
                  onPressed: () {
                    onPressEditButton(context: context);
                  },
                  child: Text(
                    "Chỉnh sửa",
                    style: typography.base.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NotSentReportSection extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final scheduleBloc = ListViewBloc<ReportSchedule>(
      dataRepo: context.read<DataRepository<ReportSchedule>>(),
    );
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SearchBarWidget<
            ReportSchedule,
            ListViewStateLoading<ReportSchedule>,
            ListViewEventSearchCall<ReportSchedule>
          >(
            hintText: "Nhập tên báo cáo",
            searchCallCreator:
                (value) =>
                    ListViewEventSearchCall<ReportSchedule>(searchValue: value),
            listBloc: scheduleBloc,
          ),
        ),
        ListViewWidget<ReportSchedule>(
          listBloc: scheduleBloc,
          listBuilder: (itemList) {
            return Column(
              children: [
                for (final item in itemList)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: _ReportScheduleNotSentListItem(schedule: item),
                  ),
              ],
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
          return Column(
            children: [
              for (final schedule in state.upcomingReportSchedule)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: _ReportScheduleListItem(schedule: schedule),
                ),
            ],
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
