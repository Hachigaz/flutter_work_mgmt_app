import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/commons/providers/blocs/theme/presets/presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:forui/forui.dart';

part "theme_event.dart";
part "theme_state.dart";

typedef ThemeSet = ({FThemeData light, FThemeData dark});

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required ThemeSet initialTheme, required bool isModeLight})
    : super(
        ThemeState(currentThemeSet: initialTheme, isModeLight: isModeLight),
      ) {
    on<ThemeEventChangeTheme>(_onChangeTheme);
    on<ThemeEventChangeMode>(_onChangeMode);
  }

  void _showLoadingDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        });
        return FDialog(
          direction: Axis.horizontal,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vui lòng chờ",
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              const LoadingCircleWidget(),
            ],
          ),
          // body: const Text(
          //   'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
          // ),
          actions: [],
        );
      },
    );
  }

  Future<void> _onChangeTheme(
    ThemeEventChangeTheme event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      ThemeStateLoading(
        currentThemeSet: state.currentThemeSet,
        isModeLight: state.isModeLight,
      ),
    );
    _showLoadingDialog(event.context);

    final themeSet = await Future.delayed(Duration(seconds: 2), () {
      return event.themeSet;
    });

    emit(ThemeState(currentThemeSet: themeSet, isModeLight: state.isModeLight));
  }

  Future<void> _onChangeMode(
    ThemeEventChangeMode event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      ThemeStateLoading(
        currentThemeSet: state.currentThemeSet,
        isModeLight: state.isModeLight,
      ),
    );
    _showLoadingDialog(event.context);

    final isModeLight = await Future.delayed(Duration(seconds: 2), () {
      return event.isModeLight;
    });

    emit(
      ThemeState(
        currentThemeSet: state.currentThemeSet,
        isModeLight: isModeLight,
      ),
    );
  }
}
