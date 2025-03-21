part of "../project_detail_page.dart";

class _ProjectDetailWorkOverviewSection extends StatelessWidget {
  onPressCreateWorkItemButton(BuildContext context) {
    final projectRecord =
        context.read<ProjectDetailPageRepository>().projectRecord;
    context.push(
      "${context.namedLocation("works")}/create/${projectRecord.id}",
    );
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;
    final pageRepo = context.read<ProjectDetailPageRepository>();
    final workRecord = pageRepo.activeWorkItemRecord;
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
            style: button_style_default,
            onPressed: () => {onPressCreateWorkItemButton(context)},
            child: Icon(Icons.add),
          ),
        ],
      ),
      child: Padding(
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
                        text: "10",
                        style: typography.lg.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: " Hoàn thành", style: typography.base),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "20",
                        style: typography.lg.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: " Chưa thực hiện", style: typography.base),
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
                      sections: [
                        PieChartSectionData(
                          value: 25,
                          color: Colors.blue,
                          radius: 25.r,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 100 - 25,
                          color: Colors.grey.shade300,
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
                    "${25.toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

class _ProjectDetailCurrentActiveWorkSection extends StatelessWidget {
  void onTapWorkItem({required BuildContext context, required ID workId}) {
    context.push("${context.namedLocation("works")}/$workId/detail");
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    final pageRepo = context.read<ProjectDetailPageRepository>();
    final workRecord = pageRepo.activeWorkItemRecord;
    return PageListSection(
      label: Text(
        "Đang hoạt động",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding_4xl),
        child: GestureDetector(
          onTap: () => onTapWorkItem(context: context, workId: workRecord.id),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color_background_primary,
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
                    workRecord.name,
                    style: typography.lg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Tiến độ: ${(workRecord.progression * 100).toStringAsFixed(2)}%",
                  style: typography.sm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Ngày bắt đầu: ${date_fmat_date.format(workRecord.startDate)}",
                  style: typography.sm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
