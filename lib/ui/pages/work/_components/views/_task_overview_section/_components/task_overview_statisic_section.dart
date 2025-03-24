import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';

class TaskOverviewStatisticSection extends StatelessWidget {
  const TaskOverviewStatisticSection({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    // final colorScheme = context.theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng công việc:",
                    style: typography.base.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "30",
                    style: typography.base.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Đang thực hiện:",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "10",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hoàn thành:",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "10",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trễ hạn:",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "10",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _TaskOverviewStatisticChart(),
      ],
    );
  }
}

class _TaskOverviewStatisticChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskOverviewStatisticChartState();
  }
}

class _TaskOverviewStatisticChartState
    extends State<_TaskOverviewStatisticChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double animationMaxVal = 1000;
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.r,
            height: 150.r,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: animationMaxVal),
              curve: Curves.easeInOutExpo,
              duration: Duration(milliseconds: 1000),
              builder: (context, angle, child) {
                final animationOffset = angle / animationMaxVal;
                return PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 33.3 * animationOffset,
                        color: Colors.blue,
                        radius: 25.r,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 33.3 * animationOffset,
                        color: const Color.fromARGB(255, 101, 254, 111),
                        radius: 25.r,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 33.3,
                        color: const Color.fromARGB(255, 254, 86, 86),
                        radius: 25.r * animationOffset,
                        showTitle: false,
                      ),
                    ],
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
