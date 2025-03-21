part of "../project_detail_page.dart";

class _ProjectDetailContractOverviewSection extends StatelessWidget {
  void onPressCreateContractButton(BuildContext context) {}

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
            "Hợp đồng",
            style: typography.lg.copyWith(fontWeight: FontWeight.w600),
          ),
          ElevatedButton(
            style: button_style_default,
            onPressed: () => {onPressCreateContractButton(context)},
            child: Icon(Icons.add),
          ),
        ],
      ),
      child: Container(),
    );
  }
}
