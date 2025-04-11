import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/auth/auth_repo.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/model/password.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/model/username.dart';
import 'package:formz/formz.dart';

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc({required AuthRepository authRepo})
    : _authRepository = authRepo,
      super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  bool _validate() {
    return Formz.validate([state.username, state.password]);
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = UsernameInput.dirty(event.username);
    emit(state.copyWith(username: username, isValid: _validate()));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(state.copyWith(password: password, isValid: _validate()));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final isValid = _validate();
    if (isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final result = await _authRepository.login(
          username: state.username.value,
          password: state.password.value,
        );
        if (result) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
          return;
        }
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } else {
      emit(
        state.copyWith(
          isValid: isValid,
          username: UsernameInput.dirty(state.username.value),
          password: PasswordInput.dirty(state.password.value),
        ),
      );
    }
  }
}
