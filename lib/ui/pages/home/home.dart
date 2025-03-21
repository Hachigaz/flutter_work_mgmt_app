import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/page_list_section.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/scrolling_background.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/swipable_list_view.dart';
import 'package:flutter_work_mgmt_app/ui/commons/defs/const_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/helpers/colors.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/box_shadow_presets.dart';
import 'package:flutter_work_mgmt_app/ui/commons/presets/common_presets.dart';

class _HomePageRevenueGraphItem extends StatelessWidget {
  final String _label;
  final double _value;
  final double _max_value;
  final Color _color;

  const _HomePageRevenueGraphItem({
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
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;

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
          Padding(
            padding: EdgeInsets.only(bottom: padding_3xl),
            child: Text(
              "${_value.toStringAsFixed(1)} Triệu",
              style: typography.base
                  .copyWith(fontWeight: FontWeight.w600)
                  .copyWith(color: colorScheme.foreground),
            ),
          ),
          SizedBox(
            height: 100.h,
            child: Align(
              alignment: Alignment(0, 1),
              child: ColoredBox(
                color: _color.withAlpha(150),
                child: SizedBox(
                  width: double.infinity,
                  height: 100.h * _value / _max_value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePageToolbarIcon extends StatelessWidget {
  final IconData _icon;
  final String _label;
  final bool _hasNotification;

  const _HomePageToolbarIcon({
    required IconData icon,
    required String label,
    bool hasNotification = false,
  }) : _icon = icon,
       _label = label,
       _hasNotification = hasNotification;

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

    return Column(
      children: [
        Transform.translate(
          offset: Offset(18, 5),
          child: SizedBox(
            width: 10,
            height: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color:
                    (_hasNotification)
                        ? Colors.red
                        : const Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding_md),
            child: Icon(_icon, color: colorScheme.foreground),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: padding_md),
          child: Text(
            _label,
            style: typography.sm.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

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
    final colorScheme = appThemeData.colorScheme;
    final typography = appThemeData.typography;

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

class _HomePageAppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Môi trường ",
                  style: typography.xl.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: "Á Châu",
                  style: typography.xl.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: padding_lg),
        Align(
          alignment: Alignment(-0.8, 0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Xin chào, \n",
                      style: typography.xl.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "Á Châu",
                      style: typography.xl.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomePageContent extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final typography = appThemeData.typography;
    final colorScheme = appThemeData.colorScheme;
    final sectionPadding = padding_3xl;
    return ScrollingBackgroundWidget(
      scrollController: _scrollController,
      background: Image.asset("assets/images/app-background.jpg"),
      child: Padding(
        padding: EdgeInsets.only(
          top: status_bar_offset,
          left: padding_3xl,
          right: padding_3xl,
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            _HomePageAppTitle(),
            SizedBox(height: spacing_4xl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding_md),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [style_box_shadow_default_small],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding_md),
                  child: TextField(
                    style: typography.base,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tìm kiếm nội dung",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.display_settings_sharp),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: padding_6xl),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.foreground.withAlpha(80)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding_lg,
                  vertical: padding_lg,
                ),
                child: PageListSection(
                  label: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.monetization_on_sharp,
                          size: 20,
                          color: colorScheme.primary.withAlpha(180),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(
                          "Doanh thu và công nợ",
                          style: typography.sm.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Tooltip(
                        message: "Thông tin doanh thu công nợ",
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
                        _HomePageRevenueGraphItem(
                          label: 'Doanh thu hôm qua',
                          value: 90,
                          max_value: 100,
                          color: const Color.fromARGB(177, 86, 144, 88),
                        ),
                        _HomePageRevenueGraphItem(
                          label: 'Doanh thu hôm nay',
                          value: 80,
                          max_value: 100,
                          color: const Color.fromARGB(255, 93, 195, 96),
                        ),
                        _HomePageRevenueGraphItem(
                          label: 'Công nợ đã thanh toán',
                          value: 10,
                          max_value: 100,
                          color: const Color.fromARGB(172, 100, 179, 195),
                        ),
                        _HomePageRevenueGraphItem(
                          label: 'Công nợ chưa thanh toán',
                          value: 40,
                          max_value: 100,
                          color: const Color.fromARGB(255, 175, 97, 76),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: padding_4xl),
            PageListSection(
              labelText: "Công cụ",
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                children: [
                  _HomePageToolbarIcon(
                    icon: CupertinoIcons.calendar,
                    label: "Sắp lịch",
                    hasNotification: true,
                  ),
                  _HomePageToolbarIcon(
                    icon: Icons.receipt_long,
                    label: "Đã thu gom",
                    hasNotification: true,
                  ),
                  _HomePageToolbarIcon(
                    icon: CupertinoIcons.profile_circled,
                    label: "Năng lực",
                  ),
                  _HomePageToolbarIcon(
                    icon: CupertinoIcons.car_detailed,
                    label: "Vi phạm",
                    hasNotification: true,
                  ),
                  _HomePageToolbarIcon(
                    icon: CupertinoIcons.profile_circled,
                    label: "Tài xế",
                  ),
                  _HomePageToolbarIcon(
                    icon: Icons.fire_truck,
                    label: "Quản lý xe",
                  ),
                  _HomePageToolbarIcon(
                    icon: Icons.speed,
                    label: "Định mức",
                    hasNotification: true,
                  ),
                  _HomePageToolbarIcon(
                    icon: Icons.receipt_long,
                    label: "Hợp đồng",
                  ),
                ],
              ),
            ),
            SizedBox(height: sectionPadding),
            PageListSection(
              labelText: "Sắp lịch",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _HomePageCalendarInfoBox(
                    title: "Tổng lịch đã sắp xếp",
                    info: "25",
                    boxWidth: 150.w,
                  ),
                  _HomePageCalendarInfoBox(
                    title: "Tổng lịch chưa sắp xếp",
                    info: "10",
                    boxWidth: 150.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: sectionPadding),

            PageListSection(
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
            ),
            SizedBox(height: padding_5xl),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = appThemeData.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: _HomePageContent(),
    );
  }
}
