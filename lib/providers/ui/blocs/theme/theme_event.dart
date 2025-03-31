part of "theme_bloc.dart";

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ThemeEventChangeTheme extends ThemeEvent {
  final String themeName;
  final BuildContext context;

  const ThemeEventChangeTheme({required this.context, required this.themeName});

  @override
  List<Object?> get props => [...super.props, themeName];
}

class ThemeEventChangeMode extends ThemeEvent {
  final bool appThemeMode;
  final BuildContext context;

  const ThemeEventChangeMode({
    required this.context,
    required this.appThemeMode,
  });

  @override
  List<Object?> get props => [...super.props, appThemeMode];
}
