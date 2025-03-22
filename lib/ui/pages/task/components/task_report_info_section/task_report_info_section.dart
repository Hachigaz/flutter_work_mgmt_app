import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/commons/models/model.dart';
import 'package:flutter_work_mgmt_app/commons/models/report.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_repositories/report_repository.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/bloc/list_view_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/search_bar_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/task/bloc/task_detail_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class _ReportScheduleListItem extends StatelessWidget {
  final ReportSchedule schedule;

  void onTapReportItem({required BuildContext context, required ID reportId}) {
    context.go("${context.namedLocation("reports")}/$reportId/detail");
  }

  const _ReportScheduleListItem({required this.schedule});
  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

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
              color: colorScheme.primary
                  .mix(colorScheme.background, 0.9)
                  ?.withAlpha(200),
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
                    OutlinedButton(
                      style: button_style_default.copyWith(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: padding_md,
                          ),
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
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

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
                  onPressed: () {
                    print("chỉnh sửa");
                  },
                  style: button_style_primary.copyWith(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      colorScheme.primary.lighter(20).withAlpha(200),
                    ),
                  ),
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SearchBarWidget<
            ListViewBloc<ReportSchedule>,
            ListViewState<ReportSchedule>,
            ListViewEvent<ReportSchedule>,
            ListViewStateLoading<ReportSchedule>,
            ListViewEventSearchCall<ReportSchedule>
          >(
            hintText: "Nhập tên báo cáo",
            searchCallCreator:
                (value) =>
                    ListViewEventSearchCall<ReportSchedule>(searchValue: value),
          ),
        ),
        ListViewWidget<ReportSchedule>(
          listItemBuilder: (item) {
            return _ReportScheduleNotSentListItem(schedule: item);
          },
        ),
      ],
    );
  }
}

class _UpcomingReportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    // final typography = appThemeData.typography;
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        if (state is TaskDetailStateReady) {
          return Column(
            children: [
              for (final schedule in state.reportSchedules!)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: _ReportScheduleListItem(schedule: schedule),
                ),
            ],
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }
      },
    );
  }
}

class TaskReportInfoSection extends StatelessWidget {
  const TaskReportInfoSection({super.key});

  void onClickGenerateReportButton(BuildContext context) {
    context.push("${context.namedLocation("reports")}/1/detail");
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return PageListSection(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Thông tin báo cáo",
            style: typography.xl2.copyWith(fontWeight: FontWeight.w600),
          ),
          OutlinedButton(
            style: button_style_default,
            child: Text("Tạo lịch báo cáo"),
            onPressed: () {
              onClickGenerateReportButton(context);
            },
          ),
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
