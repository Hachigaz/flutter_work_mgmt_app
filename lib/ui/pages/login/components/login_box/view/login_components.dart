import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/input_style_presets.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/bloc/login_bloc.dart';

class LoginUsernameTextField extends StatelessWidget {
  const LoginUsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError,
    );
    return TextField(
      style: typography.base,
      cursorColor: colorScheme.primary,
      cursorErrorColor: colorScheme.error,
      keyboardType: TextInputType.text,
      decoration: input_dec_bordered.copyWith(
        label: const Text("Tên đăng nhập"),
        hintText: "Tên đăng nhập",
        errorText: displayError?.message,
      ),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username: username));
      },
      maxLines: 1,
    );
  }
}

class LoginPasswordTextField extends StatelessWidget {
  const LoginPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );
    return TextField(
      style: typography.base,
      cursorColor: colorScheme.primary,
      cursorErrorColor: colorScheme.error,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: input_dec_bordered.copyWith(
        label: const Text('Mật khẩu'),
        hintText: "Mật khẩu",
        errorText: displayError?.message,
      ),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password: password));
      },
      maxLines: 1,
    );
  }
}

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final status = context.select((LoginBloc bloc) {
      final status = bloc.state.status;
      return status;
    });

    if (status.isInProgress) {
      return SizedBox(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: colorScheme.primary),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<LoginBloc>().state.status.isSuccess) {
        context.pushNamed("home");
      }
    });

    return ElevatedButton(
      style: button_style_primary,
      onPressed: () {
        final loginBloc = context.read<LoginBloc>();
        loginBloc.state.isValid ? loginBloc.add(const LoginSubmitted()) : null;
      },
      child: const Text("Đăng nhập"),
    );
  }
}
