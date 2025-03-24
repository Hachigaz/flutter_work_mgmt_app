part of "../project_detail_page.dart";

class _ProjectDetailContractOverviewSection extends StatelessWidget {
  void onPressCreateContractButton(BuildContext context) {}

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
          ElevatedButton(
            style: presets.button_style_default,
            onPressed: () => {onPressCreateContractButton(context)},
            child: Icon(Icons.add),
          ),
        ],
      ),
      child: Container(),
    );
  }
}
