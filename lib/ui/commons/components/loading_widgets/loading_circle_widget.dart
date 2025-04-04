import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class LoadingCircleWidget extends StatelessWidget {
  final Color? circleColor;

  const LoadingCircleWidget({super.key, this.circleColor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: circleColor ?? colorScheme.secondaryForeground,
        ),
      ),
    );
  }
}
