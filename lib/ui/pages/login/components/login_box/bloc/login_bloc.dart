import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';
import 'package:flutter_work_mgmt_app/commons/providers/app_provider/auth_repo.dart';

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

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = UsernameInput.dirty(event.username);
    emit(
      state.copyWith(username: username, isValid: Formz.validate([username])),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(
      state.copyWith(password: password, isValid: Formz.validate([password])),
    );
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final result = await _authRepository.login(
          accountname: state.username.value,
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
    }
  }
}
