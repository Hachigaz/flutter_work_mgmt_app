import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum UsernameValidationError {
  empty(message: "Tên đăng nhập không được để trống"),
  invalid(message: "Tên đăng nhập không hợp lệ");

  final String message;
  const UsernameValidationError({required this.message});
}

class UsernameInput extends FormzInput<String, UsernameValidationError> {
  const UsernameInput.pure() : super.pure('');
  const UsernameInput.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    }
    if (value.length > 24) {
      return UsernameValidationError.invalid;
    }
    if (!isAlphanumeric(value)) {
      return UsernameValidationError.invalid;
    }
    return null;
  }
}
