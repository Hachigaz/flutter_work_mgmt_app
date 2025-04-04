part of "../project_detail_page.dart";

class _ProjectDetailWorkOverviewSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectDetailWorkOverviewSectionState();
  }
}

class _ProjectDetailWorkOverviewSectionState
    extends State<_ProjectDetailWorkOverviewSection> {
  static const double animationMaxVal = 1000;
  _onPressCreateWorkItemButton({
    required BuildContext context,
    required ID workId,
  }) {
    context.push("${context.namedLocation("works")}/create/$workId");
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;
    return BlocBuilder<ProjectDetailBloc, PageDetailState<ProjectRecord>>(
      builder: (context, state) {
        return PageListSection(
          label: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng quan hạng mục",
                style: typography.lg.copyWith(fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                style: presets.button_style_default_rounded,
                onPressed:
                    (state is ProjectDetailStateRecordReady)
                        ? () => {
                          _onPressCreateWorkItemButton(
                            context: context,
                            workId: state.record.id!,
                          ),
                        }
                        : null,
                child: Icon(Icons.add),
              ),
            ],
          ),
          child:
              (state is ProjectDetailStateRecordReady)
                  ? TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: animationMaxVal),
                    curve: Curves.easeInOutExpo,
                    duration: Duration(milliseconds: 1000),
                    builder: (context, angle, child) {
                      final animationOffset = angle / animationMaxVal;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding_3xl),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spacing_sm,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${(state.record.completedWorkCount! * animationOffset).toInt()}",
                                        style: typography.lg.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Hoàn thành",
                                        style: typography.base,
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${(state.record.workItemCount! * animationOffset).toInt()}",
                                        style: typography.lg.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Chưa thực hiện",
                                        style: typography.base,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 100.r,
                                  height: 100.r,
                                  child: PieChart(
                                    PieChartData(
                                      startDegreeOffset: 180,
                                      sections: [
                                        //completed section
                                        PieChartSectionData(
                                          value:
                                              state.record.completedWorkCount! *
                                              animationOffset,
                                          color: colorScheme.primary,
                                          radius: 25.r,
                                          showTitle: false,
                                        ),
                                        //remaining section
                                        PieChartSectionData(
                                          value:
                                              (state.record.workItemCount! -
                                                      state
                                                          .record
                                                          .completedWorkCount!)
                                                  .toDouble(),
                                          color: colorScheme.muted,
                                          radius: 25.r,
                                          showTitle: false,
                                        ),
                                      ],
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 35,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: padding_xl),
                                  child: Text(
                                    "${(((state.record.completedWorkCount! / state.record.workItemCount!) * 100)).toStringAsFixed(1)}%",
                                    style: typography.base.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                  : LoadingTextDisplayWidget(),
        );
      },
    );
  }
}

class _ProjectDetailCurrentActiveWorkSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    return PageListSection(
      label: Text(
        "Đang hoạt động",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      child: BlocBuilder<ProjectDetailBloc, PageDetailState<ProjectRecord>>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding_4xl),
            child:
                (state is ProjectDetailStateRecordReady)
                    ? (state.activeWorkItems.isNotEmpty)
                        ? WorkItemDisplayItem(
                          workItem: state.activeWorkItems[0],
                        )
                        : Text("Chưa có dữ liệu", style: typography.base)
                    : LoadingTextDisplayWidget(),
          );
        },
      ),
    );
  }
}

class WorkItemDisplayItem extends StatelessWidget {
  final WorkItemRecord workItem;

  void onTapWorkItem({required BuildContext context, required ID workId}) {
    context.push("${context.namedLocation("works")}/$workId/detail");
  }

  const WorkItemDisplayItem({super.key, required this.workItem});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final presets = context.read<ThemeBloc>().state.presets;

    return GestureDetector(
      onTap: () {
        onTapWorkItem(context: context, workId: workItem.id!);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: presets.color_background_primary.withAlpha(180),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(padding_xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.construction, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  "Hạng mục",
                  style: typography.sm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_lg),
              child: Text(
                workItem.name!,
                style: typography.lg.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Tiến độ: ${(workItem.progression! * 100).toStringAsFixed(2)}%",
              style: typography.sm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Ngày bắt đầu: ${date_fmat_date.format(workItem.startDate!)}",
              style: typography.sm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
