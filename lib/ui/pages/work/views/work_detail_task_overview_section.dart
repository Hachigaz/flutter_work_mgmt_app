part of "../work_item_detail_page.dart";

class _TaskDisplayItemCardSmall extends StatelessWidget {
  final TaskRecord taskRecord;
  final Color? itemColor;
  final Color? textColor;

  const _TaskDisplayItemCardSmall({
    required this.taskRecord,
    this.itemColor,
    this.textColor,
  });

  void onTapTaskItem(BuildContext context) {
    context.push("${context.namedLocation("tasks")}/${taskRecord.id}/detail");
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return GestureDetector(
      onTap: () => onTapTaskItem(context),
      child: Stack(
        children: [
          Image.asset("assets/images/task_item_background.png"),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: itemColor ?? colorScheme.primary.withAlpha(180),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(
                          //       taskRecord.type == TaskType.timestamp
                          //           ? Icons.calendar_month_outlined
                          //           : CupertinoIcons.arrow_2_circlepath,
                          //       color: colorScheme.foreground,
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 4),
                          //       child: Text(
                          //         "${taskRecord.type?.label}",
                          //         style: typography.base.copyWith(
                          //           color: colorScheme.foreground,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Icon(Icons.task, color: colorScheme.foreground),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  "Công việc",
                                  style: typography.base.copyWith(
                                    color: colorScheme.foreground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${taskRecord.nameShort}\n",
                                  style: typography.xl.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  "Báo cáo gần nhất:",
                                  style: typography.sm.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Báo cáo number one",
                                    style: typography.base.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (DateTime.now().toUtc().isBefore(
                                    // taskRecord.closestReport,
                                    DateTime.now(),
                                  ) &&
                                  taskRecord.status != TaskStatus.completed)
                              ? Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: colorScheme.error,
                                      size: 20,
                                    ),
                                    Text(
                                      "Trễ hạn",
                                      style: typography.base.copyWith(
                                        color: colorScheme.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox(),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: 4 / 6, // 70% progress
                              strokeWidth: 4.0, // Adjust thickness
                              backgroundColor: colorScheme.foreground.withAlpha(
                                50,
                              ), // Optional background
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.foreground,
                              ), // Progress color
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "40/600\n Hoàn thành",
                              textAlign: TextAlign.center,
                              style: typography.sm.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkDetailTaskOverviewSection extends StatelessWidget {
  void onClickTaskManageButton({
    required BuildContext context,
    required ID workId,
  }) {
    context.push("${context.namedLocation("works")}/$workId/task_manage");
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tổng quan công việc",
              style: typography.xl.copyWith(fontWeight: FontWeight.w600),
            ),
            BlocBuilder<WorkItemDetailBloc, WorkItemDetailState>(
              builder: (context, state) {
                if (state is WorkItemDetailStateReady) {
                  return OutlinedButton(
                    onPressed: () {
                      onClickTaskManageButton(
                        context: context,
                        workId: state.workItem.id!,
                      );
                    },
                    style: button_style_default.copyWith(
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text("Chi tiết"),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                return previous is! WorkItemDetailStateReady;
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng công việc:",
                        style: typography.base.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "30",
                        style: typography.base.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Đang thực hiện:",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "10",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hoàn thành:",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "10",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trễ hạn:",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "10",
                          style: typography.base.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.r,
                    height: 150.r,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 33.3,
                            color: Colors.blue,
                            radius: 25.r,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            value: 33.3,
                            color: const Color.fromARGB(255, 101, 254, 111),
                            radius: 25.r,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            value: 33.3,
                            color: const Color.fromARGB(255, 254, 86, 86),
                            radius: 25.r,
                            showTitle: false,
                          ),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        PageListSection(
          labelText: "Công việc hôm nay",
          child: BlocBuilder<WorkItemDetailBloc, WorkItemDetailState>(
            builder: (context, state) {
              if (state is WorkItemDetailStateReady) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 140.h),
                  child: SwipableListView(
                    viewportFraction: 0.95,
                    children: [
                      for (final record in state.activeTaskRecord)
                        _TaskDisplayItemCardSmall(taskRecord: record),
                    ],
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: colorScheme.primary),
                );
              }
            },
            buildWhen: (previous, current) {
              return previous is! WorkItemDetailStateReady;
            },
          ),
        ),
        const SizedBox(height: 30),
        PageListSection(
          labelText: "Công việc trễ hạn",
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 140.h),
            child: BlocBuilder<WorkItemDetailBloc, WorkItemDetailState>(
              builder: (context, state) {
                if (state is WorkItemDetailStateReady) {
                  return SwipableListView(
                    viewportFraction: 0.95,
                    children: [
                      for (final record in state.completedTaskRecord)
                        _TaskDisplayItemCardSmall(
                          taskRecord: record,
                          itemColor: const Color.fromARGB(183, 255, 166, 0),
                        ),
                    ],
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                return previous is! WorkItemDetailStateReady;
              },
            ),
          ),
        ),
        // _ActiveTaskListSection(),
        // _CompletedTaskListSection(),
      ],
    );
  }
}
