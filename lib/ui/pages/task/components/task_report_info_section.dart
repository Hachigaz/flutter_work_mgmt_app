part of "../task_detail_page.dart";

class _RecurringTaskReportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      ],
    );
  }
}

class _ReportScheduleListItem extends StatelessWidget {
  final ReportSchedule schedule;

  void onTapReportItem({required BuildContext context, required ID reportId}) {
    context.go("${context.namedLocation("reports")}/$reportId/details");
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
                        "Lập báo cáo",
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

class _TimestampTaskReportSection extends StatelessWidget {
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

class _TaskReportInfoSection extends StatelessWidget {
  const _TaskReportInfoSection();

  void onClickGenerateReportButton(BuildContext context) {
    context.push("${context.namedLocation("reports")}/detail/1");
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
              content: _TimestampTaskReportSection(),
            ),
            FTabEntry(
              label: Text("Báo cáo đã lưu"),
              content: _RecurringTaskReportSection(),
            ),
          ],
        ),
      ),
    );
  }
}
