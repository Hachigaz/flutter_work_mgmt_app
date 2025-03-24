part of "theme_bloc.dart";

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ThemeEventChangeTheme extends ThemeEvent {
  final ThemeSet themeSet;
  final BuildContext context;

  const ThemeEventChangeTheme({required this.context, required this.themeSet});

  @override
  List<Object?> get props => [super.props, themeSet];
}

class ThemeEventChangeMode extends ThemeEvent {
  final bool isModeLight;
  final BuildContext context;

  const ThemeEventChangeMode({
    required this.context,
    required this.isModeLight,
  });

  @override
  List<Object?> get props => [super.props, isModeLight];
}
