part of "login_bloc.dart";

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
