part of "../project_detail_page.dart";

class _ProjectDetailMenuSection extends StatelessWidget {
  void _onClickManageWorkButton({
    required BuildContext context,
    required ID projectId,
  }) {
    context.push("${context.namedLocation("projects")}/$projectId/work_manage");
  }

  void _onClickManageContractButton({
    required BuildContext context,
    required ID projectId,
  }) {
    context.push(
      "${context.namedLocation("projects")}/$projectId/contract_manage",
    );
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    final menuButtonStyle = presets.button_style_default_rounded.copyWith(
      backgroundColor: WidgetStateProperty.all<Color>(
        presets.color_background_2,
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    return PageListSection(
      label: Text(
        "Chức năng",
        style: typography.lg.copyWith(fontWeight: FontWeight.w600),
      ),
      child: BlocBuilder<ProjectDetailBloc, PageDetailState<ProjectRecord>>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: menuButtonStyle,
                  onPressed:
                      (state is ProjectDetailStateRecordReady)
                          ? () {
                            _onClickManageWorkButton(
                              context: context,
                              projectId: state.record.id!,
                            );
                          }
                          : null,
                  child: Text(style: typography.base, "Quản lý hạng mục"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: menuButtonStyle,
                  onPressed:
                      (state is ProjectDetailStateRecordReady)
                          ? () {
                            _onClickManageContractButton(
                              context: context,
                              projectId: state.record.id!,
                            );
                          }
                          : null,
                  child: Text(style: typography.base, "Quản lý hợp đồng"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
