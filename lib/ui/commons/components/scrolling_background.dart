import 'package:flutter/material.dart';

class ScrollingBackgroundWidget extends StatelessWidget {
  final Widget _child;
  final Widget _background;
  final ScrollController _scrollController;
  final ValueNotifier<double> backgroundOffset = ValueNotifier(0);

  ScrollingBackgroundWidget({
    super.key,
    required Widget child,
    required Widget background,
    required ScrollController scrollController,
  }) : _child = child,
       _background = background,
       _scrollController = scrollController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment(0, -1.0),
          child: ValueListenableBuilder<double>(
            valueListenable: backgroundOffset,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(0, offset), // Move shape based on scroll
                child: _background,
              );
            },
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            backgroundOffset.value = -_scrollController.position.pixels;
            return true;
          },
          child: _child,
        ),
      ],
    );
  }
}
