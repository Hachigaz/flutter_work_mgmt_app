part of "theme_bloc.dart";

class ThemeState extends Equatable {
  final ThemeSet currentThemeSet;
  final bool appThemeMode;
  final ThemePresets presets;

  ThemeState({required this.currentThemeSet, required this.appThemeMode})
    : presets = ThemePresets(
        appThemeMode ? currentThemeSet.light : currentThemeSet.dark,
      );

  @override
  List<Object?> get props => [];
}

class ThemeStateLoading extends ThemeState {
  ThemeStateLoading({
    required super.currentThemeSet,
    required super.appThemeMode,
  });
}
