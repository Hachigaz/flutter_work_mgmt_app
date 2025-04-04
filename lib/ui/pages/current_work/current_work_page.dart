import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_work_mgmt_app/data/models/reports.dart';
import 'package:flutter_work_mgmt_app/data/repositories/data_repository.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/presets/date_formats.dart';
import 'package:flutter_work_mgmt_app/providers/ui/blocs/theme/theme_bloc.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_items/report_schedule_display_item_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/components/list_view/list_view_widget.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/consts/padding_defs.dart';
import 'package:flutter_work_mgmt_app/ui/commons/utils/helpers/datetime.dart';
import 'package:flutter_work_mgmt_app/ui/pages/current_work/_bloc/current_work_page_bloc.dart';
import 'package:forui/forui.dart';

class _CurrrentWorkPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Text(
              "Lịch báo cáo",
              style: typography.xl2.copyWith(fontWeight: FontWeight.w700),
            ),
            _CurrentWorkPageHeaderCalendar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: _CurrentWorkReportListWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentWorkPageHeaderCalendar extends StatefulWidget {
  const _CurrentWorkPageHeaderCalendar();

  @override
  State<StatefulWidget> createState() {
    return _CurrentWorkPageHeaderCalendarState();
  }
}

class _CurrentWorkPageHeaderCalendarState
    extends State<_CurrentWorkPageHeaderCalendar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      7,
      (_) => AnimationController(vsync: this),
    );
    context.read<CurrentWorkPageBloc>().calendarController.addListener(() {
      setState(() {});
      for (final anim in _animationControllers) {
        anim.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    for (final anim in _animationControllers) {
      anim.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Container(), _CalendarHeaderDisplay(), Container()],
          ),
        ),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final date in getCurrentWeek(
              date: context.read<CurrentWorkPageBloc>().state.selectedDate,
            ))
              Expanded(
                child: BlocBuilder<CurrentWorkPageBloc, CurrentWorkPageState>(
                      builder: (context, state) {
                        return _WeekdayDisplayItem(
                          date: date,
                          isAvailable:
                              Random().nextInt(40) % 2 == 1 ? true : false,
                        );
                      },
                    )
                    .animate(
                      controller: _animationControllers[date.weekday - 1],
                      delay: Duration(milliseconds: date.weekday * 100),
                    )
                    .slideY(
                      curve: Curves.easeInOutCubicEmphasized,
                      duration: Duration(milliseconds: 300),
                    )
                    .fadeIn(
                      curve: Curves.easeInOutCubicEmphasized,
                      duration: Duration(milliseconds: 300),
                    ),
              ),
          ],
        ),
      ],
    );
  }
}

class _CalendarHeaderDisplay extends StatefulWidget {
  const _CalendarHeaderDisplay();
  @override
  State<StatefulWidget> createState() {
    return _CalendarHeaderDisplayState();
  }
}

class _CalendarHeaderDisplayState extends State<_CalendarHeaderDisplay>
    with SingleTickerProviderStateMixin {
  late FPopoverController _popoverController;

  @override
  void initState() {
    super.initState();
    _popoverController = FPopoverController(vsync: this);
  }

  @override
  void dispose() {
    _popoverController.dispose();
    context.read<CurrentWorkPageBloc>().calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;

    return Column(
      children: [
        FPopover(
          controller: _popoverController,
          popoverBuilder: (context, value, child) {
            return FCalendar(
              controller:
                  context.read<CurrentWorkPageBloc>().calendarController,
              // today: context.read<CurrentWorkPageBloc>().state.selectedDate,
              onPress: (value) {
                context.read<CurrentWorkPageBloc>().calendarController.value =
                    value;
                context.read<CurrentWorkPageBloc>().add(
                  CurrentWorkPageEventChangeCalendar(selectedDate: value),
                );
                _popoverController.toggle();
              },
              style: context.theme.calendarStyle.copyWith(
                headerStyle: context.theme.calendarStyle.headerStyle.copyWith(
                  headerTextStyle: typography.base.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          },
          child: FTappable.animated(
            onPress: () {
              _popoverController.toggle();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<CurrentWorkPageBloc, CurrentWorkPageState>(
                builder: (context, state) {
                  return Text(
                    "Ngày ${state.selectedDate.day} Tháng ${state.selectedDate.month}, ${state.selectedDate.year}",
                    style: typography.xl.copyWith(fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeekdayDisplayItem extends StatelessWidget {
  final DateTime date;
  final bool isAvailable;

  const _WeekdayDisplayItem({required this.date, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    return FTappable.animated(
      onPress:
          isAvailable
              ? () {
                context.read<CurrentWorkPageBloc>().add(
                  CurrentWorkPageEventChangeWeekday(selectedDate: date),
                );
              }
              : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        color:
            isAvailable
                ? date == context.read<CurrentWorkPageBloc>().state.selectedDate
                    ? colorScheme.primary.lighter(20).withAlpha(80)
                    : colorScheme.primary.withAlpha(80)
                : colorScheme.muted.withAlpha(200),
        child: Column(
          children: [
            Text(
              date.weekday != 7 ? "T${date.weekday + 1}" : "CN",
              style: typography.base,
            ),
            Text(
              "${date.day}",
              style: typography.xl2.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              "Th.${date.month}",
              style: typography.sm.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentWorkReportListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colorScheme = context.theme.colorScheme;
    final scrollController = ScrollController();
    return ListViewWidget<ReportScheduleRecord>(
      scrollController: scrollController,
      listBloc: context.read<CurrentWorkPageBloc>().listViewBloc,
      listBuilder: (itemList) {
        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(top: 10),
          // itemCount: itemList.length,
          itemCount: 2,
          itemBuilder: (
            BuildContext context,
            int index,
            // Animation<double> animation,
          ) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ReportScheduleListItemWidget(schedule: itemList[index]),
            );
          },
        ).animate().slideX(curve: Curves.easeInOutCubicEmphasized);
      },
    );
  }
}

// class _CurrentWorkPageNavbar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.theme.colorScheme;
//     return DefaultTabController(
//       length: 4,
//       child: Column(
//         children: [
//           Builder(
//             builder: (context) {
//               return GNav(
//                 rippleColor: Colors.grey.withAlpha(
//                   150,
//                 ), // tab button ripple color when pressed
//                 hoverColor: Colors.grey.withAlpha(
//                   180,
//                 ), // tab button hover color
//                 haptic: true, // haptic feedback
//                 tabBorderRadius: 15,
//                 tabActiveBorder: Border.all(
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   width: 1,
//                 ), // tab button border
//                 tabShadow: [], // tab button shadow
//                 curve: Curves.easeInOutCubic, // tab animation curves
//                 duration: Duration(milliseconds: 200), // tab animation duration
//                 gap: 8, // the tab button gap between icon and text
//                 color: colorScheme.foreground.withAlpha(
//                   180,
//                 ), // unselected icon color
//                 activeColor:
//                     colorScheme.foreground, // selected icon and text color
//                 iconSize: 24, // tab button icon size
//                 tabBackgroundColor: colorScheme.primary.withAlpha(120),
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 tabs: [
//                   GButton(icon: Icons.group, text: 'Đang hoạt động'),
//                   GButton(icon: Icons.group, text: 'Trễ hạn'),
//                   GButton(icon: Icons.home, text: 'Sắp tới'),
//                   GButton(icon: Icons.access_time_sharp, text: 'Profile'),
//                 ],
//                 onTabChange: (value) {
//                   DefaultTabController.of(context).animateTo(value);
//                 },
//               );
//             },
//           ),
//           Expanded(
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(), // Disable swipe
//               children: [
//                 Container(
//                   color: Colors.blue.withAlpha(150),
//                   child: Column(children: []),
//                 ),
//                 Container(
//                   color: Colors.red.withAlpha(20),
//                   child: Column(children: []),
//                 ),
//                 Container(
//                   color: Colors.green.withAlpha(70),
//                   child: Column(children: []),
//                 ),
//                 Container(
//                   color: Colors.yellow.withAlpha(120),
//                   child: Column(children: []),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CurrentWorkPage extends StatelessWidget {
  const CurrentWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return BlocProvider(
      create:
          (context) => CurrentWorkPageBloc(
            scheduleRepo: context.read<DataRepository<ReportScheduleRecord>>(),
          ),
      child: Container(
        padding: EdgeInsets.only(top: status_bar_offset),
        width: double.infinity,
        height: double.infinity,
        color: colorScheme.background,
        child: _CurrrentWorkPageContent(),
      ),
    );
  }
}
