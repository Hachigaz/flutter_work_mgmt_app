part of "login_bloc.dart";

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

final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final UsernameInput username;
  final PasswordInput password;
  final bool isValid;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.isValid = false,
  });

  @override
  List<Object?> get props => [status, username, password, isValid];

  LoginState copyWith({
    FormzSubmissionStatus? status,
    UsernameInput? username,
    PasswordInput? password,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }
}
