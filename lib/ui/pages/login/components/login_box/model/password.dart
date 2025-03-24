import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum PasswordValidationError {
  empty(message: "Mật khẩu không được để trống"),
  invalid(message: "Mật khẩu không hợp lệ");

  final String message;
  const PasswordValidationError({required this.message});
}

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    if (value.length > 24) {
      return PasswordValidationError.invalid;
    }
    if (!isAlphanumeric(value)) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}
