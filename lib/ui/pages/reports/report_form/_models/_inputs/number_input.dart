import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum ReportFormNumberInputError {
  empty(message: "Trường này không được để trống"),
  // invalid(message: "Giá trị nhập không hợp lệ"),
  not_a_number(message: "Giá trị không phải là số");

  final String message;

  const ReportFormNumberInputError({required this.message});
}

class ReportFormNumberFieldInput
    extends FormzInput<String, ReportFormNumberInputError> {
  const ReportFormNumberFieldInput.pure([super.value = ""]) : super.pure();
  const ReportFormNumberFieldInput.dirty([super.value = ""]) : super.dirty();

  @override
  ReportFormNumberInputError? validator(String value) {
    if (value.isEmpty) {
      return ReportFormNumberInputError.empty;
    }
    if (!isNumeric(value)) {
      return ReportFormNumberInputError.not_a_number;
    }
    return null;
  }
}
