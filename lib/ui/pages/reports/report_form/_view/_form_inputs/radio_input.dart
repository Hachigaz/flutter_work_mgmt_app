part of "../report_form.dart";

class _RadioInputWidget extends StatelessWidget {
  final String inputKey;
  final Widget fieldLabel;
  final String? initialValue;
  final List<RadioFieldOption> fieldOptions;

  const _RadioInputWidget({
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
            for (final radioItem in fieldOptions)
              FSelectGroupItem<String>.radio(
                value: radioItem.name,
                label: Text(radioItem.label),
              ),
          ],
          controller: FRadioSelectGroupController(
            value: input.value as String?,
            onUpdate: (value) {
              context.read<ReportFormBloc>().add(
                ReportFormInputChange(
                  inputKey: inputKey,
                  value: value,
                  fieldType: FieldType.radio,
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
