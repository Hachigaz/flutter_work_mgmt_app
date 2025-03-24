import 'package:flutter/widgets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:forui/forui.dart';

class PageListSection extends StatelessWidget {
  final Widget _child;
  final String _labelText;
  final Widget? _label;

  const PageListSection({
    super.key,
    String labelText = "",
    Widget? label,
    required Widget child,
  }) : _labelText = labelText,
       _label = label,
       _child = child;
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: padding_lg),
          child:
              _label ??
              Text(
                _labelText,
                style: typography.base.copyWith(fontWeight: FontWeight.w600),
              ),
        ),
        _child,
      ],
    );
  }
}
