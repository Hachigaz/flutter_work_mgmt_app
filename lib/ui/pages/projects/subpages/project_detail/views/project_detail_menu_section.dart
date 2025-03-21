part of "../project_detail_page.dart";

class _ProjectDetailMenuSection extends StatelessWidget {
  void onClickManageWorkButton(BuildContext context) {
    final pageRepo = context.read<ProjectDetailPageRepository>();
    final projectId = pageRepo.projectRecord.id;
    context.push("${context.namedLocation("projects")}/$projectId/work_manage");
  }

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    // final colorScheme = appThemeData.colorScheme;

    final menuButtonStyle = button_style_default.copyWith(
      backgroundColor: WidgetStateProperty.all<Color>(color_background_2),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    return PageListSection(
      label: Text(
        "Chức năng",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: menuButtonStyle,
              child: Text(style: typography.base, "Quản lý hạng mục"),
              onPressed: () {
                onClickManageWorkButton(context);
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: menuButtonStyle,
              child: Text(style: typography.base, "Quản lý hợp đồng"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
