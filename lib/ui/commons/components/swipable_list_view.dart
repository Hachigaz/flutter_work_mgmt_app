import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/defs/const_defs.dart';

class SwipableListView extends StatelessWidget {
  final List<Widget> _children;
  final double viewportFraction;

  const SwipableListView({
    super.key,
    required List<Widget> children,
    this.viewportFraction = 0.8,
  }) : _children = children;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;
        return PageView.builder(
          controller: PageController(viewportFraction: viewportFraction),
          itemCount: _children.length,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(-parentWidth * (1.0 - viewportFraction) / 2, 0),
              child: Padding(
                padding: EdgeInsets.only(right: padding_lg),
                child: _children[index],
              ),
            );
          },
        );
      },
    );
  }
}
