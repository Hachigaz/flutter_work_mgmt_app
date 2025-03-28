import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class LoadingTextDisplayWidget extends StatefulWidget {
  final String? displayMessage;
  final TextStyle? textStyle;
  const LoadingTextDisplayWidget({
    super.key,
    this.displayMessage,
    this.textStyle,
  });

  @override
  State<StatefulWidget> createState() {
    return _LoadingTextDisplayWidgetState();
  }
}

class _LoadingTextDisplayWidgetState extends State<LoadingTextDisplayWidget> {
  final ValueNotifier<int> textDotCounter = ValueNotifier<int>(1);
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      textDotCounter.value = (textDotCounter.value + 1) % 4;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: textDotCounter,
        builder: (context, value, child) {
          return Text(
            "${widget.displayMessage ?? "Đang tải"}${"." * textDotCounter.value}",
            style: widget.textStyle ?? context.theme.typography.base,
          );
        },
      ),
    );
  }
}
