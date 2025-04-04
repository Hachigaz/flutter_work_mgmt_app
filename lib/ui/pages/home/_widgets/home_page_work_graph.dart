import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:forui/forui.dart';

class __HomePageWorkGraphItem extends StatelessWidget {
  final String _label;
  final double _value;
  final double _max_value;
  final Color _color;

  const __HomePageWorkGraphItem({
    required String label,
    required double value,
    required double max_value,
    required Color color,
  }) : _label = label,
       _value = value,
       _max_value = max_value,
       _color = color;

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    const maxGraphHeight = 200.0;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: padding_md),
            child: Text(
              _label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: typography.sm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
                color: colorShift(
                  color: colorScheme.foreground,
                  r: 30,
                  g: 30,
                  b: 30,
                ).withAlpha(150),
              ),
            ),
          ),
          SizedBox(
            height: maxGraphHeight,
            child: Align(
              alignment: Alignment(0, 1),
              child: ColoredBox(
                color: _color.withAlpha(150),
                child: SizedBox(
                  width: double.infinity,
                  height: maxGraphHeight * _value / _max_value,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _value.toStringAsFixed(0),
                style: typography.base
                    .copyWith(fontWeight: FontWeight.w800)
                    .copyWith(color: colorScheme.foreground),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePageWorkGraph extends StatelessWidget {
  const _HomePageWorkGraph();

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return PageListSection(
      label: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(
              Icons.grading_sharp,
              size: 20,
              color: colorScheme.primary.withAlpha(180),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Text(
              "Tổng quan công việc",
              style: typography.sm.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Tooltip(
            message: "Công việc đã thực hiện",
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            textStyle: typography.base,
            waitDuration: Duration(milliseconds: 500),
            showDuration: Duration(seconds: 2),
            child: Icon(
              Icons.info,
              size: 13,
              color: colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: padding_2xl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            __HomePageWorkGraphItem(
              label: 'Đã thực hiện trong năm\n',
              value: 90,
              max_value: 100,
              color: const Color.fromARGB(177, 86, 144, 88),
            ),
            __HomePageWorkGraphItem(
              label: 'Thực hiện đúng hạn\n',
              value: 80,
              max_value: 100,
              color: const Color.fromARGB(255, 93, 195, 96),
            ),
            __HomePageWorkGraphItem(
              label: 'Công việc đang hoạt động\n',
              value: 60,
              max_value: 100,
              color: const Color.fromARGB(172, 100, 179, 195),
            ),
            __HomePageWorkGraphItem(
              label: 'Công việc trễ hạn\n',
              value: 4,
              max_value: 100,
              color: const Color.fromARGB(255, 175, 97, 76),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageRevenueGraph extends StatelessWidget {
  const HomePageRevenueGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.foreground.withAlpha(80)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding_lg,
          vertical: padding_lg,
        ),
        child: _HomePageWorkGraph(),
      ),
    );
  }
}
