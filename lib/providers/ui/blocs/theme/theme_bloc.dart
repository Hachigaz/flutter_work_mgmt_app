import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/repos/storage_repo.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/loading_widgets/loading_circle_widget.dart';
import 'package:forui/forui.dart';

part "theme_event.dart";
part "theme_state.dart";

typedef ThemeSet = ({FThemeData light, FThemeData dark});

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static final Map<String, (ThemeSet, Color)> appThemes = {
    "Đỏ": (FThemes.red, Colors.red),
    "Vàng": (FThemes.yellow, Colors.yellow),
    "Cam": (FThemes.orange, Colors.orange),
    "Xám nhạt": (FThemes.slate, Colors.blueGrey),
    "Tím": (FThemes.violet, Colors.purpleAccent),
    "Xanh lá": (FThemes.green, Colors.greenAccent),
    "Đỏ hồng": (FThemes.rose, Colors.redAccent),
    "Xám đậm": (FThemes.zinc, Colors.grey),
  };
  final StorageRepository _storageRepo;
  ThemeBloc({required StorageRepository storageRepo})
    : _storageRepo = storageRepo,
      super(
        ThemeState(
          currentThemeSet:
              ThemeBloc
                  .appThemes[storageRepo.localPrefs.getString("appThemeName")]
                  ?.$1 ??
              appThemes["Đỏ"]!.$1,
          appThemeMode: storageRepo.localPrefs.getBool("appThemeMode") ?? false,
        ),
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
        appThemeMode: state.appThemeMode,
      ),
    );
    _showLoadingDialog(event.context);

    final appThemeName = await Future.delayed(Duration(seconds: 2), () {
      return event.themeName;
    });

    _storageRepo.localPrefs.setString("appThemeName", appThemeName);

    emit(
      ThemeState(
        currentThemeSet: ThemeBloc.appThemes[appThemeName]!.$1,
        appThemeMode: state.appThemeMode,
      ),
    );
  }

  Future<void> _onChangeMode(
    ThemeEventChangeMode event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      ThemeStateLoading(
        currentThemeSet: state.currentThemeSet,
        appThemeMode: state.appThemeMode,
      ),
    );
    _showLoadingDialog(event.context);

    final appThemeMode = await Future.delayed(Duration(seconds: 2), () {
      return event.appThemeMode;
    });

    _storageRepo.localPrefs.setBool("appThemeMode", appThemeMode);

    emit(
      ThemeState(
        currentThemeSet: state.currentThemeSet,
        appThemeMode: appThemeMode,
      ),
    );
  }
}
