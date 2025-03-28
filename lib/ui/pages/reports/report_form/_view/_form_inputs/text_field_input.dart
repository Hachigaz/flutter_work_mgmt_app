part of '../report_form.dart';

class _TextFieldInputWidget extends StatelessWidget {
  final String inputKey;
  final Widget fieldLabel;
  final String? initialValue;

  const _TextFieldInputWidget({
    required this.inputKey,
    required this.fieldLabel,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        state as ReportFormStateReady;
        return TextFormField(
          initialValue: initialValue,
          style: typography.base,
          cursorColor: colorScheme.primary,
          cursorErrorColor: colorScheme.error,
          keyboardType: TextInputType.text,
          decoration: presets.input_dec_default_border.copyWith(
            label: fieldLabel,
            errorText: state.formInputs[inputKey]?.displayError?.message,
          ),
          onChanged: (value) {
            context.read<ReportFormBloc>().add(
              ReportFormInputChange(
                value: value,
                inputKey: inputKey,
                fieldType: FieldType.textbox,
              ),
            );
          },
          maxLines: 1,
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
