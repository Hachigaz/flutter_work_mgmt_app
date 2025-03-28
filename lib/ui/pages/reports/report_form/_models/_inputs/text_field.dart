import 'package:formz/formz.dart';

const _maxCharacter = 20;

enum ReportFormTextInputError {
  empty(message: "Trường này không được để trống"),
  invalid(message: "Giá trị không hợp lệ"),
  too_long(message: "Nội dung vượt quá $_maxCharacter ký tự");

  final String message;

  const ReportFormTextInputError({required this.message});
}

class ReportFormTextFieldInput
    extends FormzInput<String, ReportFormTextInputError> {
  const ReportFormTextFieldInput.pure([super.value = '']) : super.pure();
  const ReportFormTextFieldInput.dirty([super.value = '']) : super.dirty();

  @override
  ReportFormTextInputError? validator(String value) {
    if (value.isEmpty) {
      return ReportFormTextInputError.empty;
    } else if (value.length > _maxCharacter) {
      return ReportFormTextInputError.too_long;
    }
    return null;
  }
}
