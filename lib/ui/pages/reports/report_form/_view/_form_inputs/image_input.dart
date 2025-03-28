part of "../report_form.dart";

class _ImageInputWidget extends StatelessWidget {
  final String inputKey;
  final Widget fieldLabel;
  final File? initialValue;

  const _ImageInputWidget({
    required this.inputKey,
    required this.fieldLabel,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        state as ReportFormStateReady;
        return ImagePickerFormField(
          errorText: state.formInputs[inputKey]!.displayError?.message,
          label: fieldLabel,
          initValue: initialValue,
          onChanged: (file) {
            context.read<ReportFormBloc>().add(
              ReportFormInputChange(
                value: file,
                inputKey: inputKey,
                fieldType: FieldType.image,
              ),
            );
          },
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
