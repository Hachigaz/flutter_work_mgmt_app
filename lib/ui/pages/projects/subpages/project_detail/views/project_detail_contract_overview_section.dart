part of "../project_detail_page.dart";

class _ProjectDetailContractOverviewSection extends StatelessWidget {
  void onPressCreateContractButton({
    required BuildContext context,
    required ID projectId,
  }) {
    context.push("${context.namedLocation("contracts")}/create/$projectId");
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    return PageListSection(
      label: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hợp đồng",
            style: typography.lg.copyWith(fontWeight: FontWeight.w600),
          ),
          BlocBuilder<ProjectDetailBloc, PageDetailState<ProjectRecord>>(
            builder: (context, state) {
              return ElevatedButton(
                style: presets.button_style_default_rounded,
                onPressed:
                    (state is ProjectDetailStateRecordReady)
                        ? () => {
                          onPressCreateContractButton(
                            context: context,
                            projectId:
                                (context.read<ProjectDetailBloc>().state
                                        as ProjectDetailStateRecordReady)
                                    .record
                                    .id!,
                          ),
                        }
                        : null,
                child: Icon(Icons.add),
              );
            },
          ),
        ],
      ),
      child: Container(),
    );
  }
}
