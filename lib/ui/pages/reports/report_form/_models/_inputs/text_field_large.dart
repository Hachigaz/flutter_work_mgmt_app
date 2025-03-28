import 'package:formz/formz.dart';

// const _maxCharacter = 20;

enum ReportFormTextFieldLargeInputError {
  empty(message: "Trường này không được để trống"),
  invalid(message: "Giá trị không hợp lệ");
  // too_long(message: "Nội dung vượt quá $_maxCharacter ký tự");

  final String message;

  const ReportFormTextFieldLargeInputError({required this.message});
}

class ReportFormTextFieldLargeInput
    extends FormzInput<String, ReportFormTextFieldLargeInputError> {
  const ReportFormTextFieldLargeInput.pure([super.value = ""]) : super.pure();
  const ReportFormTextFieldLargeInput.dirty([super.value = ""]) : super.dirty();

  @override
  ReportFormTextFieldLargeInputError? validator(String value) {
    if (value.isEmpty) {
      return ReportFormTextFieldLargeInputError.empty;
    }
    // else if (value.length > _maxCharacter) {
    //   return ReportFormTextFieldLargeInputError.too_long;
    // }
    return null;
  }
}
