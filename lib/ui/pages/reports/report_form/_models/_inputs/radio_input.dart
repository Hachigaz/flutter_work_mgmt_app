import 'package:formz/formz.dart';

enum ReportFormRadioInputError {
  empty(message: "Trường này không được để trống");

  final String message;

  const ReportFormRadioInputError({required this.message});
}

class ReportFormRadioFieldInput
    extends FormzInput<String?, ReportFormRadioInputError> {
  const ReportFormRadioFieldInput.pure([super.value]) : super.pure();
  const ReportFormRadioFieldInput.dirty([super.value]) : super.dirty();

  @override
  ReportFormRadioInputError? validator(String? value) {
    if (value == null) {
      return ReportFormRadioInputError.empty;
    }
    return null;
  }
}
