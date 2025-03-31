import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:formz/formz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_work_mgmt_app/ui/pages/login/components/login_box/bloc/login_bloc.dart';

class LoginUsernameTextField extends StatelessWidget {
  const LoginUsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError,
    );
    final presets = context.read<ThemeBloc>().state.presets;
    return TextField(
      style: typography.base,
      cursorColor: colorScheme.primary,
      cursorErrorColor: colorScheme.error,
      keyboardType: TextInputType.text,
      decoration: presets.input_dec_rounded_border.copyWith(
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
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );
    final presets = context.read<ThemeBloc>().state.presets;
    return TextField(
      style: typography.base,
      cursorColor: colorScheme.primary,
      cursorErrorColor: colorScheme.error,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: presets.input_dec_rounded_border.copyWith(
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
    // final colorScheme = context.theme.colorScheme;
    final presets = context.read<ThemeBloc>().state.presets;

    final loginBloc = context.watch<LoginBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<LoginBloc>().state.status.isSuccess) {
        context.pushNamed("home");
      }
    });

    return loginBloc.state.status.isInProgress
        ? LoadingCircleWidget()
        : ElevatedButton(
          style: presets.button_style_primary_rounded,
          onPressed: () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
          child: const Text("Đăng nhập"),
        );
  }
}
