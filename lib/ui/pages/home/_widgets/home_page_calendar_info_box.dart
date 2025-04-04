import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:forui/forui.dart';

class _HomePageCalendarInfoBox extends StatelessWidget {
  final String _title;
  final String _info;
  final double _boxWidth;

  const _HomePageCalendarInfoBox({
    required String title,
    required String info,
    required double boxWidth,
  }) : _title = title,
       _info = info,
       _boxWidth = boxWidth;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;

    return SizedBox(
      width: _boxWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorShift(
              color: colorScheme.foreground,
              r: 30,
              g: 30,
              b: 30,
            ).withAlpha(200),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: padding_lg,
            bottom: padding_lg,
            left: padding_xl,
            right: padding_5xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: typography.sm.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _info,
                style: typography.xl.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageCalendarInfoSection extends StatelessWidget {
  const HomePageCalendarInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageListSection(
      labelText: "Sắp lịch",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _HomePageCalendarInfoBox(
            title: "Tổng công việc đã sắp xếp",
            info: "25",
            boxWidth: 150.w,
          ),
          _HomePageCalendarInfoBox(
            title: "Tổng công việc chưa sắp xếp",
            info: "10",
            boxWidth: 150.w,
          ),
        ],
      ),
    );
  }
}
