import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class _CurrrentWorkPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CurrentWorkPage extends StatelessWidget {
  const CurrentWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorScheme.background,
      child: _CurrrentWorkPageContent(),
    );
  }
}
