part of "../report_form.dart";

class _SelectInputWidget extends StatelessWidget {
  final String inputKey;
  final Widget fieldLabel;
  final List<String> initialValue;
  final List<SelectionFieldOption> fieldOptions;

  const _SelectInputWidget({
    required this.inputKey,
    required this.fieldLabel,
    required this.initialValue,
    required this.fieldOptions,
  });

  @override
  Widget build(BuildContext context) {
    final presets = context.read<ThemeBloc>().state.presets;
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        state as ReportFormStateReady;
        final input = state.formInputs[inputKey]!;
        return FSelectGroup<String>(
          forceErrorText: input.displayError?.message,
          style: presets.select_group_style_default,
          label: fieldLabel,
          items: [
            for (final selectItem in fieldOptions)
              FSelectGroupItem<String>.checkbox(
                value: selectItem.name,

                label: Text(selectItem.label),
              ),
          ],
          controller: FMultiSelectGroupController(
            values: (input.value as List<String>).toSet(),
            onUpdate: (value) {
              context.read<ReportFormBloc>().add(
                ReportFormInputChange(
                  inputKey: inputKey,
                  value: value,
                  fieldType: FieldType.selection,
                ),
              );
            },
          ),
        );
      },
      buildWhen: (previous, current) {
        if (previous is ReportFormStateReady &&
            current is ReportFormStateReady) {
          if (current.lastChangedValue == inputKey ||
              current.lastChangedValue == "all") {
            return true;
          } else {
            return false;
          }
        } else {
          throw Exception("Unexpected Error");
        }
      },
    );
  }
}
