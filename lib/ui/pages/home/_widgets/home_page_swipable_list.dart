import 'package:flutter/material.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/color_helpers.dart';
import 'package:forui/forui.dart';

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
    final colorScheme = context.theme.colorScheme;
    final typography = context.theme.typography;
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: SizedBox(
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double size =
                          constraints.maxHeight; // Get max parent height

                      return SizedBox(
                        width: size, // Set width same as height
                        height: size,
                        child: FittedBox(fit: BoxFit.cover, child: _image),
                      );
                    },
                  ),
                ),
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
                      maxLines: 2,
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
                      maxLines: 3,
                      style: typography.sm.copyWith(
                        color: colorScheme.foreground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: padding_md),
                    child: Text(
                      _extra,
                      maxLines: 1,
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
      labelText: "Bảng tin công việc",
      child: SizedBox(
        height: 160,
        child: SwipableListView(
          viewportFraction: 0.85,
          children: [
            _HomePageSwipableListItem(
              title: "Thông báo thay đổi lịch công việc\n",
              description: "Lịch công việc thay đổi\n\n",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/calendar.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo thay đổi lịch công việc\n",
              description: "Lịch công việc thay đổi\n\n",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/calendar.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo thay đổi lịch công việc\n",
              description: "Lịch công việc thay đổi\n\n",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/calendar.jpg"),
            ),
            _HomePageSwipableListItem(
              title: "Thông báo thay đổi lịch công việc\n",
              description: "Lịch công việc thay đổi\n\n",
              extra: "Trạng thái: Mới",
              image: Image.asset("assets/images/calendar.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
