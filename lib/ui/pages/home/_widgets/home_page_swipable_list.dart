import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/color/color_helpers.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/style_presets/common_presets.dart';

class _HomePageSwipableListItem extends StatelessWidget {
  final String _title;
  final String _description;
  final String _extra;
  final Widget _image;

  const _HomePageSwipableListItem({
    required String title,
    required String description,
    required String extra,
    required Widget image,
  }) : _title = title,
       _description = description,
       _extra = extra,
       _image = image;

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorShift(
          color: colorScheme.background,
          r: 6,
          g: 6,
          b: 6,
        ).withAlpha(120),
        border: Border.all(
          color: colorShift(
            color: colorScheme.foreground,
            r: 30,
            g: 30,
            b: 30,
          ).withAlpha(120),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: padding_2xl,
          horizontal: padding_2xl,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: padding_md),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: _image,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: padding_md),
                    child: Text(
                      _title,
                      style: typography.sm.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.foreground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding_md),
                    child: Text(
                      _description,
                      style: typography.sm.copyWith(
                        color: colorScheme.foreground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding_md),
                    child: Text(
                      _extra,
                      style: typography.sm.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorShift(color: colorScheme.foreground, g: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageSwipableList extends StatelessWidget {
  const HomePageSwipableList({super.key});

  @override
  Widget build(BuildContext context) {
    return PageListSection(
      labelText: "Bảng tin mời thầu",
      child: SizedBox(
        height: 100.h,
        child: SwipableListView(
          children: [
            _HomePageSwipableListItem(
              title: "Thông báo mời thầu",
              description: "Hợp tác thân thiện - phát triển bền vững",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/cover.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo mời thầu",
              description: "Hợp tác thân thiện - phát triển bền vững",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/cover.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo mời thầu",
              description: "Hợp tác thân thiện - phát triển bền vững",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/cover.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo mời thầu",
              description: "Hợp tác thân thiện - phát triển bền vững",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/cover.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
